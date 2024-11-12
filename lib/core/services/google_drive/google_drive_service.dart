import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as ga;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:http/io_client.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleHttpClient extends IOClient {
  Map<String, String> _headers;
  GoogleHttpClient(this._headers) : super();
  @override
  Future<IOStreamedResponse> send(http.BaseRequest request) =>
      super.send(request..headers.addAll(_headers));
  @override
  Future<http.Response> head(Uri url, {Map<String, String>? headers}) {
    final Map<String, String> updatedHeaders = {
      ..._headers,
      if (headers != null) ...headers
    };
    return super.head(url, headers: updatedHeaders);
  }
}

class GoogleDriveService {
  final storage = const FlutterSecureStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn =
      GoogleSignIn(scopes: ['https://www.googleapis.com/auth/drive.file']);
  late GoogleSignInAccount googleSignInAccount;
  late ga.FileList list;
  var signedIn = false;
  static const _folderName = "BDReminderBackups";
  Future<bool> isLogin() async {
    return await storage.read(key: "signedIn") == "true" ? true : false;
  }

  // Future<User> getUser() async {
  //   return
  // }
  Future<User?> getUser() async {
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    return userCredential.user;
  }

  Future<void> loginWithGoogle() async {
    signedIn = await storage.read(key: "signedIn") == "true" ? true : false;
    googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? googleSignInAccount) async {
      if (googleSignInAccount != null) {
        await _afterGoogleLogin(googleSignInAccount);
      }
    });
    if (signedIn) {
      try {
        googleSignIn.signInSilently().whenComplete(() => () {});
      } catch (e) {
        storage.write(key: "signedIn", value: "false").then((value) {});
      }
    } else {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        await _afterGoogleLogin(googleSignInAccount);
      }
    }
  }

  Future<void> _afterGoogleLogin(GoogleSignInAccount gSA) async {
    googleSignInAccount = gSA;
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    final User? user = userCredential.user;
    assert(!user!.isAnonymous);
    assert(await user!.getIdToken() != null);
    // final User currentUser = await _auth.currentUser();
    // assert(user!.uid == currentUser.uid);
    print('signInWithGoogle succeeded: $user');
    storage.write(key: "signedIn", value: "true").then((value) {});
  }

  logoutFromGoogle() async {
    googleSignIn.signOut().then((value) {
      print("User Sign Out");
      storage.write(key: "signedIn", value: "false").then((value) {});
    });
  }

  uploadFileToGoogleDrive() async {
    final prefs = await SharedPreferences.getInstance();
    final allPrefs = prefs.getKeys().fold<Map<String, dynamic>>({}, (map, key) {
      map[key] = prefs.get(key);
      return map;
    });
    final jsonData = jsonEncode(allPrefs);
    // Сохранение JSON файла на устройстве
    final tempDir = Directory.systemTemp;
    final formattedDate = DateFormat('ddMMyy').format(DateTime.now());
    final fileName = 'birthdays_reminder_backup_$formattedDate.json';
    final file = File('${tempDir.path}/$fileName');
    await file.writeAsString(jsonData);
    // Аутентификация с помощью Google Sign-In
    var client = GoogleHttpClient(await googleSignInAccount.authHeaders);
    var driveApi = ga.DriveApi(client);
    // Создание или получение ID папки
    final folderId = await _getOrCreateFolderId(driveApi);
    final media = ga.Media(file.openRead(), file.lengthSync());
    final driveFile = ga.File()
      ..name = fileName
      ..parents = [folderId];
    final result = await driveApi.files.create(
      driveFile,
      uploadMedia: media,
    );
    print("Файл загружен в Google Drive: ${result.id}");
  }

  Future<void> restoreBackupFromGoogleDrive() async {
    var client = GoogleHttpClient(await googleSignInAccount.authHeaders);
    var driveApi = ga.DriveApi(client);
    // Получение ID папки
    final folderId = await _getOrCreateFolderId(driveApi);
    // Поиск самого нового файла резервной копии
    final query =
        "'$folderId' in parents and mimeType != 'application/vnd.google-apps.folder' and name contains 'birthdays_reminder_backup_'";
    final fileList = await driveApi.files.list(
      q: query,
      orderBy: 'createdTime desc', // Сортировка по дате создания
      pageSize: 1,
    );
    if (fileList.files == null || fileList.files!.isEmpty) {
      print("Резервные копии не найдены");
      return;
    }
    final backupFile = fileList.files!.first;
    // Загрузка файла резервной копии
    final mediaStream = await driveApi.files.get(
      backupFile.id!,
      downloadOptions: ga.DownloadOptions.fullMedia,
    ) as ga.Media;
    final tempDir = Directory.systemTemp;
    final localFile = File('${tempDir.path}/${backupFile.name}');
    final sink = localFile.openWrite();
    await mediaStream.stream.pipe(sink);
    await sink.close();
    // Чтение JSON-файла и восстановление данных в SharedPreferences
    final jsonData = await localFile.readAsString();
    final Map<String, dynamic> data = jsonDecode(jsonData);
    print(data);
    final prefs = await SharedPreferences.getInstance();
    for (var entry in data.entries) {
      final key = entry.key;
      final value = entry.value;
      if (value is bool) {
        prefs.setBool(key, value);
      } else if (value is int) {
        prefs.setInt(key, value);
      } else if (value is double) {
        prefs.setDouble(key, value);
      } else if (value is String) {
        prefs.setString(key, value);
      } else if (value.cast<String>() is List<String>) {
        prefs.setStringList(key, value.cast<String>());
      }
    }
    print("Резервная копия восстановлена из файла: ${backupFile.name}");
  }

  Future<String> _getOrCreateFolderId(ga.DriveApi driveApi) async {
    try {
      // Поиск папки с заданным именем
      final query =
          "mimeType = 'application/vnd.google-apps.folder' and name = '$_folderName'";
      final fileList = await driveApi.files.list(q: query);
      if (fileList.files != null && fileList.files!.isNotEmpty) {
        // Папка существует, возвращаем её ID
        return fileList.files!.first.id!;
      } else {
        // Папка не существует, создаём новую
        final folder = ga.File()
          ..name = _folderName
          ..mimeType = 'application/vnd.google-apps.folder';
        final createdFolder = await driveApi.files.create(folder);
        return createdFolder.id!;
      }
    } catch (e) {
      print("Ошибка при создании или получении папки: $e");
      rethrow;
    }
  }

  Future<void> downloadGoogleDriveFile(String fName, String gdID) async {
    var client = GoogleHttpClient(await googleSignInAccount.authHeaders);
    var drive = ga.DriveApi(client);
    // Получаем файл с Google Drive
    ga.Media file = await drive.files
        .get(gdID, downloadOptions: ga.DownloadOptions.fullMedia) as ga.Media;
    print(file.stream);
    final directory = await getExternalStorageDirectory();
    print(directory!.path);
    final saveFile = File(
        '${directory.path}/${DateTime.now().millisecondsSinceEpoch}_$fName');
    // Слушаем поток данных и записываем их в файл
    List<int> dataStore = []; // Указываем тип данных для списка
    file.stream.listen((data) {
      // Убедитесь, что тип данных правильный (Uint8List)
      if (data is Uint8List) {
        print("DataReceived: ${data.length}");
        dataStore
            .addAll(data); // Теперь метод addAll доступен для использования
      } else {
        print("Unexpected data type received.");
      }
    }, onDone: () async {
      print("Task Done");
      await saveFile.writeAsBytes(dataStore);
      print("File saved at ${saveFile.path}");
    }, onError: (error) {
      print("Some Error: $error");
    });
  }
}

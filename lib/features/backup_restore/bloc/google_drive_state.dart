import 'package:equatable/equatable.dart';

enum GoogleDriveStatus {
  initial,
  loading,
  success,
  failure,
  loggedOut,
  uploaded,
  downloaded
}

class GoogleDriveState extends Equatable {
  final GoogleDriveStatus status;
  final String? filePath;
  final String? email;
  final String? username;
  final String? uriPhoto;

  final String? errorMessage;
  final bool isLoggedIn;

  const GoogleDriveState({
    this.email,
    this.username,
    this.uriPhoto,
    this.status = GoogleDriveStatus.initial,
    this.filePath,
    this.errorMessage,
    this.isLoggedIn = false,
  });

  @override
  List<Object?> get props => [status, filePath, errorMessage, isLoggedIn];

  GoogleDriveState copyWith({
    GoogleDriveStatus? status,
    String? email,
    String? username,
    String? uriPhoto,
    String? filePath,
    String? errorMessage,
    bool? isLoggedIn,
  }) {
    return GoogleDriveState(
      email: email ?? this.email,
      username: username ?? this.username,
      uriPhoto: uriPhoto ?? this.uriPhoto,
      status: status ?? this.status,
      filePath: filePath ?? this.filePath,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}

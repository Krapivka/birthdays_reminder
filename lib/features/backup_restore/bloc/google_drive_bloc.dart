import 'package:birthdays_reminder/core/services/google_drive/google_drive_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'google_drive_event.dart';
import 'google_drive_state.dart';

class GoogleDriveBloc extends Bloc<GoogleDriveEvent, GoogleDriveState> {
  final GoogleDriveService _googleDriveService;

  GoogleDriveBloc(this._googleDriveService) : super(const GoogleDriveState()) {
    // on<GoogleDriveInitialize>(_onInitialize);
    on<GoogleDriveLogin>(_onLogin);
    on<GoogleDriveLogout>(_onLogout);
    on<GoogleDriveBackup>(_onBackup);
    on<GoogleDriveRestore>(_onRestore);
  }

  void _onLogin(GoogleDriveLogin event, Emitter<GoogleDriveState> emit) async {
    try {
      emit(state.copyWith(status: GoogleDriveStatus.loading));
      await _googleDriveService.loginWithGoogle();
      final User? user = await _googleDriveService.getUser();
      emit(state.copyWith(
        status: GoogleDriveStatus.success,
        isLoggedIn: true,
        username: user!.displayName,
        email: user.email,
        uriPhoto: user.photoURL,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: GoogleDriveStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onLogout(
      GoogleDriveLogout event, Emitter<GoogleDriveState> emit) async {
    emit(state.copyWith(status: GoogleDriveStatus.loading));
    try {
      await _googleDriveService.logoutFromGoogle();
      emit(state.copyWith(
        status: GoogleDriveStatus.loggedOut,
        isLoggedIn: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: GoogleDriveStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onBackup(
      GoogleDriveBackup event, Emitter<GoogleDriveState> emit) async {
    emit(state.copyWith(status: GoogleDriveStatus.loading));
    try {
      await _googleDriveService.uploadFileToGoogleDrive();
      //TODO: НАписать метод сохранения данных из localStorage в Google Drive в json
      emit(state.copyWith(
        status: GoogleDriveStatus.uploaded,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: GoogleDriveStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onRestore(
      GoogleDriveRestore event, Emitter<GoogleDriveState> emit) async {
    emit(state.copyWith(status: GoogleDriveStatus.loading));
    try {
      //TODO: НАписать метод восстановления данных
      await _googleDriveService.restoreBackupFromGoogleDrive();
      emit(state.copyWith(
        status: GoogleDriveStatus.downloaded,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: GoogleDriveStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}

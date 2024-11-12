import 'package:equatable/equatable.dart';

abstract class GoogleDriveEvent extends Equatable {
  const GoogleDriveEvent();

  @override
  List<Object?> get props => [];
}

class GoogleDriveInitialize extends GoogleDriveEvent {}

class GoogleDriveLogin extends GoogleDriveEvent {}

class GoogleDriveLogout extends GoogleDriveEvent {}

class GoogleDriveBackup extends GoogleDriveEvent {}

class GoogleDriveRestore extends GoogleDriveEvent {}

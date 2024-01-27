part of 'birthdays_list_bloc.dart';

sealed class BirthdaysListEvent extends Equatable {
  const BirthdaysListEvent();

  @override
  List<Object?> get props => [];
}

class LoadBirthdaysListEvent extends BirthdaysListEvent {
  const LoadBirthdaysListEvent({this.completer});
  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}

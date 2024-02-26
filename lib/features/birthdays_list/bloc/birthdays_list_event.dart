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

class DeletePersonBirthdaysListEvent extends BirthdaysListEvent {
  const DeletePersonBirthdaysListEvent();
  @override
  List<Object?> get props => [];
}

class SearchBirthdaysListEvent extends BirthdaysListEvent {
  const SearchBirthdaysListEvent({required this.query});
  final String query;

  @override
  List<Object?> get props => [query];
}

class LongPressBirthdayCardEvent extends BirthdaysListEvent {
  const LongPressBirthdayCardEvent({required this.id});
  final int id;

  @override
  List<Object?> get props => [id];
}

class TapBirthdayCardEvent extends BirthdaysListEvent {
  const TapBirthdayCardEvent({required this.id});
  final int id;

  @override
  List<Object?> get props => [id];
}

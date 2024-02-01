part of 'birthdays_list_bloc.dart';

sealed class BirthdaysListState extends Equatable {
  const BirthdaysListState();
  @override
  List<Object> get props => [];
}

class BirthdaysListInitial extends BirthdaysListState {}

class BirthdaysListLoading extends BirthdaysListState {}

class BirthdaysListLoaded extends BirthdaysListState {
  const BirthdaysListLoaded({required this.listPersonModel});

  final List<PersonModel> listPersonModel;

  @override
  List<Object> get props => [listPersonModel];
}

class BirthdaysListFailure extends BirthdaysListState {}

class SearchBirthdaysListEmpty extends BirthdaysListState {}

class SearchBirthdaysListLoaded extends BirthdaysListState {
  SearchBirthdaysListLoaded({required this.sortedListPersonModel});

  final List<PersonModel> sortedListPersonModel;

  @override
  List<Object> get props => [sortedListPersonModel];
}

part of 'birthdays_list_bloc.dart';

enum BirthdaysListStatus {
  initial,
  loading,
  loaded,
  searchLoaded,
  failure,
  selectedBirthdaysDeleted
}

class BirthdaysListState {
  const BirthdaysListState({
    required this.birthdayListStatus,
    required this.listPersonModel,
    required this.selectedPersonId,
    required this.sortedListPersonModel,
  });

  final BirthdaysListStatus birthdayListStatus;
  final List<PersonModel> listPersonModel;
  final List<int> selectedPersonId;
  final List<PersonModel> sortedListPersonModel;

  List<Object> get props =>
      [listPersonModel, selectedPersonId, sortedListPersonModel];

  BirthdaysListState copyWith({
    BirthdaysListStatus? birthdayListStatus,
    List<PersonModel>? listPersonModel,
    List<int>? selectedPersonId,
    List<PersonModel>? sortedListPersonModel,
  }) {
    return BirthdaysListState(
      birthdayListStatus: birthdayListStatus ?? this.birthdayListStatus,
      listPersonModel: listPersonModel ?? this.listPersonModel,
      selectedPersonId: selectedPersonId ?? this.selectedPersonId,
      sortedListPersonModel:
          sortedListPersonModel ?? this.sortedListPersonModel,
    );
  }
}

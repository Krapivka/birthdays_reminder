part of 'home_cubit.dart';

enum HomeTab { birthdays, calendar }

class HomeState extends Equatable {
  const HomeState({
    this.tab = HomeTab.birthdays,
  });

  final HomeTab tab;

  @override
  List<Object> get props => [tab];
}

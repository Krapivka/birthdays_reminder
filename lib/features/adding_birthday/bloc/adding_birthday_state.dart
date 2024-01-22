part of 'adding_birthday_bloc.dart';

sealed class AddingBirthdayState extends Equatable {
  const AddingBirthdayState();
  
  @override
  List<Object> get props => [];
}

final class AddingBirthdayInitial extends AddingBirthdayState {}

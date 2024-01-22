import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'adding_birthday_event.dart';
part 'adding_birthday_state.dart';

class AddingBirthdayBloc extends Bloc<AddingBirthdayEvent, AddingBirthdayState> {
  AddingBirthdayBloc() : super(AddingBirthdayInitial()) {
    on<AddingBirthdayEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

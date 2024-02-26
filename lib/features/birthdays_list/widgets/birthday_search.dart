import 'package:birthdays_reminder/features/birthdays_list/bloc/birthdays_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BirthdaySearch extends StatelessWidget {
  const BirthdaySearch({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
    final bloc = BlocProvider.of<BirthdaysListBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: TextField(
        // readOnly: readOnly,
        // showCursor: showCursor,
        // enableInteractiveSelection: false,
        onChanged: (value) {
          bloc.add(SearchBirthdaysListEvent(query: value));
        },
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          suffixIcon: BlocConsumer<BirthdaysListBloc, BirthdaysListState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state.birthdayListStatus ==
                  BirthdaysListStatus.searchLoaded) {
                return IconButton(
                    onPressed: () {
                      controller.clear();
                      bloc.add(const LoadBirthdaysListEvent());
                    },
                    icon: const Icon(Icons.clear));
              }
              return const SizedBox();
            },
          ),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          disabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          //     labelText: labelText,
          hintText: "Search",
          //   ),
          //   onTap: onTap,
          // ),
        ),
      ),
    );
  }
}

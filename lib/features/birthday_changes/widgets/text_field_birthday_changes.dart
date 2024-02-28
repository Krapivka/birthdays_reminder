import 'package:flutter/material.dart';

class TextFieldBirthdayChanges extends StatelessWidget {
  const TextFieldBirthdayChanges(
      {this.onChanged,
      this.labelText,
      this.hintText,
      this.icon,
      this.onTap,
      this.showCursor = true,
      this.controller,
      // ignore: unused_element
      this.readOnly = false});
  final void Function(String)? onChanged;
  final String? labelText;
  final String? hintText;
  final bool readOnly;
  final Icon? icon;
  final void Function()? onTap;
  final TextEditingController? controller;
  final bool? showCursor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        readOnly: readOnly,
        showCursor: showCursor,
        enableInteractiveSelection: false,
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: icon,
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
          labelText: labelText,
          hintText: hintText,
        ),
        onTap: onTap,
      ),
    );
  }
}

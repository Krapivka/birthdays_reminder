import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });
  final Icon icon;
  final String text;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110,
        width: MediaQuery.of(context).size.width / 2.7,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            icon,
            const SizedBox(
              height: 5,
            ),
            AutoSizeText(
              text,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

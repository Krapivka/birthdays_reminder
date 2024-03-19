import 'package:flutter/material.dart';

class ShowDialogApp extends StatelessWidget {
  const ShowDialogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Dialog(),
    );
  }
}

class Dialog extends StatelessWidget {
  const Dialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('showDialog Sample')),
      body: Center(
        child: OutlinedButton(
          onPressed: () => _dialogBuilder(context),
          child: const Text('Open Dialog'),
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Basic dialog title'),
          content: const Text(
            'A dialog is a type of modal window that\n'
            'appears in front of app content to\n'
            'provide critical information, or prompt\n'
            'for a decision to be made.',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Disable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Enable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

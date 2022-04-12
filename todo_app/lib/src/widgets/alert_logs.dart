import 'package:flutter/material.dart';

class AlertLogs extends StatelessWidget {
  final String title;
  final String content;

  // ignore: use_key_in_widget_constructors
  const AlertLogs({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 25,
          color: Colors.black,
        ),
      ),
      content: Text(content),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
          ),
        ),
      ],
    );
  }
}

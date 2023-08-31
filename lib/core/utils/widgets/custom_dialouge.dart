import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String text;

  CustomDialog({required this.text});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Access Denied'),
      content: Text(text),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}

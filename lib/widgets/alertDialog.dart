
import 'package:flutter/material.dart';

class alertDialog extends StatelessWidget {
  final String title;
  final String content;

  alertDialog({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
      backgroundColor: Colors.black,
      content: Text(content, style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        child: const Text('Okay', style: TextStyle(color: Colors.red, fontWeight: FontWeight.normal),),
        )
      ],
    );
  }
}
import 'package:flutter/material.dart';

class TextDisplay extends StatelessWidget {
  final String myText;

  TextDisplay(this.myText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Text(
        myText,
        style: TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
  }
}

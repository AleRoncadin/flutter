import 'package:flutter/material.dart';

class customButton extends StatelessWidget {
  final Function() selectHandler;
  final String buttonText;
  final Color color_text;
  final Color background_color;

customButton({required this.selectHandler, required this.buttonText, required this.color_text, required this.background_color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: this.background_color,
        // textColor: Colors.white,
        child: Text(
          buttonText.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: color_text
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        onPressed: selectHandler,
      ),
    );
  }
}
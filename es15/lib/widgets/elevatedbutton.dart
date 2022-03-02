import 'package:flutter/material.dart';
class elevatedButton extends StatelessWidget{
  final Function() selectHandler;
  final String myText;

  elevatedButton({required this.selectHandler, required this.myText});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                return Colors.black;
              },
            ),
          ),
          onPressed: selectHandler,
          child: Text(
            myText,
          style: TextStyle(
            color: Colors.red),
            )
          );
  }
}
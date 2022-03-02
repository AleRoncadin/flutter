import 'package:flutter/material.dart';
class elevatedButton extends StatelessWidget{
  final Function() selectHandler;
  final String myText;
  final Color color;

  elevatedButton({required this.selectHandler, required this.myText, required this.color});

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
            color: color),
            )
          );
  }
}
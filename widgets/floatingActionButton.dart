import 'package:flutter/material.dart';
class floatingActionButton extends StatelessWidget{
  final Function() selectHandler;
  final String myText;
  final IconData icon;

  floatingActionButton({required this.selectHandler, required this.myText, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
        children: [
          Positioned(
            bottom: 20,
            right: 30,
            child: FloatingActionButton(
              backgroundColor: Colors.black,
              heroTag: myText,
              onPressed: () {
                selectHandler();
              },
              child: Icon(
                icon,
                size: 32,
                color: Colors.red,
              ),
            ),
          ),
        ],
    );
  }
}
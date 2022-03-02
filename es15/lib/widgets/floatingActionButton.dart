import 'package:flutter/material.dart';
class floatingActionButton extends StatelessWidget{
  final Function() selectHandler;
  final String myText;

  floatingActionButton({required this.selectHandler, required this.myText});

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
              child: const Icon(
                Icons.delete,
                size: 32,
                color: Colors.red,
              ),
            ),
          ),
        ],
    );
  }

}
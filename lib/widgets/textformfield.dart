
import 'package:flutter/material.dart';

class textformfield extends StatelessWidget{
  
  final String myText;
  final TextEditingController textEditingController;

  textformfield({required this.myText, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
          controller: textEditingController, // TextEditingController
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            labelText: myText,
          ),
        );
  }

}
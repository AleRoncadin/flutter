import 'package:flutter/material.dart';

class textfield extends StatelessWidget {
  
  final String myText;
  final TextEditingController textEditingController;

  textfield({required this.myText, required this.textEditingController}); //, required this.onChanged

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: myText
      )    
    );
  }
}

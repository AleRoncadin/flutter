// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:es15/widgets/alertDialog.dart';
import 'package:es15/widgets/buildTitle.dart';
import 'package:es15/widgets/elevatedbutton.dart';
import 'package:es15/widgets/textfield.dart';
import 'package:es15/widgets/textformfield.dart';
import 'package:flutter/material.dart';

import 'todo.dart';

//import './textdisplay.dart';
//import './button.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    String? title;
    String? description;

    @override
    void dispose() {
      // Clean up the controller when the widget is disposed.
      titleController.dispose();
      descriptionController.dispose();
      //super.dispose();
    }

    void addElement() {
      if((descriptionController.text == "") || (titleController.text == ""))
      {
        showDialog(
        context: context,
        builder: (ctx) => alertDialog(title: "Impossible to add new element",
          content: "Title or description are empty")
        );

      }
      else
        Navigator.pop(context, Todo(titleController.text, descriptionController.text));
    }

    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: buildTitle(myText: "Add new element"),
        backgroundColor: Colors.black,
      ),
      body: Column(children: [
        textformfield(myText: "Insert title", textEditingController: titleController),
        textformfield(myText: "Insert description", textEditingController: descriptionController),
        elevatedButton(selectHandler: () => addElement(), myText: 'Add element')
      ]),
    );
  }
}
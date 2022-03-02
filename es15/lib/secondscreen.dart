// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:es15/widgets/buildTitle.dart';
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
      if((title == null) || (description == null))
      {
        showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: Colors.black,
          title: const Text("Impossible to add new element",
                style: TextStyle(color: Colors.red),),
            content: const Text("Title or description are empty",
                style: TextStyle(color: Colors.white),),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('Okay',
                style: TextStyle(color: Colors.red),),
              )
            ],
          ),
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
        TextFormField(
          controller: titleController, // TextEditingController
          validator: (value) {
              if(value!.isEmpty) {
                return "Please enter a title";
              }
          },
          onChanged: (value) => title = value.toString(),
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Insert title:',
          ),
        ),
        TextFormField(
          controller: descriptionController, // TextEditingController
          validator: (value) {
              if(value!.isEmpty) {
                return "Please enter a description";
              }
          },
          onChanged: (value) => description = value.toString(),
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Insert description:',
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                return Colors.black;
              },
            ),
          ),
          onPressed: () => addElement(),
          child: const Text('Add element',
          style: TextStyle(color: Colors.red),)),
      ]),
    );
  }
}

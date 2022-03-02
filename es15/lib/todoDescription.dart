// ignore_for_file: file_names

import 'package:es15/main.dart';
import 'package:es15/widgets/buildTitle.dart';
import 'package:es15/widgets/floatingActionButton.dart';
import 'package:flutter/material.dart';

import 'todo.dart';
import 'widgets/textdisplay.dart';

//import './textdisplay.dart';
//import './button.dart';

class TodoDescription extends StatelessWidget {
  const TodoDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get parameters from the previous screen:
    final routeArgs = ModalRoute.of(context)!.settings.arguments
        as Map<String, Todo>; //MyClass;
    // Get todo parameters:
    final todo = routeArgs['todo'] as Todo;
    return Scaffold(
      appBar: AppBar(
        title: buildTitle(myText: todo.title.toString()),
        backgroundColor: Colors.black,
      ),
      body: Column(children: [
        TextDisplay(todo.description),
      ]),
      floatingActionButton: floatingActionButton(myText: 'Delete', selectHandler: () async {
        deleteSelectedTodo(todo);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyHomePage()));
      },)
      );
  }
}

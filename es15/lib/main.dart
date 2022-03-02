/*
  Nice example of sending data to a new screen:
  https://docs.flutter.dev/cookbook/navigation/passing-data
  https://docs.flutter.dev/cookbook/navigation/navigate-with-arguments
 */

import 'package:es15/widgets/buildTitle.dart';

import 'todoDescription.dart';

import 'secondscreen.dart';
import 'package:flutter/material.dart';
import 'todo.dart';

final List<Todo> todos = [];

void deleteSelectedTodo(Todo t) async {
      todos.remove(t);
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      routes: {
        '/secondscreen': (ctx) => SecondScreen(),
        '/todoDescription': (ctx) => TodoDescription(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _index = 0;

  void viewSecondScreen(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.

    final Todo newTodo = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => const SecondScreen()),
    );

    setState(() {
      todos.add(newTodo);
      final snackBar = SnackBar(
          content: Text(newTodo.title.toString() + ' added'),
          action: SnackBarAction(
            label: 'Delete',
            textColor: Colors.red,
            onPressed: () {
              undoAction(context);
            },
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  void undoAction(BuildContext context) async {
    setState(() {
      todos.remove(todos.last);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: buildTitle(myText: "RONCADIN FORM"),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false, //RIMUOVERE LA FRECCIA PER ANDARE INDIETRO
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index].title),
            onTap: () {
              Navigator.of(context).pushNamed('/todoDescription', arguments: {
                'todo': todos[index],
              });
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            bottom: 20,
            right: 30,
            child: FloatingActionButton(
              backgroundColor: Colors.black,
              heroTag: 'next',
              onPressed: () {
                viewSecondScreen(context);
              },
              child: const Icon(
                Icons.add,
                size: 32,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

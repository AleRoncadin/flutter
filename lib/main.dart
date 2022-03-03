import 'widgets/buildTitle.dart';

import 'secondscreen.dart';
import 'package:flutter/material.dart';
import 'contacts.dart';
import 'widgets/floatingActionButton.dart';

final List<Contatti> contacts = [];

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      routes: {
        '/secondscreen': (ctx) => SecondScreen(),
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

  void viewSecondScreen(BuildContext context) async {

    final Contatti newContact = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SecondScreen()),
    );

    setState(() {
      contacts.add(newContact);
    });
  }

  void removeContact(Contatti c) async {
    setState(() {
      contacts.remove(c);
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    String title;
    return Scaffold(
      appBar: AppBar(
        title: buildTitle(myText: "Roncadin Alessandro"),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false, //RIMUOVERE LA FRECCIA PER ANDARE INDIETRO
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(contacts[index].title),
            subtitle: Text(contacts[index].subtitle),
            onTap: () {
              title = contacts[index].title;
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text("Delete this item?", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                  backgroundColor: Colors.black,
                  content: Text("$title", style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    child: const Text('Back', style: TextStyle(color: Colors.red, fontWeight: FontWeight.normal),),
                    ),
                    TextButton(
                      onPressed: () async {

                        removeContact(contacts[index]);

                        final snackBar = SnackBar(
                          content: Text(title + ' deleted'),
                          action: SnackBarAction(
                          label: 'Ok',
                          textColor: Colors.red,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },

                    child: const Text('Delete', style: TextStyle(color: Colors.red, fontWeight: FontWeight.normal),),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: floatingActionButton(myText: 'Add', selectHandler: () async => viewSecondScreen(context), icon: Icons.add,)
    );
  }
}
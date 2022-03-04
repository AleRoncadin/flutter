
import 'widgets/alertDialog.dart';
import 'widgets/buildTitle.dart';
import 'widgets/elevatedbutton.dart';
import 'widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'contacts.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cognomeController = TextEditingController();
    final nomeController = TextEditingController();
    final emailController = TextEditingController();

    String title = "";
    String subtitle = "";
    String cognome = "";
    String nome = "";
    String email = "";

    void addElement() {
      if((nomeController.text == "") || (cognomeController.text == "") || (emailController.text==""))
      {
        showDialog(
        context: context,
        builder: (ctx) => alertDialog(title: "Impossible to add new element",
          content: "Insert all camps")
        );

      }
      else
      {
        cognome = cognomeController.text;
        nome = nomeController.text;
        email = emailController.text;
        title = "$cognome $nome";
        subtitle = "$email";
        Navigator.pop(context, Contatti(title, subtitle));
      }
        
    }
    return Scaffold(
      appBar: AppBar(
        title: buildTitle(myText: "New Contact"),
        backgroundColor: Colors.black,
      ),
      body: Column(children: [
        textformfield(myText: "Insert surname", textEditingController: cognomeController),
        textformfield(myText: "Insert name", textEditingController: nomeController),
        textformfield(myText: "Insert email", textEditingController: emailController),
        elevatedButton(selectHandler: () => addElement(), myText: 'Add')
      ]),
    );
  }
}
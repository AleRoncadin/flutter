import 'package:flutter/material.dart';

class customDialog extends StatelessWidget {
  final String title;
  final String content;
  //final BuildContext ctx;

  const customDialog({
    required this.title,
    required this.content,
    //required this.ctx,
  });

  

  @override
  Widget build(BuildContext context) { //widget con titolo della schermata
    return Center(
      child: SizedBox(
        child: Column(
          children: <Widget>[
            AlertDialog(
              title: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
              ),
              ),
              content: Text(content),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ok'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
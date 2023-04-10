import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class customTitle extends StatelessWidget{
  final String myText;
  final Color color;
  final double fontsize;
  customTitle({required this.myText, required this.color, required this.fontsize});

  @override
  Widget build(BuildContext context) { //widget con titolo della schermata
    return Center(
      child: SizedBox(
        child: Column(
          children: <Widget>[
            Text(
              myText,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: fontsize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
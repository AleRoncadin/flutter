import 'package:flutter/material.dart';
import '/widgets/buildTitle.dart';
import '/widgets/textdisplay.dart';
import '/http_quiz.dart';
import 'widgets/button.dart';

class replay extends StatefulWidget {
  int points;
  int bad_questions;
  int good_questions;
  replay({required this.points, required this.bad_questions, required this.good_questions});

  @override
  State<StatefulWidget> createState() {
    return replayState();
}
}

class replayState extends State<replay> {
  @override
  Widget build(BuildContext context) {
    int points = widget.points;
    int bad_questions = widget.bad_questions;
    int good_questions = widget.good_questions;

    return Scaffold(
        appBar: AppBar( //TITOLO
        title: buildTitle(myText: "SUMMARY"),
        backgroundColor: Colors.black,
        ),
        body: Column(
          children: [
            TextDisplay(
              myText: "TOTAL POINTS: $points",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
              color: Colors.black,
              textColor: Colors.white,
            ),
            TextDisplay(
              myText: "GOOD QUESTIONS: $good_questions",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
              color: Colors.red,
              textColor: Colors.black,
            ),
            TextDisplay(
              myText: "BAD QUESTIONS: $bad_questions",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
              color: Colors.black,
              textColor: Colors.red,

            ),
            const SizedBox(height: 30),
            Button(
              selectHandler: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyQuizPage()));
              },
              buttonText : 'REPLAY',
              color_text: Colors.red,
              background_color: Colors.black,
            )        
          ],
        ),      
    );
    
  }
}
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:html/dom.dart' as htmlParser;
import 'profile_screen.dart';
import 'questions/question.dart';
import 'replay.dart';
import 'widgets/buildTitle.dart';
import 'widgets/textdisplay.dart';
import 'widgets/button.dart';

class MyQuizPage extends StatefulWidget {
  MyQuizPage({Key? key}) : super(key: key);

  @override
  _MyQuizPageState createState() => _MyQuizPageState();
}


class _MyQuizPageState extends State<MyQuizPage> {

  List<Question>? _questions = null; // questions data structure
  List<String>? _answers = null; // answers list
  var _index = 0;

  int points = 0;
  int bad_questions = 0;
  int good_questions = 0;
  int count_question = 0;

  String url_string = "https://opentdb.com/api.php?amount=10";

  void resetPoints()
  {
    points = 0;
    count_question = 0;
    bad_questions = 0;
    good_questions = 0;
  }

  void goToReplayScreen()
  {
    Navigator.push(context, MaterialPageRoute(
      builder: (context){
        return replay(
          points: points, good_questions: good_questions, bad_questions: bad_questions
        );
      }      
    ));
  }

  void next() {
    count_question ++;
    print(count_question);
    if(count_question>=10)
    {
      goToReplayScreen();
      //resetPoints();
    }
    else
    {
      if(_questions == null || _questions!.length == 0)
        return;
      setState(() {
      if(_index < _questions!.length - 1)
        _index++;
      else
        _index = 0;
      // update answers:
      _answers = List.from(_questions![_index].incorrect);
      _answers!.add(_questions![_index].correct);
      _answers!.shuffle();
      });
    }
  }

  void doGet() {  
    resetPoints(); //resetta il numero di domande fatte ed i punti
    http.get(Uri.parse(url_string)).then( (response) {
    var jsondata = json.decode(response.body);
    var questions = jsondata['results'];

      // Qui inserisci il codice opportuno per gestire lo stato:
      setState(() {
        _questions = questions.map<Question>((val) =>  Question.fromJson(val)).toList();
        // initialize answer list:
        _answers = List.from(_questions![_index].incorrect);
        _answers!.add(_questions![_index].correct);
        _answers!.shuffle();        
      });
      
      // debug (esempi di stampa dei dati contenuti nel json)
      print(htmlParser.DocumentFragment.html("Question: "+questions[0]['question']).text.toString());
      print("Correct answer is "+questions[0]['correct_answer']);
      print("Category: "+questions[0]['category']);

    });
  }

  void _checkAnswer(String ans) {
    String msg = "Sorry, but the correct answer was "+_questions![_index].correct;
    String bad_good_boy = "BAD BOY";
    if(ans == _questions![_index].correct)
    {
      msg = "Congratulation! The correct answer was "+_questions![_index].correct;
      bad_good_boy = "GOOD BOY";
      points ++;
      good_questions ++;
    }
    else
    {
      points --;
      bad_questions ++;
    }
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(
              bad_good_boy,
              style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  ),
              ),
            content: Text(
              msg,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  ),
              ),
            backgroundColor: Colors.black,
            actions: <Widget> [
              FlatButton(
                autofocus: true,
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    ),
              ) ,
                onPressed: () {Navigator.of(ctx).pop(true);}, //Navigator.of(ctx).pop(true); 
                )
            ] ,
          )
       );
  }

   List<Widget> _buildAnswerButtons(List<String> ans) {

    return ans.map<Button>((e) => Button(selectHandler: () => _checkAnswer(e), buttonText: e, background_color: Colors.red, color_text: Colors.black,)).toList();
  }

  // Load data from Open Trivia DB at the beginning:
  void initState() {
    doGet();
    //assert(_debugLifecycleState == _StateLifecycle.created);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar( //TITOLO
        title: buildTitle(myText: "HTTP QUIZ",),
        backgroundColor: Colors.black,
        ),
        body: Column(
          children: [
            TextDisplay(
              myText: (_questions != null && _questions![0] != null) ? _questions![_index].question: 'none',
              fontSize: 20,
              fontWeight: FontWeight.normal,
              textAlign: TextAlign.center,
              color: Colors.white,
              textColor: Colors.black,
            ),
            const SizedBox(height: 10),
            if(_answers!= null && _buildAnswerButtons(_answers!)!=null) 
              ... _buildAnswerButtons(_answers!)
            else 
              const CircularProgressIndicator(), //Text('Load Quiz!'),
            const SizedBox(height: 30),
            Button(selectHandler: next, buttonText : 'Next question', background_color: Colors.black, color_text: Colors.red),
            Button(selectHandler: doGet, buttonText : 'Reload', background_color: Colors.black, color_text: Colors.red),
            Button(selectHandler: goToReplayScreen, buttonText : 'View summary', background_color: Colors.black, color_text: Colors.red),
            Button(selectHandler: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ProfileScreen())), buttonText : 'Menù', background_color: Colors.black, color_text: Colors.red),
          ],
        ),      
    );
  }
}

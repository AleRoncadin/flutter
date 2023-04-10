import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import 'customButton.dart';
import 'customDialog.dart';
import 'customTextField.dart';
import 'customTitle.dart';

import 'package:intl/intl.dart';


//TextEditingController _countryCodeController = TextEditingController();
TextEditingController _messageController = TextEditingController();
TextEditingController _phoneController = TextEditingController();
TextEditingController _dateController = TextEditingController();
TextEditingController _timeController = TextEditingController();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        builder: (context, snapshot) {
            return const InitScreen();
        }
      ),

    );
  }
}

class InitScreen extends StatefulWidget {
  const InitScreen({Key? key}) : super(key: key);

  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen>{

  Future<void> useWhatsapp() async {

      FocusManager.instance.primaryFocus?.unfocus();

      if (_phoneController.text.isEmpty || _messageController.text.isEmpty || _dateController.text.isEmpty || _timeController.text.isEmpty){
        showDialog(
          context: context,
          builder: (ctx) => const customDialog(title: "Error", content: "Phone or Message are empty")
        );
      }

      else {
        try{

          DateTime now = DateTime.now();
          String date = now.day.toString() + "/" + now.month.toString() + "/" + now.year.toString();
          String time = DateFormat.Hm().format(now);

          /*if(_phoneController.text.toLowerCase() == "mamma"){
            _phoneController.text = "3406249182";
          }*/

          final link = WhatsAppUnilink(
            phoneNumber: _phoneController.text,
            text: _messageController.text,
          );

          while(date != _dateController.text && time != _timeController.text){
            now = DateTime.now();
            date = now.day.toString() + "/" + now.month.toString() + "/" + now.year.toString();
            time = DateFormat('kk:mm').format(now);

            if(date == _dateController.text && time == _timeController.text) {
              break;
            }

            sleep(const Duration(seconds: 1));
          }
          
          await launchUrlString('$link');
        } catch (e) {                 
            showDialog(
              context: context,
              builder: (ctx) => const customDialog(title: "Error", content: "Can't open WhatsApp")
            );
        }
      }
  }
  

  @override
   Widget build(BuildContext context){

    return Scaffold(
      body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[customTitle(myText: "Auto Reply", color: Colors.green, fontsize: 25,)],
          ),
          const SizedBox(height: 30.0,),
          CustomTextField(
            //width: 600,
            maxLength: 10,
            hintText: "Phone Number",
            textEditingController: _phoneController,
            textInputType: TextInputType.phone,
            icon: Icons.phone,
          ),
          const SizedBox(
            height: 30.0,
          ),
          CustomTextField(
            //width: 600,
            maxLength: 1000,
            hintText: "Message",
            textEditingController: _messageController,
            textInputType: TextInputType.phone,
            icon: Icons.message,
          ),
          const SizedBox(
            height: 30.0,
          ),
          CustomTextField(
            //width: 600,
            maxLength: 1000,
            hintText: "Date (dd/MM/yyyy)",
            textEditingController: _dateController,
            textInputType: TextInputType.datetime,
            icon: Icons.date_range,
          ),
          const SizedBox(
            height: 30.0,
          ),
          CustomTextField(
            //width: 600,
            maxLength: 1000,
            hintText: "Time (hh/mm)",
            textEditingController: _timeController,
            textInputType: TextInputType.datetime,
            icon: Icons.timer_sharp,
          ),
          const SizedBox(
            height: 60.0,
          ),
          customButton(
            selectHandler: useWhatsapp, 
            buttonText: "Send message", 
            color_text: Colors.black, 
            background_color: Colors.green
          ),
          const SizedBox(
            height: 30.0,
          ),  
          const SizedBox(
            height: 30.0,
          ),  
        ]
      ),
      ),
    );
  }
}

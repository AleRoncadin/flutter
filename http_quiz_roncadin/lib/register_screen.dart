import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'widgets/buildTitle.dart';
import 'widgets/button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  //si dichiarono quattro variabili stringhe per nickname, email, password e conferma della password per il nuovo utente che si vuole registrare
  String nickname = '';
  String email = '';
  String password = '';
  String confirmPassword = '';

  final _auth = FirebaseAuth.instance; //crea una nuova istanza di Firebase Auth
  final db = FirebaseDatabase(databaseURL: "https://roncadin-application-default-rtdb.europe-west1.firebasedatabase.app/")
  .reference().child("Users"); //crea una nuova istanza di Firebase Realtime Database

  void _saveItem() async { //funzione per salavare il nuovo utente che si è appena registrato
    try {
        final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        //viene chiamato il metodo createUserWithEmailAndPassword() in cui viene passato la email e la password del nuovo utente
          if (newUser != null) {
            User userCredential = await _auth.currentUser!;
            final userID = userCredential.uid;
            _addUserDB(userID);
          }

        showDialog( //se la registrazione avviene con successo, viene mostrato un messaggio di completamento, quindi è possibile effettuare il login
          context: context,
          builder: (context) {
            Future.delayed(const Duration(seconds: 3), () {
              Navigator.of(context).pop(true);
              });
            return const AlertDialog(
            title: Text('Successfully Register. You Can Login Now'),
            );
            });
          } on FirebaseAuthException catch (e) {
                        showDialog( //in caso di errori, viene mostrato al centro della schermata un messaggio di errore
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text("Registration Failed"),
                          content: Text('${e.message}'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: const Text('Okay'),
                            )
                          ],
                        ),
                      );
                      }

  }

  void _addUserDB(String ID) { //funzione per aggiungere l'utente appena registrato al Realtime Database
    db.child(ID).set(
      {
        'email': email,
        'nickname': nickname,
      }
    );
  }

  @override
  Widget build(BuildContext context) {

    //vengono dichiarati 4 TextEditingController rispettivamente per nickname, email, password e conferma password inserite nelle TextField
    TextEditingController _nicknameController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _confirmpasswordController = TextEditingController();

    void registra() async{
      if (password == confirmPassword)
      {
        _saveItem();
      }
      else {
        showDialog( //se sono presenti degli errori, viene mostrato un avviso di mancato successo
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Registration Failed"),
            content: const Text("Passwords must match"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('Okay'),
              )
            ],
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(title: buildTitle(myText: 'REGISTRATION',), backgroundColor: Colors.black,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Image.asset('assets/logo.png'),
          const SizedBox(
              height: 30.0,
            ),
            TextField(
            controller: _nicknameController,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => nickname = value.toString().trim(),
            decoration: const InputDecoration(
              hintText: "Nickname",
              prefixIcon: Icon(
                Icons.account_circle_rounded,
                color: Colors.black,
              )
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
            TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => email = value.toString().trim(),
            decoration: const InputDecoration(
              hintText: "Email",
              prefixIcon: Icon(
                Icons.mail,
                color: Colors.black,
              )
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            validator: (value) {
              if(value!.isEmpty) {
                return "Please enter Password";
              }
            },
            onChanged: (value) => password = value,
            decoration: const InputDecoration(
              hintText: "Password",
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.black,
              )
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: _confirmpasswordController,
            obscureText: true,
            onChanged: (value) => confirmPassword = value,
            validator: (value) {
              if(value!.isEmpty) {
                return "Please enter Password";
              }
            },       
            decoration: const InputDecoration(
              hintText: "Confirm Password",
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.black,
              )
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Button(selectHandler: () => registra(), buttonText: "Register", color_text: Colors.black, background_color: Colors.red),
          Button(selectHandler: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage())), buttonText: "Initial Screen", color_text: Colors.white, background_color: Colors.black)
          ],
          ),
        ),
    );
  }
}
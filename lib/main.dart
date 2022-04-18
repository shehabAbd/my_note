import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/Login.dart';
import 'package:my_notes/add.dart';
import 'package:my_notes/homepage.dart';
import 'package:my_notes/signup.dart';
import 'package:my_notes/test.dart';

bool isloin = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    isloin = false;
  } else { 
    isloin = true;
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.orange,
      ),
      debugShowCheckedModeBanner: false,
      home: 
      // Test(),
      // Login(),
       isloin == false ? Login() : Homepage(),
      routes: {
        "login": (context) => Login(),
        "signup": (context) => Signup(),
        "homepage": (context) => Homepage(),
        "add": (context) => Add()
      },
    );
  }
}

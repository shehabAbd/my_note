import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/alert.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var myname, myusername, myemail, mypass;
  var loding;

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  signup() async {
    var formdata = formstate.currentState;
    if (formdata.validate()) formdata.save();
    var loading = showLoding(context);
    loding = loading;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: myemail, password: mypass);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        loding != loading;
        Navigator.of(context).pop();
        AwesomeDialog(
                context: context,
                title: "Erorr",
                body: Text('The password provided is too weak.'))
            .show();
      } else if (e.code == 'email-already-in-use') {
        loding != loading;
        Navigator.of(context).pop();
        AwesomeDialog(
                context: context,
                title: "Erorr",
                body: Text('The account already exists for that email.'))
            .show();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 100),
            Container(
              child: Image.asset(
                "images/accou.png",
                width: 250,
              ),
              // height: 200,
              // width: 200,
            ),
            Container(
              padding: EdgeInsets.only(right: 20, left: 20, bottom: 20),
              child: Form(
                key: formstate,
                child: Column(
                  children: [
                    Container(
                      child: TextFormField(
                        onSaved: (newValue) {
                          myname = newValue;
                        },
                        validator: (value) {
                          if (value.length > 20) {
                            return "The name can not be more than 20 latters";
                          }
                          if (value.length < 2) {
                            return "The name can not be less than 2 latters";
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        cursorColor: Colors.orange,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "Your Name",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 255, 154, 4)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 0, 174, 255)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onSaved: (newValue) {
                        myusername = newValue;
                      },
                      validator: (value) {
                        if (value.length > 20) {
                          return "The username can not be more than 20 latters";
                        }
                        if (value.length < 2) {
                          return "The username can not be less than 2 latters";
                        }
                        return null;
                      },
                      cursorColor: Colors.orange,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: "Username",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: Color.fromARGB(255, 77, 1, 255)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.orange),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onSaved: (newValue) {
                        myemail = newValue;
                      },
                      validator: (value) {
                        if (value.length > 100) {
                          return "The email can not be more than 100 latters";
                        }
                        if (value.length < 2) {
                          return "The email can not be less than 10 latters";
                        }
                        return null;
                      },
                      cursorColor: Colors.orange,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: "Email",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: Color.fromARGB(255, 240, 91, 5)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 244, 248, 6)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      onSaved: (newValue) {
                        mypass = newValue;
                      },
                      validator: (value) {
                        if (value.length > 20) {
                          return "The password can not be more than 100 latters";
                        }
                        if (value.length < 2) {
                          return "The password can not be less than 8 latters";
                        }
                        return null;
                      },
                      obscureText: true,
                      cursorColor: Colors.orange,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password_outlined),
                        hintText: "Passeword",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 0, 255, 128)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.orange),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text("if you have acount "),
                          InkWell(
                            child: Text(
                              "Click here",
                              style: TextStyle(color: Colors.green),
                            ),
                            onTap: () {
                              Navigator.of(context).pushNamed("login");
                            },
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green[900],
                        ),
                        onPressed: () async {
                          UserCredential respons = await signup();
                          print("Done");
                          if (respons != null) {
                            await FirebaseFirestore.instance.collection("users").add({
                              "username" : "$myusername",
                              "email" : "$myemail"
                            });
                            Navigator.of(context).pushReplacementNamed("homepage");
                          } else {
                            print("faild");
                          }
                        },
                        child: Text("Signup",style: Theme.of(context).textTheme.headline6,)
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

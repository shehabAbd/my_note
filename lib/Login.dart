import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:my_notes/alert.dart';
import 'package:overlay_support/overlay_support.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Future initState() async {
    if (InternetConnectionChecker().hasConnection == true) {
      return await login();
    } else {
      return AwesomeDialog(
          context: context,
          title: "No Internet",
          body: Text("You have to open internet"));
    }
    super.initState();
  }

  var loding;
  var myemail, mypass;

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  login() async {
    var formdata = formstate.currentState;
    if (formdata.validate()) {
      formdata.save();
      var loading = showLoding(context);
      loding = loading;
      try {
        showLoding(context);
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: myemail, password: mypass);
        return Navigator.of(context).pushReplacementNamed("homepage");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          loding != loading;
          Navigator.of(context).pop();
          AwesomeDialog(
                  context: context,
                  title: "Erorr",
                  body: Text('No user found for that email.'))
              .show();
        } else if (e.code == 'wrong-password') {
          loding != loading;
          Navigator.of(context).pop();
          AwesomeDialog(
                  context: context,
                  title: "Erorr",
                  body: Text('Wrong password provided for that user.'))
              .show();
        }
      }
    }
  }
  // login() async {
  //   var formdata = formstate.currentState;
  //   if (formdata.validate()) {
  //     formdata.save();
  //     var loading = showLoding(context);
  //     loding = loading;
  //     try {
  //       UserCredential userCredential = await FirebaseAuth.instance
  //           .signInWithEmailAndPassword(email: myemail, password: mypass);
  //       return Navigator.of(context).pushReplacementNamed("homepage");
  //     } on FirebaseAuthException catch (e) {
  //       if (e.code == 'user-not-found') {
  //         loding != loading;
  //         Navigator.of(context).pop();
  //         AwesomeDialog(
  //                 context: context,
  //                 title: "Erorr",
  //                 body: Text('No user found for that email.'))
  //             .show();
  //       } else if (e.code == 'wrong-password') {
  // loding != loading;
  //         Navigator.of(context).pop();

  //         AwesomeDialog(
  //                 context: context,
  //                 title: "Erorr",
  //                 body: Text('Wrong password provided for that user.'))
  //             .show();
  //       }
  //     }
  //   } else {
  //     print("fiald");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset(
                "images/5.png",
                width: 400,
              ),
              height: 200,
              width: 200,
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
                        textInputAction: TextInputAction.next,
                        cursorColor: Colors.orange,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "Email",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 132, 0, 255)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.orange),
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
                      obscuringCharacter: "*",
                      obscureText: true,
                      cursorColor: Colors.orange,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password_outlined),
                        hintText: "Password",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: Color.fromARGB(255, 6, 255, 69)),
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
                          Text("If You do not have Acount "),
                          InkWell(
                            child: Text(
                              "Click Here",
                              style: TextStyle(color: Colors.green),
                            ),
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed("signup");
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
                            if (InternetConnectionChecker().hasConnection ==
                                true) {
                              return await login();
                            } else {
                              return AwesomeDialog(
                                  context: context,
                                  title: "No Internet",
                                  body: Text("You have to open internet"));
                            }
                            // UserCredential respos = await login();
                            // if (respos != null) {
                            // Navigator.of(context)
                            //     .pushReplacementNamed("homepage");
                            // }
                          },
                          child: Text(
                            "Login",
                            style: Theme.of(context).textTheme.headline6,
                          )),
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

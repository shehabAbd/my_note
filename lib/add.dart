import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_notes/alert.dart';
import 'package:my_notes/compenent.dart';
class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Add note'),
      ),
      body: Container(
        child: Column(
          children: [
            Form(
              key: formstate,
              child: Column(
                children: [
                  TextFormField(
                    validator: (val) {
                      if (val.length > 20) {
                        return "The title can not be more than 20 latters";
                      }
                      if (val.length < 2) {
                        return "The title can not be less than 2 latters";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      title = val;
                    },
                    maxLength: 30,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      label: Text("Title"),
                      prefixIcon: Icon(Icons.note),
                    ),
                  ),
                  TextFormField(
                     validator: (val) {
                      if (val.length > 100) {
                        return "The note can not be more than 100 latters";
                      }
                      if (val.length < 2) {
                        return "The note can not be less than 2 latters";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      note = val;
                    },
                    maxLength: 300,
                    minLines: 1,
                    maxLines: 7,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      label: Text("Note"),
                      prefixIcon: Icon(Icons.note),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green[900],
                    ),
                    onPressed: () {
                      shwbuttomshet(context);
                    },
                    child: Text("Add image"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 60),
                      primary: Colors.green[900],
                    ),
                    onPressed: () async{
                    await  addNote(context ,formstate);
                    },
                    child: Text("Add note"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

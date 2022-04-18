import 'dart:io';
import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_notes/add.dart';
import 'package:my_notes/alert.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

var picker = ImagePicker();
File file;
Reference ref;
CollectionReference notesref = FirebaseFirestore.instance.collection("notes");
   
var title, note, imageurl;
  addNote(context, formstate) async {
  var formdata = formstate.currentState;
  if (formdata.validate() && file != null) {
    AwesomeDialog(
      context: context,
      title: "Error,",
      body: Text("You have to choos image for note"),
    );
    formdata.save();
    showLoding(context);
    await ref.putFile(file);
    imageurl = await ref.getDownloadURL();
    await notesref.add({
      "title": title,
      "note": note,
      "imageurl": imageurl,
      "userid": FirebaseAuth.instance.currentUser.uid
    });
    Navigator.of(context).pushReplacementNamed("homepage");
  } else if (file == null) {
    AwesomeDialog(
      dialogType: DialogType.ERROR,
      context: context,
      title: "Error,",
      body: Text("You have to choos image for note"),
    ).show();
  }
}


uploadeImgCamera(context) async {
  var imagepicked = await picker.pickImage(source: ImageSource.camera);
  if (imagepicked != null) {
    file = File(imagepicked.path);
    var rand = Random().nextInt(100000);
    var imageName = "$rand" + basename(imagepicked.path);
    ref = FirebaseStorage.instance.ref("images").child("$imageName");
    Navigator.of(context).pop();
    // await ref.putFile(file);
    // imageurl = await ref.getDownloadURL();
  } else {
    print("Please choos image");
  }
}

uploadeImgGularu(context) async {
  var imagepicked = await picker.pickImage(source: ImageSource.gallery);
  if (imagepicked != null) {
    file = File(imagepicked.path);
    var rand = Random().nextInt(100000);
    var imageName = "$rand" + basename(imagepicked.path);
    ref = FirebaseStorage.instance.ref("images").child("$imageName");
    Navigator.of(context).pop();
  } else {
    print("Please choos image");
  }
}

shwbuttomshet(context) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        padding: EdgeInsets.all(20),
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Please Choose Image",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap: () {
                uploadeImgGularu(context);
              },
              child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.photo_outlined,
                        size: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text("From Galary", style: TextStyle(fontSize: 20)),
                    ],
                  )),
            ),
            InkWell(
              onTap: () {
                uploadeImgCamera(context);
              },
              child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.camera,
                        size: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text("From Camera", style: TextStyle(fontSize: 20)),
                    ],
                  )),
            ),
          ],
        ),
      );
    },
  );
}
// await ref.putFile(file);
//     imageurl = await ref.getDownloadURL();

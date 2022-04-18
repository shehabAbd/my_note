// // import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:path/path.dart';

// class Test extends StatefulWidget {
//   const Test({Key key}) : super(key: key);

//   @override
//   _TestState createState() => _TestState();
// }

// class _TestState extends State<Test> {
//   CollectionReference notesref = FirebaseFirestore.instance.collection("users");
//   DocumentReference userref = FirebaseFirestore.instance
//       .collection("users")
//       .doc("ek5oHCQWNyYP8lc4xh2L");

//   File file;
//   var imagePicker = ImagePicker();

//   uploadeImg() async {
//     var imagepicked = await imagePicker.pickImage(source: ImageSource.camera);
//     if (imagepicked != null) {
//       file = File(imagepicked.path);
//       var nameimage = basename(imagepicked.path);
//       //Start upload
//       var refstorage = FirebaseStorage.instance.ref("images/$nameimage");

//       await refstorage.putFile(file);

//       var url = await refstorage.getDownloadURL();

//       print("url : $url");

//       // end upload

//       print("=====================");
//       print(imagepicked.path);
//     } else {
//       print("Please choos image");
//     }
//   }
//  Future getImage()async{
//     final pickedFile= await imagePicker.getImage(source: ImageSource.gallery);
//     setState(() {
//       file = File(pickedFile.path);
//     });

//   }
//   // List users = [];

//   // showdata() async {
//   //   DocumentReference documentReference = FirebaseFirestore.instance
//   //       .collection("users")
//   //       .doc("ek5oHCQWNyYP8lc4xh2L");

//   //   var data = await documentReference.get();
//   //   setState(() {
//   //     users.add(data.data());
//   //   });
//   // }

//   @override
//   // void initState() {
//   //   showdata();
//   //   super.initState();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Test page "),
//         ),
//         body: Center(
//           child: Column(children: [
//             Expanded(
//                 child: Stack(
//               children: <Widget>[
//                 Container(
//                   height: double.infinity,
//                   margin: EdgeInsets.only(right: 30.0, top: 10.0, left: 30.0),
//                   child: ClipRRect(
//                       borderRadius: BorderRadius.circular(30.0),
//                       child: file != null
//                           ? Image.file(file)
//                           : FlatButton(
//                               onPressed: () {
//                                 getImage();
//                               },
//                               child: Icon(
//                                 Icons.add_a_photo,
//                                 size: 50,
//                               ))),
//                 )
//               ],
//             )),
//             SizedBox(
//               height: 20.0,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(bottom: 20.0),
//               child: MaterialButton(
//                 color: Colors.green,
//                 child: Text("uploade Image"),
//                 onPressed: () => uploadeImg(),
//               ),
//             ),
//           ]),
//         )
// //          //read data from firstor by StreamBuilder RealTime
// //         // StreamBuilder(
// //         //   builder: (context, snapshot) {
// //         //     if (snapshot.hasData) {
// //         //       return ListView.builder(
// //         //         itemCount: snapshot.data.docs.length,
// //         //         itemBuilder: ((context, i) {
// //         //           return Padding(
// //         //             padding: const EdgeInsets.symmetric(
// //         //                 horizontal: 20, vertical: 10),
// //         //             child: Text(
// //         //               "${snapshot.data.docs[i].data()['name']}",
// //         //               style:
// //         //                   TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
// //         //             ),
// //         //           );
// //         //           //
// //         //         }),
// //         //       );
// //         //     }
// //         //     if (snapshot.hasError) {
// //         //       return Text("Error");
// //         //     }
// //         //     if (snapshot.connectionState == ConnectionState.waiting) {
// //         //       return Center(
// //         //         child: Text(
// //         //           "Loding ....",
// //         //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
// //         //         ),
// //         //       );
// //         //     }
// //         //   },
// //         //   stream: notesref.snapshots(),
// //         // )
// //         //read data from firstor by FutureBuilder
// //         //     FutureBuilder(
// //         //   future: userref.get(),
// //         //   builder: (context, snapshot) {
// //         //     if (snapshot.hasData) {
// //         //       return Padding(
// //         //         padding: const EdgeInsets.all(20),
// //         //         child: Text(
// //         //           "${snapshot.data.data()['name']}",
// //         //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
// //         //         ),
// //         //       );
// //         //     }
// //         //     if (snapshot.hasError) {
// //         //       return Text("Error");
// //         //     }
// //         //     if (snapshot.connectionState == ConnectionState.waiting) {
// //         //       return Center(
// //         //         child: Text(
// //         //           "Loding",
// //         //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
// //         //         ),
// //         //       );
// //         //     }
// //         //   },
// //         // ),
//         );
//   }
// }

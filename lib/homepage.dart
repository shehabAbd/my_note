// ignore_for_file: prefer_const_constructors, unnecessary_new, sized_box_for_whitespace, use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, unused_import
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/compenent.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _auth = FirebaseAuth.instance;
  CollectionReference noteref = FirebaseFirestore.instance.collection("notes");
  // List notes = [
  //   {"note": "hello one", "image": "images/craft.jpg"},
  //   {"note": "hello two", "image": "images/craft.jpg"},
  //   {"note": "hello three", "image": "images/craft.jpg"},
  //   {"note": "hello four", "image": "images/craft.jpg"},
  //   {"note": "hello five", "image": "images/craft.jpg"},
  // ];
  // getuser() {
  //   var user = FirebaseAuth.instance.currentUser;
  //   print(user.email);
  // }

  @override
  void initState() {
    // getuser();
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: formstate,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              _auth.signOut();
              Navigator.of(context).pushReplacementNamed("login");
            },
            icon: Icon(Icons.exit_to_app),
          )
        ],
        backgroundColor: Colors.orange,
        title: Text('Note Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).pushNamed("add");
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        child: FutureBuilder(
          future: noteref
              .where("userid", isEqualTo: FirebaseAuth.instance.currentUser.uid)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, i) {
                    return Listnotes(
                      not: snapshot.data.docs[i],
                    );
                  });
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

class Listnotes extends StatelessWidget {
  final not;
  Listnotes({this.not});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Image.network(
                "${not['imageurl']}",
                fit: BoxFit.fill,
                height: 80,
              ),
            ),
            Expanded(
              flex: 2,
              child: ListTile(
                title: Text(
                  "${not['title']}",
                ),
                subtitle: Text(
                  "${not['note']}",
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit),
                  color: Colors.green[900],
                ),
                // title: Container(
                //     padding: EdgeInsets.all(10), child: Text("${not["note"]}")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

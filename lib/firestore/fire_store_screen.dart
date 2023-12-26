import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ostad/posts/add_posts.dart';
import 'package:ostad/utils.dart';

import '../homepage.dart';
import 'add_firestore.dart';



class FirestoreScreen extends StatefulWidget {
  FirestoreScreen({super.key});

  @override
  State<FirestoreScreen> createState() => _FirestoreScreenState();
}

class _FirestoreScreenState extends State<FirestoreScreen> {
  final auth = FirebaseAuth.instance;
  final updateData = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Myhomepage();
                  }));
                });
              },
              icon: Icon(Icons.logout)),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),

          Expanded(
         child: ListView.builder(itemBuilder: (context,index){
           return ListTile(
             title: Text('sazzad'),
           );
         }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddFirestore();
          }));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> showMyDialog(String title, String id) async {
    updateData.text = title;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text('update'),
            content: Container(
              child: TextFormField(
                controller: updateData,
                decoration: InputDecoration(
                  //border:OutlineInputBorder(),
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () { },
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () { },
                  child: Text("update"))
            ]);
      },
    );
  }
}
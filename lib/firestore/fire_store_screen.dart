import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  final firestore=FirebaseFirestore.instance.collection('user').snapshots();
  CollectionReference ref=FirebaseFirestore.instance.collection('user');
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
StreamBuilder<QuerySnapshot>(
    stream: firestore,
    builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
      if(snapshot.connectionState==ConnectionState.waiting){
        return CircularProgressIndicator();
      }
      if(snapshot.hasError){
        return Text("Some Error");
      }

      return     Expanded(
        child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context,index){
          return ListTile(
            // onTap: (){
            //   ref.doc().update({
            //     'title':
            //   });
            // },
            title: Text(snapshot.data!.docs[index]['title'].toString()),

          );
        }),
      );
    }
),
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
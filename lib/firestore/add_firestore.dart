
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ostad/Rounded_button.dart';
import 'package:ostad/utils.dart';

class AddFirestore extends StatefulWidget {
  const AddFirestore({super.key});

  @override
  State<AddFirestore> createState() => _AddFirestoreState();
}

class _AddFirestoreState extends State<AddFirestore> {
  final _textxontrol=TextEditingController();
final firestore=FirebaseFirestore.instance.collection('user');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add post"),),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 20,),
            TextFormField(
              controller: _textxontrol,
              maxLines: 4,
              decoration: InputDecoration(
                  hintText: "Enter some thing",
                  border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 20,),
            Roundedbutton(onTap: (){
              String id=DateTime.now().millisecondsSinceEpoch.toString();
              firestore.doc(id).set(
                {
                  'title':_textxontrol.text.toString(),
                  'id':id
                }
              ).then((value) {
                return Flutterutils().tostmassage('add success');
              }).onError((error, stackTrace) {
                return Flutterutils().tostmassage(error.toString());
              });
            }, titel:'Add')
          ],
        ),
      ),
    );
  }
}

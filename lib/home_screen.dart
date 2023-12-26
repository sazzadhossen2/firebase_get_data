
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

class Homescreen extends StatelessWidget {
   Homescreen({super.key});
final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Screen"),
      actions: [
        IconButton(onPressed: (){
          auth.signOut().then((value) {
            Navigator.push(context,MaterialPageRoute(builder: (context){
              return Myhomepage();
            }));
          });
        }, icon:Icon(Icons.logout)),
        SizedBox(width: 20,),

      ],),
    );
  }
}

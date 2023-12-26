import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ostad/posts/add_posts.dart';

import 'homepage.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key});

  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('post');

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
          Expanded(child: StreamBuilder(
              stream: ref.onValue,
              builder: (context,AsyncSnapshot<DatabaseEvent>snapshot){
                if(!snapshot.hasData){
                  return CircularProgressIndicator();
                }
                else{
                  Map<dynamic,dynamic>map=snapshot.data!.snapshot.value as dynamic;
                List<dynamic>list=[];
                list.clear();
                list=map.values.toList();
                return ListView.builder(
                    itemCount: snapshot.data!.snapshot.children.length,
                    itemBuilder: (context,index){
                  return ListTile(
                    title: Text(list[index]['title']),
                  );
                });

                }
              }

          )),
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  return ListTile(
                    title: Text(snapshot.child('title').value.toString()),
                  );
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Addposts();
          }));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

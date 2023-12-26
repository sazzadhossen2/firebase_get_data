import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ostad/posts/add_posts.dart';
import 'package:ostad/utils.dart';

import 'homepage.dart';

class Homescreen extends StatefulWidget {
  Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final auth = FirebaseAuth.instance;

  final ref = FirebaseDatabase.instance.ref('post');

  final searchtext = TextEditingController();
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
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller: searchtext,
              decoration: InputDecoration(
                  hintText: 'Search', border: OutlineInputBorder()),
              onChanged: (String value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  final title = snapshot.child('title').value.toString();
                  if (searchtext.text.isEmpty) {
                    return ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      //id:Text(snapshot.child('id').value.toString()),
                      trailing: PopupMenuButton(
                        icon: Icon(Icons.more_vert),
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem(
                                value: 1,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    showMyDialog(title,
                                        snapshot.child('id').value.toString());
                                  },
                                  leading: Icon(Icons.edit),
                                  title: Text('Edit'),
                                )),
                            PopupMenuItem(
                                value: 1,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    ref.child(snapshot.child('id').value.toString()).remove();
                                  },
                                  leading: Icon(Icons.delete),
                                  title: Text('Delet'),
                                )),
                          ];
                        },
                      ),
                    );
                  } else if (title
                      .toLowerCase()
                      .contains(searchtext.text.toLowerCase().toLowerCase())) {
                    return ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      trailing: PopupMenuButton(
                        icon: Icon(Icons.more_vert),
                        itemBuilder: (BuildContext context) =>
                          [
                            PopupMenuItem(
                                value: 1,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    showMyDialog(title, snapshot.child('id').value.toString());
                                  },
                                  leading: Icon(Icons.edit),
                                  title: Text('Edit'),
                                )),

                            PopupMenuItem(
                                value: 1,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    ref.child(snapshot.child('id').value.toString()).remove();

                                  },
                                  leading: Icon(Icons.delete),
                                  title: Text('Delet'),
                                )),
                          ]

                      ),
                    );
                  } else {
                    return Container();
                  }
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
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ref.child(id).update(
                        {'title': updateData.text.toString()}).then((value) {
                      Flutterutils().tostmassage('Post update');
                    }).onError((error, stackTrace) {
                      Flutterutils().tostmassage(error.toString());
                    });
                  },
                  child: Text("update"))
            ]);
      },
    );
  }
}

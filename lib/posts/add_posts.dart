
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ostad/Rounded_button.dart';
import 'package:ostad/utils.dart';

class Addposts extends StatefulWidget {
  const Addposts({super.key});

  @override
  State<Addposts> createState() => _AddpostsState();
}

class _AddpostsState extends State<Addposts> {
  final _textxontrol=TextEditingController();
final databaseref=FirebaseDatabase.instance.ref('post');
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
databaseref.child(DateTime.now().millisecondsSinceEpoch.toString()).set({
  'title':_textxontrol.text.toString(),
  'id':DateTime.now().millisecondsSinceEpoch.toString()
}).then((value) {
  Flutterutils().tostmassage('post addes');
  setState(() {

  });
}).onError((error, stackTrace) {
  Flutterutils().tostmassage(error.toString());
  setState(() {

  });
});
            }, titel: "Add")
          ],
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ostad/Rounded_button.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:ostad/utils.dart';

class UploadImageflutter extends StatefulWidget {
  const UploadImageflutter({super.key});

  @override
  State<UploadImageflutter> createState() => _UploadImageflutterState();
}

class _UploadImageflutterState extends State<UploadImageflutter> {
  File? image;
  final piker = ImagePicker();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref('post');

  Future<void> getupdateimage() async {
    final pickedFile = await piker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('no Image Picker');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              getupdateimage();
            },
            child: Container(
              height: 200,
              width: 200,
              child: Center(
                  child: image != null
                      ? Image.file(image!.absolute)
                      : Icon(Icons.image)),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black54)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Roundedbutton(
            onTap: () async {
              firebase_storage.Reference ref =
                  firebase_storage.FirebaseStorage.instance.ref('/foldername/' +
                      DateTime.now().millisecondsSinceEpoch.toString());
              firebase_storage.UploadTask uploadTask =
                  ref.putFile(image!.absolute);
              Future.value(uploadTask).then((value) async {
                var newUrls =await ref.getDownloadURL();

                databaseReference.child(DateTime.now().millisecondsSinceEpoch.toString()).set(
                     {
                      'id':DateTime.now().millisecondsSinceEpoch.toString() ,
                      'title': newUrls.toString()
                     }).then((value) {
                  Flutterutils().tostmassage('uploaded');
                }).onError((error, stackTrace) {
                  Flutterutils().tostmassage(error.toString());
                });
              });
            },
            titel: 'Upload',
          )
        ],
      ),
    );
  }
}

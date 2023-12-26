import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ostad/home_screen.dart';
import 'package:ostad/utils.dart';

import 'Rounded_button.dart';

class Loginscreen extends StatefulWidget {
  Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final _emailtext = TextEditingController();

  final _passtext = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  FirebaseAuth _auth = FirebaseAuth.instance;
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailtext.dispose();
    _passtext.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailtext,
                decoration: InputDecoration(
                    hintText: "enter email",
                    prefixIcon: Icon(Icons.alternate_email)),
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return 'enter Email';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: true,
                controller: _passtext,
                decoration: InputDecoration(
                  hintText: "enter passworf",
                  //prefix: Icon(Icons.password),
                  prefixIcon: Icon(Icons.password),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "enter password";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Roubdedbutton(
                onTap: () {
                  if (_formkey.currentState!.validate()) {
                    _auth.signInWithEmailAndPassword(
                        email: _emailtext.text.toString(),
                        password: _passtext.text.toString()).then((value) {
                      Flutterutils().tostmassage(value.user!.email.toString());
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Homescreen();
                          }));
                    }).onError((error, stackTrace) {
                      Flutterutils().tostmassage(error.toString());
                    });
                    print(_auth);
                  }
                },
                titel: 'Login',
              )
            ],
          ),
        ),
      ),
    );
  }
}
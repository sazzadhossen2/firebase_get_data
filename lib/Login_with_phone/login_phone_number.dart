import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ostad/Login_with_phone/varify_otp.dart';
import 'package:ostad/utils.dart';

import '../Rounded_button.dart';

class LoginwithPhone extends StatefulWidget {
  LoginwithPhone({super.key});

  @override
  State<LoginwithPhone> createState() => _LoginwithPhoneState();
}

class _LoginwithPhoneState extends State<LoginwithPhone> {
  final phonenumber = TextEditingController();

  bool loading = false;

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lgin"),),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          SizedBox(height: 10,),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: phonenumber,
            decoration: InputDecoration(
                hintText: 'Enter Phone Number',
                prefixIcon: Icon(Icons.phone_android)

            ),
          ),
          SizedBox(height: 50,),
          Roundedbutton(onTap: () {
            setState(() {
              loading=true;
            });
            auth.verifyPhoneNumber(
              phoneNumber: phonenumber.text,
                verificationCompleted: (_){
                setState(() {
                  loading=false;
                });
                },
                verificationFailed: (e){
                  setState(() {
                    loading=false;
                  });
                Flutterutils().tostmassage(e.toString());
                },
                codeSent: (String verificationtect,int? token){
Navigator.push(context,MaterialPageRoute(builder: (context){
  return Varifyotpscreen(varificationid: verificationtect);
}));
setState(() {
  loading=false;
});
                },
                codeAutoRetrievalTimeout: (e){
                  setState(() {
                    loading=false;
                  });
                Flutterutils().tostmassage(e.toString());
                });
          },
            titel: 'Login',)
        ],),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ostad/home_screen.dart';
import 'package:ostad/utils.dart';

import '../Rounded_button.dart';

class Varifyotpscreen extends StatelessWidget {
  Varifyotpscreen({super.key, required this.varificationid});

 final String varificationid;
  final verifyotp = TextEditingController();
  bool loading = false;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("verification"),),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          SizedBox(height: 10,),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: verifyotp,
            decoration: InputDecoration(
                hintText: 'Enter 6 Digit Otp',
                prefixIcon: Icon(Icons.phone_android)

            ),
          ),
          SizedBox(height: 50,),
          Roundedbutton(onTap: () async{
            final creadintial = PhoneAuthProvider.credential(
                verificationId:varificationid,
                smsCode: verifyotp.text.toString()
            );
            try{
auth.signInWithCredential(creadintial);
Navigator.push(context, MaterialPageRoute(builder: (context){
  return Homescreen();
}));
            }catch(e){
Flutterutils().tostmassage(e.toString());
            }
          },
            titel: 'Verification',)
        ],),
      ),
    );
  }
}

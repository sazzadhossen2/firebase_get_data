import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../home_screen.dart';
import '../homepage.dart';

class SplashService{

  void isLogin(BuildContext context){
    final auth=FirebaseAuth.instance;
    final user=auth.currentUser;
    if(user!=null){
      Timer(Duration(seconds: 3), ()=>
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return Homescreen();
          }))
      );
    }
    else{
    Timer(Duration(seconds: 3), ()=>
      Navigator.push(context, MaterialPageRoute(builder: (context){
       return Myhomepage();
      }))
    );
  }}
}
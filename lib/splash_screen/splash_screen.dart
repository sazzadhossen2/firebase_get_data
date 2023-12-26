
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ostad/splash_screen/splash_service.dart';

class SplashScreen extends StatefulWidget {
   SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashService splashService =SplashService();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashService.isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Firebase",style: TextStyle(fontSize: 30),)),
    );
  }
}

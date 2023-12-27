import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ostad/splash_screen/splash_screen.dart';
import 'firebase_options.dart';
import 'homepage.dart';
void main()async {

WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home:SplashScreen(),
    );
  }
}



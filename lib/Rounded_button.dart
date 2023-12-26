
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Roundedbutton extends StatelessWidget {
   Roundedbutton({super.key,required this.onTap,required this.titel});
String titel;
VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.purpleAccent,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Center(child: Text(titel)),
      ),
    );
  }
}

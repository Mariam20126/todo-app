import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_app/home/home_screen.dart';

class SplashScreen extends StatelessWidget {
static const String routeName ='splash_screen';
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5),
            () {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            });
    var mediaQuerry=MediaQuery.of(context).size;
    return Scaffold(
      body:
      Image.asset('assets/images/splash.png',
        width: mediaQuerry.width,
        height: mediaQuerry.height,
        fit: BoxFit.fill,
      ),
    );
  }
}

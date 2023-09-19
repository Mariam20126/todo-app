import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_app/home/home_screen.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
static const String routeName ='splash_screen';
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    Timer(Duration(seconds: 5),
            () {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            });
    var mediaQuerry=MediaQuery.of(context).size;
    return Scaffold(
      body:provider.isDarkMood()?
      Image.asset('assets/images/splash_dark.png',
      width: mediaQuerry.width,
      height: mediaQuerry.height,
      fit: BoxFit.fill,
    )
          :
      Image.asset('assets/images/splash.png',
        width: mediaQuerry.width,
        height: mediaQuerry.height,
        fit: BoxFit.fill,
      ),
    );
  }
}

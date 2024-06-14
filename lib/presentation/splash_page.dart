import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    Timer(
      Duration(seconds: 1),
          () =>   _controller.forward()
    );
    super.initState();
    Timer(
      Duration(seconds: 3),
          () =>   Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MyApp(),
            ),
          )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/images/splash_bg.png', // Replace this with your image path
            fit: BoxFit.cover,
          ),
          Center(
            child: FadeTransition(
              opacity: _controller,
              child:Image.asset('assets/images/splash_logo.png'),
            ),
          ),
        ],
      ),
    );
  }
}

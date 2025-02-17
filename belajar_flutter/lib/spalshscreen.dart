import 'dart:async';

import 'package:belajar_flutter/page/Login.dart';
//import 'package:belajar_flutter/page/page_main.dart';
import 'package:flutter/material.dart';
//import 'package:belajar_flutter/src/CustomColors.dart';
//ohimport 'package:belajar_flutter/src/CustomShadow.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    print('iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii');
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => LoginPage(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "img/Splash_screen.png",
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  
                  Container(
                    margin: const EdgeInsets.fromLTRB(80, 20, 80, 20),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

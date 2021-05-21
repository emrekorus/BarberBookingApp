import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_barber/Screens/Home/HomeScreen.dart';
import 'package:my_barber/Services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer _timerSplash;

  int start = 2;

  @override
  void dispose() {
    super.dispose();
    _timerSplash.cancel();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('assets/images/logo.png'),
                //width: MediaQuery.of(context).size.width * 0.8,//height: 100.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void startTimer() {
    _timerSplash = new Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (start > 0) {
          start--;
        } else {
          _timerSplash.cancel();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => AuthService().handleAuth()),
              (Route<dynamic> route) => false);
        }
      });
    });
  }
}

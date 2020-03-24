import 'package:corovid19/frontend/activities/home.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
{
  @override
  void initState()
  {
    super.initState();
    Future.delayed(Duration(seconds: 2),
            () => Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                child: HomeScreen(),
                duration: Duration(seconds: 2))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   //   backgroundColor: Colors.blueGrey[800],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset("assets/logo.png", width: 90, height: 90),
          ),
          Text("Corovid-19",
              style: TextStyle(
                  fontFamily: "monospace",
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: LinearProgressIndicator(),
          ),
          SizedBox(height: 70)
        ],
      ),
    );
  }
}

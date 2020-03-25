import 'package:corovid19/frontend/activities/splash.dart';
import 'package:flutter/material.dart';
import 'frontend/activities/splash.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Corovid-19',
      theme: ThemeData(
        fontFamily: 'SF Pro Display',
        backgroundColor: Colors.blueGrey[900],
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey[800], //Changing this will change the color of the TabBar
        accentColor: Colors.cyan[600], // displays when scroll limit
      ),
      home: SplashScreen(),
    );
  }
}

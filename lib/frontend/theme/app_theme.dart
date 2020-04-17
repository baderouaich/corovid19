import 'package:flutter/material.dart';


ThemeData darkTheme = ThemeData(
        fontFamily: 'SF Pro Display',
        backgroundColor: Colors.blueGrey[900],
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey[800], //Changing this will change the color of the TabBar
        accentColor: Colors.cyan[600], // displays when scroll limit
      );

ThemeData lightTheme = ThemeData(
        fontFamily: 'SF Pro Display',
        backgroundColor: Colors.grey[100],
        brightness: Brightness.light,
        primaryColor: Colors.grey[50], //Changing this will change the color of the TabBar
        accentColor: Colors.orange[600], // displays when scroll limit
      );
      
enum ThemeType { Light, Dark }

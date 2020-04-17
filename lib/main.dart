import 'package:corovid19/frontend/activities/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'frontend/activities/splash.dart';
import 'frontend/theme/theme_model.dart';

void main() => runApp(ChangeNotifierProvider<ThemeModel>(
    create: (BuildContext context) => ThemeModel(),
    child: MyApp()));



class MyApp extends StatelessWidget
 {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Corovid-19',
      theme: Provider.of<ThemeModel>(context).currentTheme,      
      /* ThemeData(
        fontFamily: 'SF Pro Display',
        backgroundColor: Colors.grey[100],
        brightness: Brightness.light,
        primaryColor: Colors.grey[50], //Changing this will change the color of the TabBar
        accentColor: Colors.orange[600], // displays when scroll limit
      ),*/
     /* theme: ThemeData(
        fontFamily: 'SF Pro Display',
        backgroundColor: Colors.blueGrey[900],
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey[800], //Changing this will change the color of the TabBar
        accentColor: Colors.cyan[600], // displays when scroll limit
      ),
      */
      home: SplashScreen(),
    );
  }
}

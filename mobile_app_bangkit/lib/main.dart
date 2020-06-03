import 'package:flutter/material.dart';
import './Screens/Welcome/welcome_screen.dart';
import './constants.dart';
import './login.dart';
import './page/HomePage.dart';
import './page/ML/plant_detection.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Project Bangkit',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: WelcomeScreen(),
      routes: {
        '/login' : (BuildContext context) => LoginScreen(),
        '/HomePage' : (BuildContext context) => HomeScreen(),
        '/ML' : (BuildContext context) => DetectScreen()
      },
    );
  }
}

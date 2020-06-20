import 'package:flutter/material.dart';
import './components/body.dart';
import '../../models/main.dart';


class WelcomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
        body: Body(),
      ),onWillPop: () async => false);
  }
}
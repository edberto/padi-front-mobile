import 'package:flutter/material.dart';
import 'package:mobile_app_bangkit/models/connected_products.dart';
import './body.dart';
import '../models/main.dart';

class SignUpScreen extends StatefulWidget {
  final UserModel model;
  SignUpScreen(this.model);
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(widget.model.authenticate),
    );
  }
}


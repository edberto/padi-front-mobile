import 'package:flutter/material.dart';
import './Screens/Welcome/welcome_screen.dart';
import './constants.dart';
import './login.dart';
import './Signup/signup_screen.dart';
import './page/HomePage.dart';
// import './page/ML/plant_detection.dart';
import './page/ML2/plant_detector.dart';
import './page/QnA/chatbox.dart';
import 'package:mobile_app_bangkit/page/form.dart';
import './models/main.dart';
import 'package:scoped_model/scoped_model.dart';
import './page/product_list.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final MainModel model = MainModel();
    return ScopedModel<MainModel>(
        model: model,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Project Bangkit',
          theme: ThemeData(
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: Colors.white,
          ),
          home: WelcomeScreen(),
          routes: {
            '/login': (BuildContext context) => LoginScreen(model),
            '/signup': (BuildContext context) => SignUpScreen(model),
            '/HomePage': (BuildContext context) => HomeScreen(model),
            // '/ML' : (BuildContext context) => DetectScreen(),
            '/ML2': (BuildContext context) => plant_detector(model),
            '/chatbox': (BuildContext context) => Chatbox(),
            '/form': (BuildContext context) => MyUserForm(),
            '/product_list': (BuildContext context) => MyProductList(model),
          },
        ));
  }
}

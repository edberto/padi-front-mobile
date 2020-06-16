import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_app_bangkit/Screens/Welcome/components/background.dart';
import 'package:mobile_app_bangkit/constants.dart';
import 'package:mobile_app_bangkit/login.dart';
import '../../../Signup/signup_screen.dart';

class Body extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) { 
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Welcome to PADI"
            ),
            SizedBox(height: size.height*0.01,),
            SvgPicture.asset("assets/icons/rice.svg",
            height: size.height*0.2,
            ),
            SizedBox(height: size.height*0.03,),
            Container(
              width: size.width*0.7,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(29),
                child: FlatButton(
                color: kPrimaryColor,
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text("LOGIN",          
                ),
              ),
              ),
            ),
            Container(
              width: size.width*0.7,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(29),
                child: FlatButton(
                color: kPrimaryLightColor,
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text("SIGN UP",          
                ),
              ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
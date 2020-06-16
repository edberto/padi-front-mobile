import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/svg.dart';
import './page/HomePage.dart';
import './Signup/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    WidgetIconBiking(),
                    WidgetLabelContinueWith(),
                    WidgetLoginViaSocialMedia(),
                    WidgetLabelSignInWithEmail(),
                    WidgetFormLogin(),
                    WidgetResetPasswordButton(),
                  ],
                ),
              ),
              WidgetSignUp(),
            ],
          ),
        ],
      ),
    );
  }
}

class WidgetIconBiking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        top: mediaQuery.padding.top > 0 ? mediaQuery.padding.top : 16.0,
        right: 16.0,
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: SvgPicture.asset("assets/icons/rice_2.svg",
            height: mediaQuery.size.height*0.2,
            ),
              
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 16.0),
          //   child: Center(
          //     child: Text(
          //       'PADI App',
          //       style: TextStyle(
          //         fontSize: 24.0,
          //         // fontFamily: 'NanumGothic',
          //         color: Colors.black54,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class WidgetLabelContinueWith extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Center(
        child: Text(
          'Continue with',
          style: TextStyle(color: Colors.black54),
        ),
      ),
    );
  }
}

class WidgetLoginViaSocialMedia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        top: 8.0,
        right: 16.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Icon(
              FontAwesomeIcons.facebookF,
              size: 18.0,
              color: Colors.black54,
            ),
          ),
          SizedBox(width: 32.0),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Icon(
              FontAwesomeIcons.google,
              size: 18.0,
              color: Colors.black54,
            ),
          ),
          SizedBox(width: 32.0),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Icon(
              FontAwesomeIcons.twitter,
              size: 18.0,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

class WidgetLabelSignInWithEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 28.0),
      child: Center(
        child: Text(
          'Or sign in with email', style: TextStyle(color: Colors.black54,),),
      ),
    );
  }
}

class WidgetFormLogin extends StatelessWidget {
  final focusNodePassword = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email Address / Username',
              contentPadding: EdgeInsets.all(16.0),
              filled: true
          ),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"^(?=[a-zA-Z0-9._]{8,20}$)(?!.*[_.]{2})[^_.].*[^_.]$")
                .hasMatch(value)) {
          return 'Please enter a valid username';
        }
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
              contentPadding: EdgeInsets.all(16.0),
              filled: true
            ),
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Password invalid';
        }
      
      },
      // onSaved: (String value) {
      //   _formData['password'] = value;
      // },
    );
  }

void _submitForm(BuildContext context) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    Navigator.pushReplacementNamed(context, '/HomePage');
    

    // Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
          child: Column(
            children: <Widget>[
              // Navigator.pushNamed(context, '/HomePage');
              // TextField(
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(),
              //     labelText: 'Email Address / Username',
              //     contentPadding: EdgeInsets.all(16.0),
              //   ),
              //   keyboardType: TextInputType.emailAddress,
              //   textInputAction: TextInputAction.next,
              //   onSubmitted: (username) {
              //     FocusScope.of(context).requestFocus(focusNodePassword);
              //   },
              // ),
              _buildEmailTextField(),
              SizedBox(height: 16.0),
              // TextField(
              //   focusNode: focusNodePassword,
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(),
              //     labelText: 'Password',
              //     contentPadding: EdgeInsets.all(16.0),
              //   ),
              //   keyboardType: TextInputType.text,
              //   obscureText: true,
              //   textInputAction: TextInputAction.done,
              //   onSubmitted: (password) {
              //     focusNodePassword.unfocus();
              //     // TODO: do something in here when password onSubmitted
              //   },
              // ),
              _buildPasswordTextField(),
              SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  child: Text(
                    'LOG IN',
                    style: TextStyle(
                      color: Colors.black,
                      // fontFamily: 'NanumGothic',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Color(0xFFCCFF90),
                  onPressed: () {
                    _submitForm(context);
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WidgetResetPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Wrap(
        children: <Widget>[
          Center(
            child: FlatButton(
              child: Text(
                'RESET PASSWORD',
                style: TextStyle(
                  color: Color(0xFF6C63FF),
                  // fontFamily: 'NanumGothic',
                ),
              ),
              onPressed: () {
                /* Nothing to do in here */
                
              },
            ),
          ),
        ],
      ),
    );
  }
}

class WidgetSignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom:
        mediaQuery.padding.bottom > 0 ? mediaQuery.padding.bottom : 16.0,
      ),
      child: Center(
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Don\'t have an account? ',
                style: Theme.of(context).textTheme.caption,
              ),
              TextSpan(
                text: 'Sign up here',
                recognizer: new TapGestureRecognizer()..onTap = () {
                  Navigator.pushNamed(context, '/signup');
                },
                style: Theme.of(context).textTheme.caption.merge(
                  TextStyle(
                    color: Color(0xFF6C63FF),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
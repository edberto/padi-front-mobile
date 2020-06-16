import 'package:flutter/material.dart';
import '../login.dart';
import './background.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  final focusNodePassword = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'user' : null,
    'password' : null
  };

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Email Address / Username',
          contentPadding: EdgeInsets.all(16.0),
          filled: true),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"^(?=[a-zA-Z0-9._]{8,20}$)(?!.*[_.]{2})[^_.].*[^_.]$")
                .hasMatch(value)) {
          return 'Please enter a valid username';
        }
      
      },
      onSaved: (String value) {
        _formData['user'] = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Password',
          contentPadding: EdgeInsets.all(16.0),
          filled: true),
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Password invalid';
        }
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  void _submitForm(BuildContext context) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    print(_formData);
    // Navigator.pushReplacementNamed(context, '/HomePage');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
          child: Container(
        child: Form(
            key: _formKey,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "SIGN UP",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: size.height * 0.03),
                  SvgPicture.asset(
                    "assets/icons/farmer.svg",
                    height: size.height * 0.15,
                  ),
                  _buildEmailTextField(),
                  SizedBox(height: size.height * 0.01),
                  _buildPasswordTextField(),
                  SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                        shape: StadiumBorder(),
                        child: Text(
                          'SIGN UP',
                          style: TextStyle(
                            color: Colors.black,
                            // fontFamily: 'NanumGothic',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        color: Color(0xFFCCFF90),
                        onPressed: () {
                          _submitForm(context);
                        }),
                  ),
                  // SizedBox(height: size.height * 0.03),
                ],
              ),
            )),
      )),
    );
  }
}

import 'package:flutter/material.dart';
import '../login.dart';
import './background.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Body extends StatefulWidget {
  final Function signup;
  Body(this.signup);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BodyState();
  }
}

class _BodyState extends State<Body> {
  final focusNodePassword = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {'user': null, 'password': null};
  final Map<String, dynamic> result2 = {};
  String temp;
  bool textField;
  bool passField;

  void initState() {
    temp = 'Authentication succeeded!';
    textField = true;
    passField = false;
    super.initState();
  }

  Widget _buildEmailTextField() {
    textField = true;
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Username',
          contentPadding: EdgeInsets.all(16.0),
          filled: true),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"^(?=[a-zA-Z0-9._]{8,20}$)(?!.*[_.]{2})[^_.].*[^_.]$")
                .hasMatch(value)) {
          textField = false;
          return 'Please enter a valid username';
        }
      },
      onSaved: (String value) {
        _formData['user'] = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    passField = true;
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Password',
          contentPadding: EdgeInsets.all(16.0),
          filled: true),
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          textField = false;
          return 'Password invalid';
        }
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  void _submitForm(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    await foo(_formData['user'], _formData['password'], "Signup");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
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
                    "DAFTAR",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: size.height * 0.03),
                  // SvgPicture.asset(
                  //   "assets/icons/farmer.svg",
                  //   height: size.height * 0.15,
                  // ),
                  _buildEmailTextField(),
                  SizedBox(height: size.height * 0.01),
                  _buildPasswordTextField(),
                  SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                        shape: StadiumBorder(),
                        child: Text(
                          'KIRIM',
                          style: TextStyle(
                            color: Colors.black,
                            // fontFamily: 'NanumGothic',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        color: Color(0xFFCCFF90),
                        onPressed: () async {
                          await _submitForm(context);
                          textField == false || passField == false
                              ? Container()
                              : Future.delayed(
                                  const Duration(milliseconds: 2500), () {
                                  setState(() {
                                    // Here you can write your code for open new view
                                    dialogAlert(context);
                                  });
                                });
                        }),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  void foo(String user, String password, String title) async {
    widget.signup(user, password, title).then((result) {
      setState(() {
        temp = result['message'];
        print(temp);
      });
    });
  }

  Future<bool> dialogAlert(BuildContext context) async {
    if (temp != 'Authentication succeeded!') {
      return Alert(
        context: context,
        type: AlertType.error,
        title: "User ini sudah terdaftar !",
        desc: "Tolong buat username unik kembali",
        buttons: [
          DialogButton(
            child: Text(
              "KEMBALI",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    } else if (temp == 'Authentication succeeded!') {
      return Alert(
        context: context,
        type: AlertType.success,
        title: "SUKSES!",
        desc: "Kamu bisa kembali ke halaman masuk, dan menikmati PADI!",
        buttons: [
          DialogButton(
            child: Text(
              "KEMBALI",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }
  }
}

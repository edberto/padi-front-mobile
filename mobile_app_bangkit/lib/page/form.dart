import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class MyUserForm extends StatefulWidget {
  MyUserForm({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyUserFormState createState() => new _MyUserFormState();
}

class _MyUserFormState extends State<MyUserForm> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          top: false,
          bottom: false,
          child: new Form(
              key: _formKey,
              autovalidate: true,
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Color(0xFFF1F8E9),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset("assets/icons/vegetable.svg"),
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Enter your first and last name',
                      labelText: 'Name',
                    ),
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.calendar_today),
                      hintText: 'Enter your date of birth',
                      labelText: 'Dob',
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.phone),
                      hintText: 'Enter a phone number',
                      labelText: 'Phone',
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.email),
                      hintText: 'Enter a email address',
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  new Container(
                      padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                      child: new RaisedButton(
                        child: const Text('Submit'),
                        onPressed: () {
                          print('HEHE');
                        },
                      )),
                ],
              ))),
    );
  }
}

//import 'package:flutter/cupertino.dart' as prefix0;
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import '../screens/register.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  Widget signUpButton(BuildContext context) {
    return RaisedButton.icon(
      icon: Icon(Icons.assignment_ind),
      label: Text('Sign Up'),
      color: Colors.blue[300],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      onPressed: () {
        print('You Click Sign Up');
        var registerRoute =
            MaterialPageRoute(builder: (BuildContext context) => Register());
        Navigator.of(context).push(registerRoute);
      },
    );
  }

  Widget signInButton() {
    return RaisedButton(
      color: Colors.green[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Text('Sign In'),
      onPressed: () {},
    );
  }

  Widget emailTextFormField() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: 'Email :', hintText: 'you@mail.com'),
    );
  }

  Widget passwordTextFormField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
          labelText: 'Password :', hintText: 'More 6 Charactor'),
    );
  }

  Widget showAppName() {
    return Text(
      'JN Flutter',
      style: TextStyle(
          fontFamily: 'Acme',
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          color: Colors.blue[800]),
    );
  }

  Widget showLogo() {
    return Image.asset('images/logo.png');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.greenAccent, Colors.white],
                begin: Alignment(-1, -1))),
        padding: EdgeInsets.only(top: 80.0),
        alignment: Alignment(0, -1),
        child: Column(
          children: <Widget>[
            Container(
              width: 150.0,
              height: 150.0,
              child: showLogo(),
            ),
            Container(margin: EdgeInsets.only(top: 15.0), child: showAppName()),
            Container(
              margin: EdgeInsets.only(left: 50.0, right: 50.0),
              child: emailTextFormField(),
            ),
            Container(
              margin: EdgeInsets.only(left: 50.0, right: 50.0),
              child: passwordTextFormField(),
            ),
            Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 4.0),
                      child: signInButton(),
                    ),
                  ),
                  Expanded(
                    child: signUpButton(context),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

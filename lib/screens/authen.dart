import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './register.dart';
import './my_service.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // For Form
  final formKey = GlobalKey<FormState>();

  // Constant
  String titleHaveSpace = 'กรุณากรอกข้อมูลให้ครบ';
  String titleEmailFalse = 'กรุณากรอกรูปแบบอีเมล์ให้ถูกต้อง';
  String titlePasswordFalse = 'รหัสผ่านต้องมีอย่างน้อย 6 ตัวอักษร';

  // Explicit
  String emailString, passwordString;

  // For Firebase
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // For SnackBar
  final snackBarKey = GlobalKey<ScaffoldState>();

// Initial Method
  @override
  void initState() {
    super.initState();
    print('initState Work');

    checkStatus(context);
  }

  Future checkStatus(BuildContext context) async {
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    if (firebaseUser != null) {
      goToService(context);
    }
  }

  void goToService(BuildContext context) {
    var serviceRoute =
        MaterialPageRoute(builder: (BuildContext context) => MyService());
    Navigator.of(context)
        .pushAndRemoveUntil(serviceRoute, (Route<dynamic> route) => false);
  }

  // About Widget Method
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

  Widget signInButton(BuildContext context) {
    return RaisedButton.icon(
      label: Text('Sign In'),
      icon: Icon(Icons.account_circle),
      color: Colors.green[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      onPressed: () {
        print('You Click Sign In');
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          print('email ==>> $emailString, password ==>> $passwordString');
          checkAuthen(context);
        }
      },
    );
  }

  void checkAuthen(BuildContext context) async {
    FirebaseUser firebaseUser = await firebaseAuth
        .signInWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((objValue) {
      print("Success Login ==> ${objValue.toString()}");

      // Route Without Arrow Back
      var myServiceRoute =
          MaterialPageRoute(builder: (BuildContext context) => MyService());
      Navigator.of(context)
          .pushAndRemoveUntil(myServiceRoute, (Route<dynamic> route) => false);
    }).catchError((objValue) {
      String error = objValue.message;
      print('Error ==>> $error');
      showSnackBar(error);
    });
  }

  void showSnackBar(String messageString) {
    SnackBar snackBar = new SnackBar(
      duration: Duration(seconds: 10),
      backgroundColor: Colors.red[500],
      content: Text(messageString),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );
    snackBarKey.currentState.showSnackBar(snackBar);
  }

  Widget emailTextFormField() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: 'Email :', hintText: 'you@mail.com'),
      validator: (String value) {
        if (value.length == 0) {
          return titleHaveSpace;
        } else if (!((value.contains('@')) && (value.contains('.')))) {
          return titleEmailFalse;
        }
      },
      onSaved: (String value) {
        emailString = value;
      },
    );
  }

  Widget passwordTextFormField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
          labelText: 'Password :', hintText: 'More 6 Charactor'),
      validator: (String value) {
        if (value.length < 6) {
          return titlePasswordFalse;
        }
      },
      onSaved: (String value) {
        passwordString = value;
      },
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
        key: snackBarKey,
        resizeToAvoidBottomPadding: false,
        body: Form(
          key: formKey,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.greenAccent, Colors.white],
                    begin: Alignment(-1, -1))),
            padding: EdgeInsets.only(top: 80.0),
            alignment: Alignment(0, -1),
            child: Column(
              children: <Widget>[
                Container(
                  width: 90.0,
                  height: 90.0,
                  child: showLogo(),
                ),
                Container(
                    margin: EdgeInsets.only(top: 15.0), child: showAppName()),
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
                          child: signInButton(context),
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
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './screens/authen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]); // Lock moniter
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jitti Firebase',
      home: Authen(),
    );
  }
}

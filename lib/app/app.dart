import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:mvvmproject/presentation/resources/theam_manager.dart';

class MyApp extends StatefulWidget {
  MyApp._internal();//it's a private named constructor .

  static final MyApp instance = MyApp._internal();    //single instance created;

  factory MyApp()=>instance;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getAppTheme(),
    );
  }
}

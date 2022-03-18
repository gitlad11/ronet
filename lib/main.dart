import 'package:flutter/material.dart';
import 'package:ronet_engine/start.dart';
import 'package:ronet_engine/folder_view.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFD50B49)),
      scaffoldBackgroundColor: const Color(0xFF212121),
      backgroundColor: const Color(0xFF313131),
      primaryColor: Colors.black,
      iconTheme: const IconThemeData().copyWith(color: Colors.white),
      fontFamily: 'Montserrat',
      textTheme: TextTheme(
        headline2: const TextStyle(
          color: Colors.white,
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
        ),
        headline4: TextStyle(
          fontSize: 12.0,
          color: Colors.grey[300],
          fontWeight: FontWeight.w500,
          letterSpacing: 2.0,
        ),
        bodyText1: TextStyle(
          color: Colors.grey[300],
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.0,
        ),
        bodyText2: TextStyle(
          color: Colors.grey[300],
          letterSpacing: 1.0,
        ),
      ),
    ),
      home: Start(),
    );
  }
}


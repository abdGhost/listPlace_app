import 'package:flutter/material.dart';
import 'package:login_list_of_places/screens/list_screen.dart';
import 'package:login_list_of_places/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      home: LoginScreen(),
    );
  }
}

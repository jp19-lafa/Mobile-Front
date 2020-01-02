import 'package:farm_lab_mobile/screens/login_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FarmLab Mobile',
      theme: ThemeData(
        primaryColor: Color(0xFF4CAF50),
      ),
      home: LoginPage(),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:tugas_dicoding/screen/login_screen.dart';
import './screen/dashboard_screen.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Belanjain",
      theme: ThemeData(),
      // home: const DashboardScreen(),
      home: const LoginScreen(),
    );
  }

}
import 'package:flutter/material.dart';
import 'package:tugas_dicoding/screen/dashboard_screen.dart';
import 'package:tugas_dicoding/screen/main_screen.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Belanjain",
      theme: ThemeData(),
      home: const DashboardScreen(),
      // home: const MainScreen(),
    );
  }

}
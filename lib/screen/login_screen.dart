import 'package:flutter/material.dart';
import 'package:tugas_dicoding/screen/auth/login.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
      double width = constraints.maxWidth < 600
          ? constraints.maxWidth * 0.9 : 400;
      return const Center(
        child: Login(),
      );
        }
    )
    );
  }
}

import 'package:flutter/material.dart';
import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Login")),
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth < 600
                ? constraints.maxWidth * 0.9 : 400;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: SizedBox(
                  width: width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Email"),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          hintText: "Enter Email",
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukkan Email';
                          } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Tolong masukkan Email dengan benar';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text("Password"),
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "Password",
                          hintText: "Masukkan Password",
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tolong masukkan Password';
                          } else if (value.length < 6) {
                            return 'Password minimal berisi 6 karakter';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Proses')),
                            );

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const MainScreen()),
                            );
                          }
                        },
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}


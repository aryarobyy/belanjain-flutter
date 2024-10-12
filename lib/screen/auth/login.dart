import 'package:flutter/material.dart';
import '../../model/user_model.dart';
import '../main_screen.dart';
import 'package:tugas_dicoding/fetchs/user/_user.dart';
import 'register.dart';

class _Login extends StatefulWidget {
  const _Login();

  @override
  State<_Login> createState() => _LoginState();
}

final _formKey = GlobalKey<FormState>();

class _LoginState extends State<_Login> {
  late Future<User> futureUser;

  @override
  void initState(){
    super.initState();
    futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Login(),
      ),
    );
  }
}

class Login extends StatelessWidget {
  const Login({super.key});

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
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center, // Center the Row's children
                            children: [
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
                              const SizedBox(width: 16),
                              const Text("Dont have account? "),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const Register()),
                                  );
                                },
                                child: const Row(
                                  children: [
                                    Text("Register"),
                                  ],
                                ),
                              ),
                            ],
                          ),
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

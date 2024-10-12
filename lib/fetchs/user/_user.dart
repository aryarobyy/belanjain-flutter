import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tugas_dicoding/model/user_model.dart';

Future<User> fetchUser() async {
  final response = await http.get(Uri.parse('http://localhost:5000/api/user'));

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load user');
  }
}

Future<void> postUser(String name, String username, String email,String password) async {
  final response = await http.post(
    Uri.parse('http://localhost:5000/api/user/register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'username': username,
      'email' : email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    print('User registered successfully');
  } else {
    throw Exception('Failed to register user');
  }
}

Future<User> getUser (String username) async {
  final response = await http.get(
    Uri.parse('http://localhost:5000/api/user/$username'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
  );

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load user');
  }
}
import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  final int? id;
  final String username;
  final String password;

  User({this.id, required this.username, required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      password: json['password'],
    );
  }
}

class DatabaseHelper {
  Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse('http://localhost/phpmyadmin/'));
    
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _handleSignUp() async {
    String lastName = _lastNameController.text;
    String firstName = _firstNameController.text;
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (lastName.isEmpty || firstName.isEmpty || username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('All fields are required')),
      );
      return;
    }

    var url = Uri.parse('https://example.com/api/signup');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'lastName': lastName,
        'firstName': firstName,
        'username': username,
        'password': password,
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SuccessPage()),
      );
    } else {
      String errorMessage = 'Sign-up failed, please try again';
      try {
        var errorResponse = jsonDecode(response.body);
        if (errorResponse['message'] != null) {
          errorMessage = errorResponse['message'];
        }
      } catch (e) {
        print('Error parsing error response: $e');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create User')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: _lastNameController, decoration: InputDecoration(labelText: 'Last Name')),
            SizedBox(height: 10),
            TextField(controller: _firstNameController, decoration: InputDecoration(labelText: 'First Name')),
            SizedBox(height: 10),
            TextField(controller: _usernameController, decoration: InputDecoration(labelText: 'Username')),
            SizedBox(height: 10),
            TextField(controller: _passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _handleSignUp, child: Text('Create User')),
          ],
        ),
      ),
    );
  }
}

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Success')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sign-up Successful!', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Return to Login'),
            ),
          ],
        ),
      ),
    );
  }
}
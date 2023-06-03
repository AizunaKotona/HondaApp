import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/widgets.dart';

class Login extends StatefulWidget {
  const Login({Key? key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    // Load rememberMe value from SharedPreferences
    loadRememberMe();
  }

  Future<void> loadRememberMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      rememberMe = prefs.getBool('rememberMe') ?? false;
      if (rememberMe) {
        _emailController.text = prefs.getString('email') ?? '';
        _passwordController.text = prefs.getString('password') ?? '';
      }
    });
  }

  Future<void> saveRememberMe(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', value);
    if (!value) {
      // Clear saved email and password if rememberMe is deselected
      await prefs.remove('email');
      await prefs.remove('password');
    }
  }

  Future<void> saveLoginCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', _emailController.text);
    await prefs.setString('password', _passwordController.text);
  }

  Future<void> login() async {
    var url = Uri.parse(
        'http://103.74.254.174:8080/Honda-0.0.1-SNAPSHOT/api/users/login');

    var body = jsonEncode({
      'email': _emailController.text,
      'password': _passwordController.text,
    });

    var response = await http.post(url, body: body, headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        var token = response.body;
        print('Token: ' + token);

        // Store the token in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        // Save login credentials if rememberMe is selected
        if (rememberMe) {
          await saveLoginCredentials();
        }

        // Navigate the user to the '/home' page
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        print('Response body is empty.');
      }
    } else if (response.statusCode == 401) {
      print('Invalid credentials');
    } else {
      // Not successful, print the error message received
      print('Request failed with status: ${response.statusCode}.');
      print('Error message: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 50, left: 50, bottom: 100),
          child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage(
                  "assets/image/image.png",
                ),
                width: 300,
                height: 250,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Please Sign In"),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        children: [
                          Checkbox(
                            value: rememberMe,
                            onChanged: (value) {
                              setState(() {
                                rememberMe = value!;
                              });
                              saveRememberMe(rememberMe);
                            },
                            visualDensity: VisualDensity.compact,
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.selected)) {
                                return Colors
                                    .red; // Set the color when the checkbox is selected
                              }
                              return Colors
                                  .grey; // Set the color when the checkbox is unselected
                            }),
                          ),
                          Text('Remember me'),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          print('Email: ${_emailController.text}');
                          print('Password: ${_passwordController.text}');
                          login();
                        },
                        child: Text('Login'),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                          minimumSize: MaterialStateProperty.all(Size(400, 50)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

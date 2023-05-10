
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: ListView(
          children: <Widget>[
            Column(children: <Widget>[
              emailAddress(),
              password(),
              CheckboxListTile(
                title: Text("Remember me"),
                value: _rememberMe,
    onChanged: (bool?newValue) {
      setState(() {
        _rememberMe = newValue??false;
      });
    },
    controlAffinity: ListTileControlAffinity.leading,
              ),
              loginButton(context),
              forgotYourPassword(context),
            ]),
          ],
        )),
      ),
    );
  }
}

TextFormField emailAddress() {
  return TextFormField(
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      labelText: 'Email Address',
      border: OutlineInputBorder(),
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return 'Please enter your email address';
      }
      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
        return 'Please enter a valid email address';
      }
      return null;
    },
  );
}
TextFormField password(){
  return TextFormField(
    keyboardType: TextInputType.visiblePassword,
     decoration: InputDecoration(
      labelText: 'Password',
      border: OutlineInputBorder(),
    ),
    obscureText: true,
    validator: (value) {
      if (value!.isEmpty) {
        return 'Please enter your password';
      }
      return null;
    },
  );
}

ElevatedButton loginButton(BuildContext context){
  return ElevatedButton(onPressed: (){
    Navigator.pushReplacementNamed(context, '/home');
  },
  child: Text('Login'),
  );
}
InkWell forgotYourPassword(BuildContext context){
  return InkWell(
    child: Text('Forgot your password'),
    onTap: () {
      Navigator.pushNamed(context, '/forgotYourPassword');
    },
    
  );
}
import 'package:flutter/material.dart';
import 'package:my_plate/screens/reset_password_screen.dart';
import 'package:my_plate/screens/sign_up_screen.dart';


import '../services/auth_service.dart';
import 'login_screen.dart';

class AuthScreen extends StatefulWidget {
  static String routeName = '/auth';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthService authService = AuthService();

  bool loginScreen = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('My Plate'),
        backgroundColor: Color(0xff588157),
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              loginScreen ? LoginForm() : RegisterForm(),
              SizedBox(height: 5),
              loginScreen ? TextButton(onPressed: () {
                setState(() {
                  loginScreen = false;
                });

              }, child: Text('No account? Sign up here!', style: TextStyle(color: Color(0xff588157)),)) :
              TextButton(onPressed: () {
                setState(() {
                  loginScreen = true;
                });
              }, child: Text('Exisiting user? Login in here!', style: TextStyle(color: Color(0xff588157)))),
              TextButton(onPressed: () {
                setState(() {
                  loginScreen = true;
                });
                Navigator.of(context).pushNamed(ResetPasswordScreen.routeName);
              }, child: Text('Forgotten Password',style: TextStyle(color: Color(0xff588157)))),


              // loginScreen ? TextButton(onPressed: () {
              //   Navigator.of(context).pushNamed(ResetPasswordScreen.routeName);
              // }, child: Text('Forgotten Password')) : Center()
            ],
          )
      ),
    );
  }
}

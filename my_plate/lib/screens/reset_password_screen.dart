import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class ResetPasswordScreen extends StatefulWidget {
  static String routeName = '/reset-password';
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}
class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String? email;
  var form = GlobalKey<FormState>();
  reset() {
    bool isValid = form.currentState!.validate();
    if (isValid) {
      form.currentState!.save();
      AuthService authService = AuthService();
      return authService.forgotPassword(email).then((value) {
        FocusScope.of(context).unfocus();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please check your email for to reset your password!'),));
        Navigator.of(context).pop();
      }).catchError((error) {
        FocusScope.of(context).unfocus();
        String message = error.toString();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),));
      });
    }
  }
  @override

  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff588157),
        title: Text('My Plate'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: form,
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              Text('Having trouble logging in?', textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              SizedBox(height: 2,),
              Text('We will send you a link via email with instructions. Enter your email to recover your password.', style: TextStyle(fontSize: 15),),
              TextFormField(
                decoration: InputDecoration(label: Text('Email')),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null)
                    return "Please provide an email address.";
                  else if (!value.contains('@'))
                    return "Please provide a valid email address.";
                  else
                    return null;
                },
                onSaved: (value) {
                  email = value;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff588157),
                  ),
                  onPressed: () { reset(); },
                  child: Text('Reset Password')),
              SizedBox(height: 80,),
              Image.asset('images/forget_password.png')
            ],

          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/firestore_service.dart';


class RegisterForm extends StatefulWidget {

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  FirestoreService fsService = FirestoreService();
  String? name;
  String? email;
  String? password;
  String? confirmPassword;


  var form = GlobalKey<FormState>();


  register() {
    bool isValid = form.currentState!.validate();

    if (isValid) {
      form.currentState!.save();
      fsService.addUser(name, email);
      if (password != confirmPassword) {
        FocusScope.of(context).unfocus();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password and Confirm Password does not match!'),));
      }

      AuthService authService = AuthService();

      return authService.register(name, email, password).then((value) {
        FocusScope.of(context).unfocus();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User Registered successfully!'),));
        Navigator.of(context).pushReplacementNamed('/'); }).catchError((error) {
        FocusScope.of(context).unfocus();
        String message = error.toString().contains('] ') ? error.toString().split('] ')[1] : 'An error has occurred.';
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(

      key: form,
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          TextFormField(
            decoration: InputDecoration(label: Text('Name')),
    validator: (value) {
    if (value == null)
    return 'Please provide your name.';
    else if
    (value.length<1)
    return 'Please provide a valid name.';
    else
    return null;

    },
            onSaved: (value) {
              name = value;
            },
          ),
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
          TextFormField(
            decoration: InputDecoration(label: Text('Password')),
            obscureText: true,
            validator: (value) {
              if (value == null)
                return 'Please provide a password.';
              else if (value.length < 6)
                return 'Password must be at least 6 characters.';
              else
                return null;
            },
            onSaved: (value) {
              password = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(label: Text('Confirm Password')),
            obscureText: true,
            validator: (value) {
              if (value == null)
                return 'Please provide a password.';
              else if (value.length < 6)
                return 'Password must be at least 6 characters.';
              else
                return null;
            },
            onSaved: (value) {
              confirmPassword = value;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
          style: ElevatedButton.styleFrom(
          primary: Color(0xff588157),
    ),
              onPressed: () { register();

            }, child: Text('Register')),
          Image.asset('images/register.png', height: 140,),
        ],
      ),
    );
  }
}

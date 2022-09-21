import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_plate/models/user.dart';
import 'package:my_plate/screens/profile_screen.dart';
import '../services/firestore_service.dart';

class EditProfilePage extends StatefulWidget {
  static String routeName = '/edit-profile';

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  var form = GlobalKey<FormState>();

  String? password;
  String? oldPassword;
  String? name;
//not using provider anymore
  void saveForm(String id) {
    bool isValid = form.currentState!.validate();

    if (isValid) {
      form.currentState!.save();
      print(name);
      // print(password);

      FirestoreService fsService = FirestoreService();
      fsService.editUserDetails(name, id);
      // Hide the keyboard
      FocusScope.of(context).unfocus();
      // Resets the form
      form.currentState!.reset();
      // Shows a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Profile updated successfully!'),
      ));
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).pushNamed(ProfilePage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    Users selectedUser = arguments!['selected'] as Users;
    int index = arguments!['index'] as int;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff588157),
          title: Text('Edit Profile'),
          actions: [
            IconButton(
                onPressed: () {
                  saveForm(selectedUser.id);
                },
                icon: Icon(Icons.save))
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Form(
            key: form,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                    initialValue: selectedUser.name,
                    decoration: InputDecoration(
                      label: Text(
                        'Name',
                        style: TextStyle(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff588157),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff588157),
                          width: 0.0,
                        ),
                      ),
                    ),
                    onSaved: (value) {
                      name = value;
                    },
                    validator: (value) {
                      if (value == null)
                        return "Please provide a name.";
                      else if (value.length < 1)
                        return "Please provide a valid name.";
                      else
                        return null;
                    }),
                SizedBox(
                  height: 10,
                ),
                // TextFormField(
                //     obscureText: true,
                //     decoration: InputDecoration(
                //       label: Text(
                //         'Please enter your old password',
                //         style: TextStyle(color: Colors.black),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(
                //           color: Color(0xff588157),
                //         ),
                //       ),
                //       enabledBorder: OutlineInputBorder(
                //         borderSide: BorderSide(
                //           color: Color(0xff588157),
                //           width: 0.0,
                //         ),
                //       ),
                //     ),
                //     onSaved: (value) {
                //       oldPassword = value;
                //     },
                //     validator: (oldPassword) {
                //       if (oldPassword == null)
                //         return 'Please enter your old password.';
                //       else if (oldPassword != selectedUser.password)
                //         return 'Please ensure you entered the correct old password';
                //       else
                //         return null;
                //     }),
                // SizedBox(
                //   height: 10,
                // ),
                // //must match old password
                // TextFormField(
                //     obscureText: true,
                //     decoration: InputDecoration(
                //       label: Text(
                //         'Please enter your new password',
                //         style: TextStyle(color: Colors.black),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(
                //           color: Color(0xff588157),
                //         ),
                //       ),
                //       enabledBorder: OutlineInputBorder(
                //         borderSide: BorderSide(
                //           color: Color(0xff588157),
                //           width: 0.0,
                //         ),
                //       ),
                //     ),
                //     onSaved: (value) {
                //       password = value;
                //     },
                //     validator: (value) {
                //       if (value == null)
                //         return 'Please provide a password.';
                //       else if (value.length < 6)
                //         return 'Your password must be of at least 6 characters';
                //       else
                //         return null;
                //     }),
              ],
            ),
          ),
        ));
  }
}

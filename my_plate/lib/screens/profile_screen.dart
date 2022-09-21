import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_plate/screens/edit_profile.dart';
import 'package:my_plate/screens/user_guide_screen.dart';
import 'package:my_plate/widgets/app_drawer.dart';

import '../models/user.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';

class ProfilePage extends StatefulWidget {
  static String routeName = '/profile';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String? userid = FirebaseAuth.instance.currentUser!.uid;
  AuthService authService = AuthService();
  FirestoreService fsService = FirestoreService();
  File? imageFile;
  var name;
  var email;
  @override
  Widget build(BuildContext context) {
    print(downloadUrl);
    if (downloadUrl == null) getExistingImage();

    return Scaffold(
        drawer: AppDrawer(),
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text('Profile'),
          backgroundColor: Color(0xff588157),
          elevation: 1,
          actions: [
            IconButton(
              icon: Icon(Icons.library_books_outlined),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserGuideListScreen(),
                    ));
              },
            ),
          ],
        ),
        body: StreamBuilder<List<Users>>(
            stream: fsService.getUser(),
            builder: (context, snapshot) {

              return snapshot.connectionState == ConnectionState.waiting
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      padding: EdgeInsets.all(10),
                      itemCount: snapshot.data!
                          .length,
                  //itemCount prevents error (Range Error: index - not in inclusive range)
                      itemBuilder: (context, index) {

                          name = snapshot.data![index].name ;

                          email = snapshot.data![index].email ;
                        print(name);
                        print(email);
                        // User user = myGuides[i];

                        return Container(
                          child: Column(
                            children: [
                              if (downloadUrl != null)
                                Container(
                                    width: 200,
                                    height: 200,
                                    alignment: Alignment.center,
                                    child: CircleAvatar(
                                      foregroundImage:
                                          NetworkImage(downloadUrl),
                                      maxRadius: 80,
                                    )
                                    // BoxDecoration(
                                    //   color: Colors.grey,
                                    //   image: DecorationImage(
                                    //       image: FileImage(imageFile!),
                                    //       fit: BoxFit.cover
                                    //   ),
                                    //   border: Border.all(width: 8, color: Color(0xff588157)),
                                    //   borderRadius: BorderRadius.circular(12.0),
                                    // ),
                                    )
                              else
                                Container(
                                    width: 200,
                                    height: 200,
                                    alignment: Alignment.center,
                                    child: CircleAvatar(
                                      foregroundImage:
                                          AssetImage('images/profile.jpeg'),
                                      maxRadius: 80,
                                    )
                                    // decoration: BoxDecoration(
                                    //
                                    //   color: Colors.white,
                                    //   border: Border.all(width: 8, color: Color(0xff588157)),
                                    //   borderRadius: BorderRadius.circular(12.0),
                                    // ),

                                    ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Color(0xff588157)),
                                        onPressed: () => getImage(
                                            source: ImageSource.camera),
                                        child: const Text('Capture Image',
                                            style: TextStyle(fontSize: 18))),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Color(0xff588157)),
                                        onPressed: () => getImage(
                                            source: ImageSource.gallery),
                                        child: const Text('Select Image',
                                            style: TextStyle(fontSize: 18))),
                                  ),
                                ],
                              ),
                              //image picker ends here
                              SizedBox(
                                height: 20,
                              ),

                              TextFormField(
                                readOnly: true,
                                initialValue: name,
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
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                readOnly: true,
                                initialValue: email,
                                decoration: InputDecoration(
                                  label: Text(
                                    'Email',
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
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Color(0xff588157)),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, EditProfilePage.routeName,
                                            arguments: {
                                              'index': index,
                                              'selected': snapshot.data![index]
                                            });
                                        print(snapshot.data![index].name);
                                      },
                                      child: Text('Edit Profile Details',
                                          style: TextStyle(fontSize: 18))),
                                  const SizedBox(width: 3.5),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Color(0xff588157)),
                                      onPressed: () {
                                        deactivateAccount(
                                            snapshot.data![index].id);
                                      },
                                      child: Text('Deactivate Account',
                                          style: TextStyle(fontSize: 18)))
                                ],
                              ),
                            ],
                          ),
                        );
                      });
            }));
  }

  void getImage({required ImageSource source}) async {
    final _storage = FirebaseStorage.instance;
    final file = await ImagePicker().pickImage(
        source: source,
        maxWidth: 640,
        maxHeight: 480,
        imageQuality: 70 //0 - 100
        );

    if (file?.path != null) {
      setState(() {
        imageFile = File(file!.path);
      });
      _storage.ref().child('${userid}/imageName').putFile(imageFile!).then((task) {
        task.ref.getDownloadURL().then((imageUrl) {
          setState(() {
            downloadUrl = imageUrl;
          });
        });
      });


      // _storage.ref().child('${userid}/imageName').putFile(imageFile!);
    }
  }

  var downloadUrl;
  void getExistingImage() {
    FirebaseStorage.instance
        .ref()
        .child('${userid}/imageName')
        .getDownloadURL()
        .then((value) {
      setState(() {
        downloadUrl = value;
      });
      print(value);
    });
  }

  void deactivateAccount(String id) {
    showDialog<Null>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Confirmation'),
            content: Text('Are you sure you want to deactivate your account?'),
//alert dialogue to prompt user before they delete

            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      fsService.deleteUser();
                      logOutAfterDeleteUser(); //works
                      fsService.deleteUserRecordsCalories(); //works
                      fsService.deleteUserRecordsFavorites(); //works
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Your account has been deactivated'),
                      ));
                    });
                    Navigator.of(context).pop();
                  },
                  child:
                      Text('Yes', style: TextStyle(color: Color(0xff588157)))),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child:
                      Text('No', style: TextStyle(color: Color(0xff588157)))),
            ],
          );
        });
  }

  logOutAfterDeleteUser() {
    return authService.logOut().then((value) {
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      Navigator.of(context).pushNamed('/');
    }).catchError((error) {
      FocusScope.of(context).unfocus();
      String message = error.toString();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    });
  }
}
// padding: EdgeInsets.only(left: 16, top: 25, right: 16),
// child: GestureDetector(
// onTap: () {
// FocusScope.of(context).unfocus();
// },
//
// child: ListView(
//
// children: [
//
// Center(
// child: Text(
// "Profile",
// style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
// ),
// ),
// SizedBox(
// height: 15,
// ),
// Center(
// child: Stack(
// children: [
// Container(
// width: 130,
// height: 130,
// decoration: BoxDecoration(
// //decoration helps to change the default colour of text fields and text form fields
// border: Border.all(
// width: 4,
// color: Theme.of(context).scaffoldBackgroundColor),
// boxShadow: [
// BoxShadow(
// spreadRadius: 2,
// blurRadius: 10,
// color: Colors.black.withOpacity(0.1),
// offset: Offset(0, 10))
// ],
// shape: BoxShape.circle,
// image: DecorationImage(
// fit: BoxFit.cover,
// image: NetworkImage(
// "https://i.postimg.cc/gj4CDtjX/image.png",
// ))),
// ),
// Positioned(
// bottom: 0,
// right: 0,
// child: Container(
// height: 40,
// width: 40,
// decoration: BoxDecoration(
// shape: BoxShape.circle,
// border: Border.all(
// width: 4,
// color: Theme.of(context).scaffoldBackgroundColor,
// ),
// color: Color(0xff588157),
// ),
// child: Icon(
// Icons.edit,
// color: Colors.white,
// ),
// )),
// ],
// ),
// ),
// SizedBox(
// height: 35,
// ),
// TextFormField(initialValue: "carolyn1234", // initial value is only applicable to text form field
// // helps to specify default/initial value of text form field
// decoration: InputDecoration(label: Text('Username',style: TextStyle(color: Colors.black),),
// focusedBorder: OutlineInputBorder(
// borderSide: BorderSide(
// color: Color(0xff588157),
// ),
// ),
// enabledBorder: OutlineInputBorder(
//
// borderSide: BorderSide(
// color: Color(0xff588157),
// width: 0.0,
// ),
// ),
// ),
// ),
// SizedBox(
// height: 15,
// ),
// TextFormField(initialValue: "carolyn@gmail.com",
// decoration: InputDecoration(label: Text('Email',style: TextStyle(color: Colors.black),),
// focusedBorder: OutlineInputBorder(
// borderSide: BorderSide(
// color: Color(0xff588157),
// ),
// ),
// enabledBorder: OutlineInputBorder(
//
// borderSide: BorderSide(
// color: Color(0xff588157),
// width: 0.0,
// ),
// ),
// ),
// ),
// SizedBox(
// height: 15,
// ),
// TextFormField(initialValue: "********",
// decoration: InputDecoration(label: Text('Password',style: TextStyle(color: Colors.black),),
// focusedBorder: OutlineInputBorder(
// borderSide: BorderSide(
// color: Color(0xff588157),
// ),
// ),
// enabledBorder: OutlineInputBorder(
//
// borderSide: BorderSide(
// color: Color(0xff588157),
// width: 0.0,
// ),
// ),
// ),
// ),
// SizedBox(
// height: 35,
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
//
//
// RaisedButton(
// onPressed: () {
//
//
// },
// color: Color(0xff588157),
// padding: EdgeInsets.symmetric(horizontal: 20),
// elevation: 2,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(20)),
// child: Text(
// "Update Details",
// style: TextStyle(
// fontSize: 15,
// letterSpacing: 2.2,
// color: Colors.white),
// ),
// ),
// RaisedButton(
// onPressed: () {
//
//
// },
// color: Color(0xff588157),
// padding: EdgeInsets.symmetric(horizontal: 20),
// elevation: 2,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(20)),
// child: Text(
// "Delete Account",
// style: TextStyle(
// fontSize: 15,
// letterSpacing: 2.2,
// color: Colors.white),
// ),
// )
//
//
// ],
// )
// ],
// ),
// ),
// ),

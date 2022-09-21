import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_plate/providers/all_calories.dart';
import 'package:my_plate/providers/all_recipes.dart';
import 'package:my_plate/screens/add_calories_screen.dart';
import 'package:my_plate/screens/auth_screen.dart';
import 'package:my_plate/screens/calories_list_screen.dart';
import 'package:my_plate/screens/edit_calories_screen.dart';
import 'package:my_plate/screens/edit_profile.dart';
import 'package:my_plate/screens/feedback_form.dart';
import 'package:my_plate/screens/healthy_food_screen.dart';
import 'package:my_plate/screens/home_screen.dart';
import 'package:my_plate/screens/login_screen.dart';
import 'package:my_plate/screens/previous_records_screen.dart';
import 'package:my_plate/screens/profile_screen.dart';
import 'package:my_plate/screens/recipe_details_screen.dart';
import 'package:my_plate/screens/reminder_screen.dart';
import 'package:my_plate/screens/reset_password_screen.dart';
import 'package:my_plate/screens/sign_up_screen.dart';
import 'package:my_plate/screens/user_guide_screen.dart';
import 'package:my_plate/services/auth_service.dart';
import 'package:my_plate/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (ctx, snapshot) => snapshot.connectionState ==
          ConnectionState.waiting ?
      Center(child: CircularProgressIndicator()) : StreamBuilder<User?>(
        stream: authService.getAuthUser(),
        builder: (context, snapshot) {
          return FutureBuilder(
            future: Firebase.initializeApp(),
            builder: (ctx, snapshot) =>MaterialApp(
                theme: ThemeData(
                  backgroundColor: Color(0xff588157),
                ),
                home: HomePage(),
                // Specifying the routes for all screens in application
                routes: {
                  AddCaloriesScreen.routeName: (_) {
                    return AddCaloriesScreen();
                  },
                  CaloriesListScreen.routeName: (_) {
                    return CaloriesListScreen();
                  },
                  HealthyFoodScreen.routeName: (_) {
                    return HealthyFoodScreen();
                  },
                  MainScreen.routeName: (_) {
                    return MainScreen();
                  },
                  EditProfilePage.routeName: (_) {
                    return EditProfilePage();
                  },
                  FormApp.routeName: (_) {
                    return FormApp();
                  },
                  UserGuideListScreen.routeName: (_) {
                    return UserGuideListScreen();
                  },
                  RecordsPage.routeName: (_) {
                    return RecordsPage();
                  },
                  EditCaloriesScreen.routeName: (_){
                    return EditCaloriesScreen();
                  },
                  ResetPasswordScreen.routeName:(_){
                    return ResetPasswordScreen();
                  },
                  ProfilePage.routeName:(_){
                    return ProfilePage();
                  },
                  EditProfilePage.routeName:(_){
                    return EditProfilePage();
                  },
                  RecipeDetailsScreen.routeName:(_){
                    return RecipeDetailsScreen();
                  },
                  NotificationsPage.routeName:(_){
                    return NotificationsPage();
                  }
                  // HomePage.routeName: (_){
                  //   HomePage(snapshot.data as User)
                  // }
                 // Records.routeName: (_) {
                 //    return Records();
                 //  },

                }),
          );
        }
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  AuthService authService = AuthService();
  static String routeName = '/';
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authService.getAuthUser(),
      builder: (context, snapshot) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              color: Colors.white,
              // we will give media query height
              // double.infinity make it big as the parent allows
              // while MediaQuery make it big as per the screen
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Column(
                // even space distribution
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        "Welcome",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Start your calorie counting journey today! ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/welcome.png"))),
                  ),
                  Column(
                    children: <Widget>[
                      // the login button
                      MaterialButton(
                        color: Color(0xff588157),
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () {
                          snapshot.connectionState == ConnectionState.waiting ?
                          Center(child: CircularProgressIndicator()) :
                          snapshot.hasData ? Navigator.of(context).pushNamed('/main'):
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => AuthScreen()));
                        },
                        // defining the shape
                        shape: RoundedRectangleBorder(


                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          "Login",
                          style:

                              TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white),
                        ),
                      ),
                      // creating the signup button
                      SizedBox(height: 20),
                      // MaterialButton(
                      //   minWidth: double.infinity,
                      //   height: 60,
                      //   onPressed: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => RegisterForm()));
                      //   },
                      //   color: Color(0xff588157),
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(50)),
                      //   child: Text(
                      //     "Sign up",
                      //     style: TextStyle(
                      //         color: Colors.white,
                      //         fontWeight: FontWeight.w600,
                      //         fontSize: 18),
                      //
                      //   ),
                      // )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}

// class MainScreen extends StatefulWidget {
//   static String routeName = '/home';
//   @override
//   State<MainScreen> createState() => _MainScreenState();
//
// }
//
// class _MainScreenState extends State<MainScreen> {
//   @override
//   Widget build(BuildContext context) {
//     AllCalories caloriesList = Provider.of<AllCalories>(context);
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         title: Text('My Plate'),
//         backgroundColor: Color(0xff588157),
//       ),
//       body: Column(
//         children: [
//           Image.asset('images/home.png',width: 400,)
//         ],
//       ),
//       drawer: AppDrawer(),
//     );
//   }
//
// }

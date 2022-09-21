import 'package:flutter/material.dart';
import 'package:my_plate/main.dart';
import 'package:my_plate/screens/calories_list_screen.dart';
import 'package:my_plate/screens/feedback_form.dart';
import 'package:my_plate/screens/healthy_food_screen.dart';
import 'package:my_plate/screens/home_screen.dart';
import 'package:my_plate/screens/previous_records_screen.dart';
import 'package:my_plate/screens/profile_screen.dart';
import 'package:my_plate/screens/reminder_screen.dart';

//Navigator.of(context) specifies route, which screen the list tile will go to when tapped
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xffE7e7db ),
      child: Column(children: [
        AppBar(
          title: Text("Welcome to My Plate!"),
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xff2e6b2d),
        ),
        Image.asset('images/drawer.gif', ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Home'),
          onTap: () =>
              Navigator.of(context).pushReplacementNamed(MainScreen.routeName),
        ),
        Divider(height: 3, color: Colors.blueGrey),
        ListTile(
          leading: Icon(Icons.calendar_today_sharp),
          title: Text('Previous records'),
          onTap: () =>
              Navigator.of(context).pushReplacementNamed(RecordsPage.routeName),
        ),
        Divider(height: 3, color: Colors.blueGrey),
        ListTile(
          leading: Icon(Icons.assignment_sharp),
          title: Text('My Calories'),
          onTap: () => Navigator.of(context)
              .pushReplacementNamed(CaloriesListScreen.routeName),
        ),
        Divider(height: 3, color: Colors.blueGrey),
        ListTile(
          leading: Icon(Icons.local_dining),
          title: Text('Healthy food recommendations'),
           onTap: () =>
           Navigator.of(context).pushReplacementNamed(HealthyFoodScreen.routeName),
        ),
        Divider(height: 3, color: Colors.blueGrey),
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Profile'),
           onTap: () =>
          Navigator.of(context).pushReplacementNamed(ProfilePage.routeName),
        ),
        Divider(height: 3, color: Colors.blueGrey),
        ListTile(
          leading: Icon(Icons.description_sharp),
          title: Text('Feedback'),
          onTap: () =>
              Navigator.of(context).pushReplacementNamed(FormApp.routeName),
        ),

        Divider(height: 3, color: Colors.blueGrey),
        ListTile(
          leading: Icon(Icons.circle_notifications),
          title: Text('Notifications'),
          onTap: () =>
              Navigator.of(context).pushReplacementNamed(NotificationsPage.routeName),
        ),

        Divider(height: 3, color: Colors.blueGrey),
        // SizedBox(height: 83.6,),

      ]),
    );
  }
}

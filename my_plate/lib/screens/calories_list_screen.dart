import 'package:flutter/material.dart';
import 'package:my_plate/providers/all_calories.dart';
import 'package:my_plate/screens/add_calories_screen.dart';
import 'package:my_plate/widgets/app_drawer.dart';
import 'package:my_plate/widgets/calories_list.dart';
import 'package:provider/provider.dart';

import '../models/calories.dart';
import '../services/firestore_service.dart';

class CaloriesListScreen extends StatelessWidget {
  static String routeName = '/calories-list';
  @override
  Widget build(BuildContext context) {
    FirestoreService fsService = FirestoreService();
    // AllCalories caloriesList = Provider.of<AllCalories>(context);
    return StreamBuilder<List<Calories>>(
        stream: fsService.getCalories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return  Center(child: CircularProgressIndicator());
          else {
            print(snapshot.hasData);

            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text('My Calories'),
                backgroundColor: Color(0xff588157),
              ),
              body: Container(
                  alignment: Alignment.center,
                  child: snapshot.hasData && snapshot.data!.length > 0
                      ? CaloriesList()
                      : Column(
                    children: [
                      Image.asset('images/list2.png', width: 400),
                      Text(
                          "No meals added, start today's calorie counting journey!",
                          style: Theme
                              .of(context)
                              .textTheme
                              .subtitle2),
                    ],
                  )),
              drawer: AppDrawer(),
              floatingActionButton: FloatingActionButton(
                  backgroundColor: Color(0xff588157),
                  onPressed: () {
                    Navigator.of(context).pushNamed(AddCaloriesScreen.routeName);
                  },
                  child: Icon(Icons.add)),
            );
          }
        }
    );
  }
}

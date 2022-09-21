import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_plate/providers/all_calories.dart';
import 'package:provider/provider.dart';

import '../services/firestore_service.dart';

class AddCaloriesScreen extends StatefulWidget {
  static String routeName = '/add-calories';

  @override
  State<AddCaloriesScreen> createState() => _AddCaloriesScreenState();
}

class _AddCaloriesScreenState extends State<AddCaloriesScreen> {
  var form = GlobalKey<FormState>();
//specifies the data type of list items
  String? mealType;

  String? mealName;

  double? numCalories;

  double? weight;

  DateTime? consumptionDate;

  void saveForm() {
    bool isValid = form.currentState!.validate();

    if (isValid) {
      //checks that form is valid before submitting
      form.currentState!.save();
      if (consumptionDate == null) consumptionDate = DateTime.now();
      print(mealType);
      print(mealName);
      print(numCalories!.toStringAsFixed(2));
      print(weight!.toStringAsFixed(2));

      // caloriesList.addCalories(
      //     mealType, mealName, numCalories, weight, consumptionDate);
      FirestoreService fsService = FirestoreService();
      fsService.addCalories(mealType, mealName, numCalories, weight, consumptionDate);
      // Hide the keyboard
      FocusScope.of(context).unfocus();
      // Resets the form
      form.currentState!.reset();
      consumptionDate = null;
      // Shows a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Meal saved successfully!'),
      ));
    }
  }

  void presentDatePicker(BuildContext context) {
    showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xff588157), // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Color(0xff588157), // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 14)),
      lastDate: DateTime.now(),
//The firstDate is the earliest allowable date.
      // The lastDate is the latest allowable date.
      // initialDate must either fall between these dates, or be equal to one of them.
    ).then((value) {
      if (value == null) return;
      setState(() {
        consumptionDate = value;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    // AllCalories caloriesList = Provider.of<AllCalories>(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Add a Meal'),
          actions: [
            IconButton(
                onPressed: () {
                  saveForm();
                },
                icon: Icon(Icons.save))
          ],
          backgroundColor: Color(0xff588157),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Form(
            key: form,
            child: Column(

              children: [
            Image.asset('images/hamburger.png',height: 170, alignment: Alignment.topCenter,),
                TextFormField(

                    decoration: InputDecoration(label: Text('Meal Name',style: TextStyle(color: Colors.black),),
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
                    onSaved: (value) { mealName = value;  },
                    validator: (value) {
                      if (value == null)
                        return 'Please provide the name of your meal.';
                      else if
                        (value.length<1)
                        return 'Please provide the name of your meal';
                      else
                        return null;

                    }

                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: DropdownButtonFormField(

                    decoration: InputDecoration.collapsed(

                      // label: Text('Type of meal',style: TextStyle(color: Colors.black)),
                      hintText: 'Type of Meal',
                        // border: UnderlineInputBorder(
                        //     borderSide:
                        //     BorderSide(color: Colors.black))

                    ),


                    items: [
                      DropdownMenuItem(
                          child: Text('Breakfast'), value: 'Breakfast'),

                      DropdownMenuItem(child: Text('Lunch'), value: 'Lunch'),
                      DropdownMenuItem(child: Text('Dinner'), value: 'Dinner'),
                      DropdownMenuItem(child: Text('Dessert'), value: 'Dessert'),
                      DropdownMenuItem(child: Text('Snack'), value: 'Snack')
                    ],
                    onChanged: (value) {
                      mealType = value as String;
                    },
                    validator: (value) {
                      if (value == null)
                        return "Please specify the type of meal you had!";
                      else
                        return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                    keyboardType: TextInputType.number,// so that keyboard only has numbers for numeric values like calories
                    decoration:
                        InputDecoration(label: Text('Number of Calories', style: TextStyle(color: Colors.black)),
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
                      numCalories = double.parse(value!);
                    },
                    validator: (value) {
                      if (value == null)
                        return "Please indicate the number of calories you consumed.";
                      else if (double.tryParse(value) == null)
                        return "Please provide a valid calorie consumption.";
                      else
                        return null;
                    }),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                    keyboardType: TextInputType.number,//so that keyboard only has numbers for numeric values like weight
                    decoration: InputDecoration(label: Text('Weight',style: TextStyle(color: Colors.black)),
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
                      weight = double.parse(value!);
                    },
                    validator: (value) {
                      if (value == null)
                        return "Please indicate your current weight.";
                      else if (double.tryParse(value) == null)
                        return "Please provide a valid weight.";
                      else
                        return null;
                    }),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(consumptionDate == null
                          ? 'No Date Chosen'
                          : "Picked date: " +
                              DateFormat('dd/MM/yyyy').format(consumptionDate!)),
                      //helps to format date to desired format
                      TextButton(
                          child: Text('Choose Date',
                              style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff588157))),
                          onPressed: () {
                            presentDatePicker(context);
                          })

                    ],
                  ),
                ),

              ],

            ),

          ),

        )

    );

  }
}

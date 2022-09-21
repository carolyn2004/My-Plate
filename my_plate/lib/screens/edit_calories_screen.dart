import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_plate/models/calories.dart';
import 'package:my_plate/providers/all_calories.dart';
import 'package:my_plate/widgets/calories_list.dart';
import 'package:provider/provider.dart';

import '../services/firestore_service.dart';

class EditCaloriesScreen extends StatefulWidget {
  static String routeName = '/edit-calories';

  @override
  State<EditCaloriesScreen> createState() => _EditCaloriesScreenState();
}

class _EditCaloriesScreenState extends State<EditCaloriesScreen> {
  var form = GlobalKey<FormState>();
//specifies data type of list items
  String? mealType;

  String? mealName;

  double? numCalories;

  double? weight;

  DateTime? consumptionDate;

  void updateForm(String id) {
    bool isValid = form.currentState!.validate();

    if (isValid) {
      form.currentState!.save();
      if (consumptionDate == null) consumptionDate = DateTime.now();
      print(mealName);
      print(mealType);
      print(numCalories!.toStringAsFixed(2));
      print(weight);

      FirestoreService fsService = FirestoreService();
      fsService.editCalories(id, mealType, mealName, numCalories, weight, consumptionDate);

      // Hide the keyboard
      FocusScope.of(context).unfocus();
      // Resets the form
      form.currentState!.reset();
      consumptionDate = null;
      // Shows a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
      Text('Calories updated successfully!'),));
      Navigator.of(context).pop();
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

    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    Calories selectedItem = arguments!['selected'] as Calories;
    int index = arguments!['index'] as int;
    // AllCalories caloriesList = Provider.of<AllCalories>(context);
    // we were able to parse the information from the list tile through the parameters
    // we called it selected item
    // we set the initial value and value to selecedItem.data to be able to allow the user to enter the previous data that
    //they had keyed in

    print(selectedItem.weight.toString());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Edit a Meal'),
          actions: [IconButton(onPressed: () {
            updateForm(selectedItem.id );


          }, icon: Icon(Icons.save))],
          backgroundColor: Color(0xff588157),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Form(
            key: form,
            child: Column(
              children: [
                Image.asset(
                  'images/edit.png',
                  height: 200,
                  alignment: Alignment.topCenter,
                ),
                TextFormField(
                  //Validators are used to prevent users from submitting empty values in the edit screen
                    decoration: InputDecoration(label: Text('Meal Name',style: TextStyle(color: Colors.black)),
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
                    initialValue: selectedItem.mealName,
                    // controller:
                    // TextEditingController(text: CaloriesList.getMyCalories()[i].mealType),
                    onSaved: (value) {
                      mealName = value;
                    },
                    validator: (value) {
                      if (value == null)
                        return 'Please provide the name of your meal.';
                      else if (value.length < 1)
                        return 'Please provide the name of your meal';
                      else
                        return null;
                    }),

                Container(
                  padding: EdgeInsets.all(5),
                  child: DropdownButtonFormField(
                    value: selectedItem.mealType,
                    decoration: InputDecoration(
                      label: Text('Type of meal',style: TextStyle(color: Colors.black)),
                    ),
                    items: [
                      DropdownMenuItem(
                        child: Text('Breakfast'),
                        value: 'Breakfast',
                      ),
                      DropdownMenuItem(child: Text('Lunch'), value: 'Lunch'),
                      DropdownMenuItem(child: Text('Dinner'), value: 'Dinner'),
                      DropdownMenuItem(child: Text('Dessert'), value: 'Dessert'),
                      DropdownMenuItem(child: Text('Snack'), value: 'Snack')
                    ],
                    onChanged: (value) {
                      mealType = value as String;
                    },
                    onSaved: (value) {
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
                  height: 15,
                ),
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration:
                        InputDecoration(label: Text('Number of Calories',style: TextStyle(color: Colors.black)),
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

                    initialValue: selectedItem.numCalories.toString(),
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
                  height: 15,
                ),
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration:
                    InputDecoration(label: Text('Weight',style: TextStyle(color: Colors.black)),
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

                    initialValue: selectedItem.weight.toString(),
                    onSaved: (value) {
                      weight = double.parse(value!);
                    },
                    validator: (value) {
                      if (value == null)
                        return "Please indicate your weight.";
                      else if (double.tryParse(value) == null)
                        return "Please provide a valid weight.";
                      else
                        return null;
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(consumptionDate == null
                        ? "Picked date: " +
                            DateFormat('dd/MM/yyyy').format(selectedItem.consumptionDate)
                        : "Picked date: " +
                            DateFormat('dd/MM/yyyy').format(consumptionDate!)),
                    TextButton(
                        child: Text('Choose Date',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff588157))),
                        onPressed: () {
                          presentDatePicker(context);
                        })
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}




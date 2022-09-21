// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:my_plate/models/calories.dart';
//
// class AllCalories with ChangeNotifier {
//   List<Calories> myCalories = [];
//
//   //declare a holder of your data
//
//   List<Calories> getMyCalories() {
//     return myCalories;
//   }
//
//   double getTotal(String controller) {
//     double totalCalories = 0;//declaring a variable called totalCalories
// //controller, user input is parsed through the parameters so that the date that users enter
//     //can be used to get the total calorie intake
//     var dateTime = DateFormat('d/M/y').parse(controller);
//     var tmrDate = dateTime.add(const Duration(days: 1));
//     List<Calories> date = myCalories.where((o) {
//       print(o.consumptionDate);
//       if ((o.consumptionDate).isAfter(dateTime) &&
//           (o.consumptionDate).isBefore(tmrDate)) {
//         print(dateTime);
//       }
//
//       return (o.consumptionDate).isAfter(dateTime) &&
//           (o.consumptionDate).isBefore(tmrDate);
//     }).toList();
// //use for loop to loop through the date list and get num calories
//     for (var i = 0; i < date.length; i++) {
//       totalCalories += date[i].numCalories;
//
//       print(totalCalories);
//       print(date[i].numCalories);
//
//       print(date);
//     }
//     return totalCalories;
//   }
//
//   // void addCalories(mealType, mealName, numCalories, weight, consumptionDate) {
//   //   myCalories.insert(
//   //     //using the insert function to create a list (create function)
//   //       0,
//   //       Calories(
//   //           mealType: mealType,
//   //           mealName: mealName,
//   //           numCalories: numCalories,
//   //           weight: weight,
//   //           consumptionDate: consumptionDate));
//   //   notifyListeners();
//   // }
//
//   // void removeCalories(i) {
//   //   myCalories.removeAt(i);
//   //   notifyListeners();
//   //   //removes based on index
//   //
//   // }
//
//   updateCalories(i, mealType, mealName, numCalories, weight, consumptionDate,
//       caloriesList) {
//     myCalories[i].numCalories = numCalories;
//     myCalories[i].mealType = mealType;
//     myCalories[i].mealName = mealName;
//     myCalories[i].consumptionDate = consumptionDate;
//     notifyListeners();
//     //update the calories based on the index, helps to update correct values
//   }
// }
// // class AllCalories with ChangeNotifier {
// //   List<Calories> myCalories = [];
// //
// //   List<Calories> getMyCalories() {
// //     return myCalories;
// //   }
//
// // String controller
// //   getTotal(String controller) {
// //     var dateTime = DateFormat('d/M/y').parse(controller);
// //     var tmrDate = dateTime.add(const Duration(days: 1));
// //
// //     List<Calories> date = myCalories.where((o) {
// //       print(o.consumptionDate);
// //       if ((o.consumptionDate).isAfter(dateTime) &&
// //           (o.consumptionDate).isBefore(tmrDate)) {
// //         print(dateTime);
// //       }
// //       return (o.consumptionDate).isAfter(dateTime) &&
// //           (o.consumptionDate).isBefore(tmrDate);
// //     }).toList();
// //     double sum = 0;
// //     for (var i = 0; i < myCalories.length; i++) {
// //       sum += myCalories[i].numCalories;
// //       print(sum);
// //       print(myCalories[i].numCalories);
// //       print(date);
// //     }
// //     return (sum);
// //   }

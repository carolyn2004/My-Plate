import 'package:cloud_firestore/cloud_firestore.dart';

class Calories {
  String id;
  String email;
  String mealType;
  String mealName;
  double numCalories;
  double weight;
  DateTime consumptionDate;
  Calories(

      {required this.email,required this.id,
        required this.mealType,
        required this.mealName,
        required this.weight,
        required this.numCalories,
        required this.consumptionDate});
  Calories.fromMap(Map <String, dynamic> snapshot,String id) :
        id = id,
        email = snapshot['email'] ?? '',
        mealType = snapshot['mealType'] ?? '',
        mealName = snapshot['mealName'] ?? '',
        numCalories = snapshot['numCalories'] ?? 0,
        weight=snapshot['weight'] ?? 0,
        consumptionDate = (snapshot['consumptionDate'] ?? Timestamp.now() as Timestamp).toDate();
}




// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class Calories {
//   String id;
//   String email;
//   String mealType;
//   String mealName;
//   double numCalories;
//   double weight;
//   DateTime consumptionDate;
//
//   Calories({
//     required this.id,
//     required this.email,
//     required this.mealType,
//     required this.mealName,
//     required this.numCalories,
//     required this.weight,
//     required this.consumptionDate,
//
//   });
//   Calories.fromMap(Map <String, dynamic> snapshot,String id) :
//         id = id,
//         email = snapshot['email'] ?? '',
//         mealType = snapshot['mealType'] ?? '',
//         mealName = snapshot['mealName'] ?? '',
//         numCalories = snapshot['numCalories'] ?? '',
//         consumptionDate = (snapshot['consumptionDate'] ?? Timestamp.now() as
//         Timestamp).toDate();
//
// }

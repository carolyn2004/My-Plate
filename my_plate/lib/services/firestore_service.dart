import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:my_plate/models/calories.dart';
import 'package:my_plate/models/recipes.dart';
import 'package:my_plate/models/user.dart';
import 'package:my_plate/models/user_guide.dart';
import 'package:my_plate/services/auth_service.dart';

class FirestoreService {
  AuthService authService = AuthService();

  addCalories(mealType, mealName, numCalories, weight, consumptionDate) {
    return FirebaseFirestore.instance.collection('calories').add({
      'email': authService.getCurrentUser()!.email,
      'mealType': mealType,
      'mealName': mealName,
      'numCalories': numCalories,
      'weight': weight,
      'consumptionDate': consumptionDate
    });
  }

  Stream<List<Calories>> getCalories() {
    return FirebaseFirestore.instance
        .collection('calories')
        .where('email', isEqualTo: authService.getCurrentUser()!.email)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs
            .map<Calories>((doc) => Calories.fromMap(doc.data(), doc.id))
            .toList());
  }

  removeCalories(id) {
    return FirebaseFirestore.instance.collection('calories').doc(id).delete();
  }
//use of where condition in getRecipes helps us to match the recipe to the title entered in the text form field
  Stream<List<Recipe>> getRecipes(String title) {
    print(title);
    if (title == '') {
      return FirebaseFirestore.instance
          .collection('recipes')

          .snapshots()
          .map((snapshot) =>
          snapshot.docs
              .map<Recipe>((doc) => Recipe.fromMap(doc.data(), doc.id))
              .toList());
    }
    else
      return FirebaseFirestore.instance
          .collection('recipes')
          .where('title', isEqualTo: title)
          .snapshots()
          .map((snapshot) =>
          snapshot.docs
              .map<Recipe>((doc) => Recipe.fromMap(doc.data(), doc.id))
              .toList());
  }
//use update instead of set, to update existing values instead of replacing them
  editUserDetails(name,id) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'name': name});




  }

  editCalories(id, mealType, mealName, numCalories, weight, consumptionDate) {
    return FirebaseFirestore.instance
        .collection('calories')
        .doc(id)
        .update({
      'mealType': mealType,
      'mealName': mealName,
      'numCalories': numCalories,
      'consumptionDate': consumptionDate,
      'weight': weight
    });
  }


  addFeedback(issue) {
    return FirebaseFirestore.instance.collection('feedback').add({
      'email': authService.getCurrentUser()!.email,
      'issue': issue
    });
  }

  addUser(name, email) {
    FirebaseFirestore.instance.collection("users").add(
        {'name': name, 'email': email});
  }
//where condition helps us to fetch the details of the current logged in user!
  Stream<List<Users>> getUser() {
    return FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: authService.getCurrentUser()!.email)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs
            .map<Users>((doc) => Users.fromMap(doc.data(), doc.id))
            .toList());
  }
//use where condition to fetch the users favorites based on the currently logged in user
  Stream<List<Recipe>> getFavorites() {
    return FirebaseFirestore.instance
        .collection('favorites')
    .where('email', isEqualTo: authService.getCurrentUser()!.email)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs
            .map<Recipe>((doc) => Recipe.fromMap(doc.data(), doc.id))
            .toList());
  }

  addFavorites(title, ingredients, recipe, imageUrl, calories) {
    return FirebaseFirestore.instance.collection('favorites').add({
      'email': authService.getCurrentUser()!.email,
      'title': title,
      'ingredients': ingredients,
      'recipe': recipe,
      'imageUrl': imageUrl,
      'calories': calories
    });
  }

  removeFavorites(id) {
    return FirebaseFirestore.instance.collection('favorites').doc(id).delete();
  }

  Stream<List<Calories>> getTotalCalories(String consumptionDate) {
    print(consumptionDate);
    if (consumptionDate == '') {
      return Stream.empty();
    }

    print(consumptionDate);
    DateFormat format = DateFormat("dd/MM/yyyy");
    DateTime formattedCDate = format.parse(consumptionDate);
    print(formattedCDate);
    var tmrDate = formattedCDate.add(const Duration(days: 1));
    // if ((formattedCDate).isAfter(tmrDate) &&
    //     (formattedCDate).isBefore(tmrDate)) {
    //   print(formattedCDate);

    return FirebaseFirestore.instance
        .collection('calories')
        .where('email', isEqualTo: authService.getCurrentUser()!.email)
        .where('consumptionDate', isGreaterThan: formattedCDate)
        .where('consumptionDate', isLessThan: tmrDate)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs
            .map<Calories>((doc) => Calories.fromMap(doc.data(), doc.id))
            .toList());
  }

  deleteUser() {
    FirebaseFirestore.instance.collection('users')
        .where('email', isEqualTo: authService.getCurrentUser()!.email)
        .get()
        .then((value) =>
        value.docs.forEach((doc) {
          FirebaseFirestore.instance.collection('users')
              .doc(doc.id)
              .delete()
              .then((_) {
            print("Deleted all records of user");
          });
        }));
  }

  deleteUserRecordsCalories() {
    FirebaseFirestore.instance.collection('calories')
        .where('email', isEqualTo: authService.getCurrentUser()!.email)
        .get()
        .then((value) =>
        value.docs.forEach((doc) {
          FirebaseFirestore.instance.collection('calories')
              .doc(doc.id)
              .delete()
              .then((_) {
            print("Deleted all records of calories");
          });
        }));
  }
  deleteUserRecordsFavorites() {
    FirebaseFirestore.instance.collection('favorites')
        .where('email', isEqualTo: authService.getCurrentUser()!.email)
        .get()
        .then((value) =>
        value.docs.forEach((doc) {
          FirebaseFirestore.instance.collection('favorites')
              .doc(doc.id)
              .delete()
              .then((_) {
            print("Deleted all records of favorites");
          });
        }));
  }


  Stream<List<UserGuide>> getUserGuide() {
    return FirebaseFirestore.instance
        .collection('userGuide')
    // .where('email', isEqualTo: authService.getCurrentUser()!.email)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs
            .map<UserGuide>((doc) => UserGuide.fromMap(doc.data(), doc.id))
            .toList());
  }



}

import 'package:flutter/material.dart';
import 'package:my_plate/models/recipes.dart';

class RecipeDetailsScreen extends StatelessWidget {
  static String routeName = '/recipe-details';
  // final Recipe recipe;
  //
  // RecipeDetailsScreen(this.recipe);
// Import information from recipe model to display on recipe details screen
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    Recipe selectedRecipe = arguments!['selected'] as Recipe;
    int index = arguments!['index'] as int;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff588157),
        title: Text(selectedRecipe.title),
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                selectedRecipe.imageUrl,
                width: 500,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  selectedRecipe.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold,)
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  selectedRecipe.calories.toString() + ' KCAL',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17.0, fontStyle: FontStyle.italic),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    'Ingredients',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,)
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  selectedRecipe.ingredients.toString(),
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 18.0, fontStyle: FontStyle.normal,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    'Recipe',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,)
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  selectedRecipe.recipe,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

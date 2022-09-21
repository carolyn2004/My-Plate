import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_plate/models/recipes.dart';
import 'package:my_plate/providers/all_recipes.dart';
import 'package:my_plate/screens/healthy_food_screen.dart';
import 'package:my_plate/screens/recipe_details_screen.dart';
import 'package:provider/provider.dart';

import '../services/firestore_service.dart';

class BookmarksPage extends StatefulWidget {
  @override
  _BookmarksPageState createState() => _BookmarksPageState();

}

class _BookmarksPageState extends State<BookmarksPage> {
  @override
  //when fav is more than 1, the recipe will be displayed
  //else list empty
  //slidable widget is enabled to delete fav
  void removeItem(String id) {
    FirestoreService fsService = FirestoreService();
    showDialog<Null>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Confirmation'),
            content: Text('Are you sure you want to delete?'),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      fsService.removeFavorites(id);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('This meal has been deleted!'),
                      ));
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text('Yes',style: TextStyle(color: Color(0xff588157)))

              ),

              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('No',style: TextStyle(color: Color(0xff588157)))),
            ],
          );
        });
  }
  Widget build(BuildContext context) {

    final controller = TextEditingController();
    // List<Recipe>? tempRecipeList;
    // AllRecipes recipesList = Provider.of<AllRecipes>(context);

    // if (tempRecipeList == null) tempRecipeList = recipesList.getMyRecipe();
    // print(tempRecipeList!.length);
    FirestoreService fsService = FirestoreService();
    return Scaffold(

        backgroundColor: Colors.white,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Favorites'),

            backgroundColor: Color(0xff588157),

            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(HealthyFoodScreen.routeName);
              },

            ),




        ),

        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [




              Expanded(
                child: StreamBuilder<List<Recipe>>(
                  stream: fsService.getFavorites(),
                  builder: (context, snapshot) {
                    return ListView.builder(

                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          // Recipe recipe = tempRecipeList![index];
                          return Card(
                            child:
                            Slidable(
                              key: ValueKey(index),
                              //slidable widget
                              endActionPane: ActionPane(
                                motion: ScrollMotion(),
                                children: [SlidableAction
                                  (icon: Icons.delete, foregroundColor: Color(0xff729671),
                                    backgroundColor: Color(0xffCAD2C5),
                                    onPressed: (ctx) {removeItem(snapshot.data![index].id);})],
                              ),
                              child: ListTile(
                                  title: Text(snapshot.data![index].title, style: TextStyle(
                                      fontSize: 15, fontWeight: FontWeight.bold)),
                                  subtitle: Text(snapshot.data![index].calories.toString() + 'KCAL',
                                    style: TextStyle(fontStyle: FontStyle.italic), ),
                                  leading: Image.network(snapshot.data![index].imageUrl),


                                  onTap: () {

                                    Navigator.of(context).pushNamed(
                                        RecipeDetailsScreen.routeName,
                                        arguments: {'index': index,
                                          'selected': snapshot.data![index]
                                        });
                                  },



                              ),
                            ),
                            // :Center(),
                          );
                        });
                  }
                ),
              ),
            ],
          ),
        ));
  }
}
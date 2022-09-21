import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_plate/models/recipes.dart';
import 'package:my_plate/providers/all_recipes.dart';
import 'package:my_plate/screens/bookmark_screen.dart';
import 'package:my_plate/screens/in_app_browser_page.dart';
import 'package:my_plate/screens/recipe_details_screen.dart';
import 'package:my_plate/widgets/app_drawer.dart';
import 'package:path/path.dart';
import 'package:share_plus/share_plus.dart';

import '../services/firestore_service.dart';

class HealthyFoodScreen extends StatefulWidget {
  static String routeName = '/food';

  @override
  State<HealthyFoodScreen> createState() => _HealthyFoodScreenState();
}

class _HealthyFoodScreenState extends State<HealthyFoodScreen> {
  // List<Recipe>? tempRecipeList;
  FirestoreService fsService = FirestoreService();
  String? title;

  String? ingredients;
  String? recipe;
  String?imageUrl;
  int?calories;
  String search = '';

  // addCount(recipe, AllRecipes myRecipe) {
  //   // tempRecipeList!.fav++
  //   setState(() {
  //     myRecipe.addRecipe(recipe);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final collection = FirebaseFirestore.instance
        .collection('recipes')
    // .where('email', isEqualTo: authService.getCurrentUser()!.email)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs
            .map<Recipe>((doc) => Recipe.fromMap(doc.data(), doc.id))
            .toList());

    final TextEditingController _searchController = TextEditingController();
    String searchText = '';

    FirestoreService fsService = FirestoreService();

    return Scaffold(
        drawer: AppDrawer(),
        backgroundColor: Colors.white,
        appBar: AppBar(
          // automaticallyImplyLeading: false,
            title: Text('Healthy Food Recipes'),
            backgroundColor: Color(0xff588157),
            actions: [
              IconButton(
                icon: Icon(Icons.book),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookmarksPage(),
                      ));
                },
              ),
            ]),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [

              // Texfield Widget**
              // TextField(
              //     controller: _searchController,
              //     onChanged: (value) {
              //       setState(()=> searchText = value);
              //     }),
              TextField(
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff588157)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff588157)),
                    ),
                    hintText: 'Enter a search term',
                    suffixIcon: Icon(Icons.search)),
                onChanged: (value) {
                  setState(() {
                    search = value;
                  });
                  //print(search);
                  // searchRecipe(value, recipesList);
                },
              ),

              Expanded(

                child: StreamBuilder<List<Recipe>>(
                    stream: fsService.getRecipes(search),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Center(child: CircularProgressIndicator());
                      else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              // Recipe recipe = snapshot.data![index];
                              return Card(
                                child: ListTile(

                                    title: Text(snapshot.data![index].title,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                    subtitle: Text(
                                      snapshot.data![index].calories
                                          .toString() +
                                          ' KCAL',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                    leading: Image.network(
                                        snapshot.data![index].imageUrl),
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          RecipeDetailsScreen.routeName,
                                          arguments: {'index': index,
                                            'selected': snapshot.data![index]
                                          });
                                    },
                                    // This is useful as the snack bar shows exactly which recipe is being added to fav
                                    trailing: IconButton(
                                      icon: Icon(
                                        Icons.bookmark_add,
                                      ),
                                      onPressed: () {
                                        title = snapshot.data![index].title;
                                        ingredients =
                                            snapshot.data![index].ingredients;
                                        recipe = snapshot.data![index].recipe;
                                        calories =
                                            snapshot.data![index].calories;
                                        imageUrl =
                                            snapshot.data![index].imageUrl;
                                        fsService.addFavorites(
                                            title, ingredients, recipe,
                                            imageUrl, calories);
                                        // addCount(index, recipesList);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              snapshot.data![index].title +
                                                  ' has been saved!'),

                                        ));
                                      },
                                    )),
                              );
                            });
                      }
                    }),
              ),
              TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => InAppBrowserPage()));
                  },
                  child: Center(

                    child: Text('Click to view our recipes on youtube!', style: TextStyle(color: Color(0xff588157),),),
                  )
              ),
              TextButton(

                onPressed: () {
                  final urlPreview= 'https://www.youtube.com/c/BBCGoodFood';
                  Share.share('Hey check out this cool youtube channel! \n\n$urlPreview'); },
                child: Text('Recommend our youtube channel to your friends', style: TextStyle(color: Color(0xff588157),),),
              ),
            ],

          ),
        )
      // ,drawer: AppDrawer(),

    );
  }

}

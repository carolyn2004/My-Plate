
class Recipe {
  String id;
  String title;
  String ingredients;
  String recipe;
  String email;
  String imageUrl;
  int calories;
  int fav;
  Recipe(
      {required this.title,
        required this. ingredients,
        required this.recipe,
        required this.imageUrl,
        required this.calories,
        required this.fav,
        required this.id,
        required this.email
        });
  Recipe.fromMap(Map <String, dynamic> snapshot,String id) :
        id = id,
        email = snapshot['email'] ?? '',
        title = snapshot['title'] ?? '',
        ingredients = snapshot['ingredients'] ?? '',
        recipe = snapshot['recipe'] ?? '',
        imageUrl = snapshot['imageUrl'] ?? '',
        calories=snapshot['calories'] ?? 0,
        fav=snapshot['fav']?? 0;


}






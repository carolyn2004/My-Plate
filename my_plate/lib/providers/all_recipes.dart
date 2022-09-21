// import 'package:flutter/material.dart';
// import 'package:my_plate/models/recipes.dart';
//
// class AllRecipes with ChangeNotifier {
//   List<Recipe> myRecipe = [
//     Recipe(
//         title: 'Meatballs with noodles',
//         ingredients:
//             '400g lean beef steak mince, 2 tsp dried oregano, 1 large egg, 8 garlic cloves, 1 finely grated, the other sliced, 1-2 tbsp olive oil, 1 fennel bulb, finely chopped, fronds reserved, 2 carrots, finely chopped, 500g carton passata, 4 tbsp balsamic vinegar, 600ml reduced-salt vegetable bouillon, For the courgette noodles, 1 tsp rapeseed oil, 1-2 large courgettes , cut into noodles with a julienne peeler or spiralizer, 50g frozen soya beans , thawed.',
//         recipe:
//             'Put the mince, oregano, egg and grated garlic in a bowl and grind in some black pepper. Mix together thoroughly and roll into 16 balls. Heat the oil in a large sauté pan over a medium-high heat, add the meatballs and fry, moving them around the pan so that they brown all over – be careful as they’re quite delicate and you don’t want them to break up. Once brown, remove them from the pan. Reduce the heat slightly and add the fennel, carrots and sliced garlic to the pan and fry, stirring until they soften, about 5 mins. Tip in the passata, balsamic vinegar and bouillon, stir well, then return the meatballs to the pan, cover and cook gently for 20-25 mins. Meanwhile, heat the 1 tsp of oil in a non-stick pan and stir-fry the courgette with the beans to heat through and soften. Serve with the meatballs and scatter with any fennel fronds.',
//         calories: 380,
//         imageUrl:
//             'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/meatballs-with-fennel-balsamic-beans-courgette-noodles-6bc9a37.jpg?quality=90&webp=true&resize=300,272?raw=true',
//         fav: 0,
//         id: '', email: ''),
//     Recipe(
//         title: 'Greek salad salsa',
//         ingredients:
//             '400g can butter beans , drained, 1 lemon , ½ juiced, ½ cut into 4 wedges, 2 tbsp ricotta or bio yogurt, 85g feta , crumbled, 1 garlic clove, 12 oatcakes, For the salsa, 4 tomatoes , chopped, 1 medium cucumber , finely diced, 1 small red onion , finely chopped, 12 pitted Kalamata olives , chopped, a few chopped mint leaves (optional).',
//         recipe:
//             'Tip the beans, lemon juice, ricotta, 50g feta and the garlic into a bowl and blitz with a hand blender or in a food processor to make a paste. Stir in the remaining feta and spoon the mixture into four small pots. To make the salsa, stir all the ingredients together with the mint (if using) and divide into four more pots, topping with a lemon wedge. These will keep, chilled in an airtight container, for two-three days. To eat, spread the oatcakes with the bean mixture, squeeze the lemon wedges over the salads and pile generously onto the oatcakes.',
//         calories: 382,
//         imageUrl:
//             'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/bean-feta-spread-with-greesk-salad-salsa-oatcakes-d329436.jpg?quality=90&webp=true&resize=300,272?raw=true',
//         fav: 0,
//         id: '', email: ''),
//     Recipe(
//         title: 'Mexican bean soup',
//         ingredients:
//             '2 tsp rapeseed oil, 1 large onion, finely chopped,  1 red pepper, cut into chunks, 2 garlic cloves, chopped, 2 tsp mild chilli powder, 1 tsp ground coriander, 1 tsp ground cumin, 400g can chopped tomatoes, 400g can black beans, 1 tsp vegetable bouillon powder, 1 small avocado, handful chopped coriander, 1 lime, juiced, ½ red chilli, deseeded and finely chopped (optional).',
//         recipe:
//             'Heat the oil in a medium pan, add the onion (reserving 1 tbsp to make the guacamole later) and pepper and fry, stirring frequently, for 10 mins. Stir in the garlic and spices, then tip in the tomatoes and beans with their liquid, half a can of water and the bouillon powder. Simmer, covered, for 15 mins. Meanwhile, peel and de-stone the avocado and tip into a bowl, add the remaining onion, coriander and lime juice with a little chilli (if using) and mash well. Ladle the soup into two bowls, top with the guacamole and serve.',
//         calories: 391,
//         imageUrl:
//             'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/wdp-lunch-mexicanguacamolesoup_02051-d1c462c.jpg?quality=90&webp=true&resize=300,272?raw=true',
//         fav: 0,
//         id: '', email: ''),
//     Recipe(
//       title: 'Poached eggs',
//       ingredients:
//           '2 tomatoes, halved, ½ tsp rapeseed oil, 2 eggs, 1 small ripe avocado, 2 slices seeded wholemeal soda bread (see goes well with), 2 handfuls rocket.',
//       recipe:
//           'Heat a non-stick frying pan, very lightly brush the cut surface of the tomatoes with a little oil, then cook them, cut-side down, in the pan until they have softened and slightly caramelised. Meanwhile, heat a pan of water, carefully break in the eggs and leave to poach for 1-2 mins until the whites are firm but the yolks are still runny. Halve and stone the avocado, then scoop out the flesh and smash onto the bread. Add the eggs, grind over black pepper and add a handful of rocket to each portion. Serve the tomatoes on the side.',
//       fav: 0,
//       calories: 385,
//       imageUrl:
//           'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/avocado-6b1cf76.jpg?quality=90&webp=true&resize=300,272',
//       id: '', email: '',
//     ),
//     Recipe(
//         title: 'Egg Niçoise salad',
//         ingredients:
//             'For the dressing, 2 tbsp rapeseed oil, juice 1 lemon, 1 tsp balsamic vinegar, 1 garlic clove , grated, ⅓ small pack basil , leaves chopped, 3 pitted black Kalamata olive , rinsed and chopped, For the salad, 2 eggs, 250g new potatoes , thickly sliced, 200g fine green beans, ½ red onion , very finely chopped, 14 cherry tomatoes , halved, 6 romaine lettuces leaves, torn into bite-sized pieces, 6 pitted black Kalamata olive , rinsed and halved.',
//         recipe:
//             'Mix the dressing ingredients together in a small bowl with 1 tbsp water. Meanwhile boil the potatoes for 7 mins, add the beans and boil 5 mins more or until both are just tender, then drain. Boil 2 eggs for 8 minutes then shell and halve.Toss the beans, potatoes and remaining salad ingredients, except the eggs, together in a large bowl with half the dressing. Arrange the eggs on top and drizzle over the remaining dressing. ',
//         calories: 333,
//         imageUrl:
//             'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/nicoise-egg-salad-8b5171c.jpg?quality=90&webp=true&resize=300,272?raw=true',
//         fav: 0,
//         id: '', email: ''),
//     Recipe(
//         title: 'Chicken casserole',
//         ingredients:
//             '1 leek, roughly chopped, 1 carrot, roughly chopped, 1 onion, roughly chopped, 350g new potatoes, roughly chopped, 6 skinless, boneless chicken thighs, chopped, 500ml chicken stock, 4 tbsp vegetable gravy granules.',
//         recipe:
//             'Put the veg and chicken in a slow cooker. Pour the stock over and around the chicken thighs, then mix in the gravy granules to thicken it up (the sauce will be quite thick – use less gravy if you prefer a runnier casserole). Switch the slow cooker to low and leave to cook for at least 4 hrs, or up to 8 hrs – try putting it on before you go to work, so that it’s ready when you get home. Season well, then serve.',
//         calories: 268,
//         imageUrl:
//             'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/slow-cooker-chicken-casserole-1172edc.jpg?quality=90&webp=true&resize=300,272?raw=true',
//         fav: 0,
//         id: '', email: ''),
//     Recipe(
//         title: 'Wild salmon veggie bowl',
//         ingredients:
//             '2 carrots, 1large courgette, 2 cooked beetroot , diced, 2 tbsp balsamic vinegar, ⅓ small pack dill , chopped, plus some extra fronts (optional), 1small red onion , finely chopped, 280g poached or canned wild salmon, 2 tbsp capers in vinegar, rinsed.',
//         recipe:
//             'Shred the carrots and courgette into long spaghetti strips with a julienne peeler or spiralizer, and pile onto two plates. Stir the beetroot, balsamic vinegar, chopped dill and red onion together in a small bowl, then spoon on top of the veg. Flake over chunks of the salmon and scatter with the capers and extra dill, if you like.',
//         calories: 395,
//         fav: 0,
//         imageUrl:
//             'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/wild-salmon-veggie-bowl-c5cc341.jpg?quality=90&webp=true&resize=300,272?raw=true',
//         id: '', email: ''),
//     Recipe(
//       title: 'Banana overnight oats',
//       ingredients:
//           '2 bananas, peeled, 100g porridge oats, ¼ tsp ground cinnamon, plus a pinch to serve, 1 tbsp maple syrup, 300ml milk of your choice, plus a splash, 2 tbsp peanut or almond butter, plus extra to serve, 2 tbsp flaked or chopped almonds, 2-4 tbsp natural yogurt, to serve (optional).',
//       recipe:
//           'Mash 1 banana in a bowl with a fork until smooth. Stir in the oats, cinnamon, maple syrup, milk and peanut butter. Mix well, then cover and chill overnight. The next morning, stir the porridge, adding another splash of milk if the mixture is quite stiff. Divide between two bowls. Slice the remaining banana and scatter this over the porridge, drizzle with more nut butter and sprinkle over the almonds. Top with spoonfuls of yogurt, if using, and sprinkle with a pinch more cinnamon before serving.',
//       calories: 557,
//       imageUrl:
//           'https://images.immediate.co.uk/production/volatile/sites/30/2022/01/Banana-Overnight-Oats-16f2208.jpg?quality=90&webp=true&resize=300,272?raw=true',
//       fav: 0,
//       id: '', email: '',
//     ),
//     Recipe(
//         title: 'Miso & butternut soup',
//         ingredients:
//             '2 tsp rapeseed oil, 1 large onion, chopped, 400g butternut squash, skin-on, cut into chunks, 2 garlic cloves, chopped, 210g can butter beans, drained, 2 tsp vegetable bouillon, 80g shredded kale, finely chopped, 2 tsp sesame oil, 2 tsp toasted sesame seeds, 2 tsp finely grated ginger, 1 tbsp brown rice miso.',
//         recipe:
//             'Heat the oil in a large pan and fry the onion for 5 mins to soften. Add the squash and garlic, and stir for a minute. Add the beans and bouillon along with a litre of water, then cover and simmer for 20 mins until the squash is tender. Meanwhile, steam the kale for 10 mins, then toss together with the sesame oil, seeds and ginger. Add the miso to the soup, then blitz until smooth using a hand blender. Pour into bowls and top with the sesame kale mix to serve.',
//         calories: 287,
//         fav: 0,
//         imageUrl:
//             'https://images.immediate.co.uk/production/volatile/sites/30/2021/09/Miso-and-butternut-soup-efe9277.jpg?quality=90&webp=true&resize=300,272?raw=true',
//         id: '', email: ''),
//     Recipe(
//         title: 'Pesto egg muffin bites',
//         ingredients:
//             'low-cal cooking spray, for the tin, 18 cherry tomatoes, quartered, 80g feta or goat’s cheese, crumbled, 6 medium eggs, 30ml milk, 2 tbsp pesto (check the label if you’re vegetarian).',
//         recipe:
//             'Heat the oven to 180C/160C fan/gas 4. Spray a 12-hole muffin tin with the oil spray. Evenly divide the tomatoes among the holes, and top each one with around 2 tsp of the feta or goat’s cheese. Crack the eggs into a large bowl, then add the milk, pesto and seasoning and whisk to combine. Pour the mixture evenly into each hole. Bake for 20 mins or until the egg is set. Cool for 2-3 mins in the tin, then remove and leave to cool on a wire rack.',
//         calories: 74,
//         fav: 0,
//         imageUrl:
//             'https://images.immediate.co.uk/production/volatile/sites/30/2021/08/Pesto-egg-muffins-5d37964.jpg?quality=90&webp=true&resize=300,272?raw=true',
//         id: '', email: '')
//   ];
//
//   void removeRecipe(i) {
//     myRecipe.removeAt(i);
//     notifyListeners();
//     //remove from favorites list
//   }
//
//   List<Recipe> getMyRecipe() {
//     return myRecipe;
//   }
//   // void addRecipe(i) {
//   //   myRecipe.removeAt(i);
//   //   notifyListeners();
//   // }
//
//   void addRecipe(i) {
//     //add recipe to favorites
//
//     if (myRecipe[i].fav > 0) {
//       myRecipe[i].fav = 0;
//     } else
//       (myRecipe[i].fav++);
//   }
//
//   notifyListeners();
// }

import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addDummyData() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Dummy data for 'users' collection
  await firestore.collection('users').add({
    'email': 'john.doe@example.com',
    'fullname': 'John Doe',
    'likedrecepies': ['recipe123'],
    'phonenumber': '1234567890',
    'userid': 'user123'
  });

  await firestore.collection('users').add({
    'email': 'jane.doe@example.com',
    'fullname': 'Jane Doe',
    'likedrecepies': [],
    'phonenumber': '0987654321',
    'userid': 'user456'
  });

  // Expanded dummy data for 'recipes' collection with 20 detailed recipes
  List<Map<String, dynamic>> recipes = [
    {
      'category': 'Rice Dishes',
      'description': 'A classic Indonesian fried rice dish, packed with flavors from soy sauce, garlic, and fresh vegetables. Perfect for a quick, satisfying meal.',
      'howtocook': '1. Heat oil in a wok over medium heat.\n2. Saute garlic and onion until fragrant.\n3. Add cooked rice and stir well.\n4. Pour in soy sauce, salt, and pepper, stirring constantly.\n5. Toss in vegetables and cook for another 2 minutes.\n6. Serve hot with a fried egg on top.',
      'image': 'https://example.com/nasigoreng.jpg',
      'ingredients': ['2 cups cooked rice', '2 tbsp soy sauce', '1 garlic clove, minced', '1 onion, chopped', '1 carrot, diced', '1 egg, fried'],
      'name': 'Nasi Goreng',
      'price': '30000',
      'recipeid': 'recipe001',
      'userid': 'user123'
    },
    {
      'category': 'Sweets',
      'description': 'A rich and moist chocolate cake topped with velvety chocolate ganache. Perfect for special occasions or just an indulgent treat.',
      'howtocook': '1. Preheat oven to 180°C.\n2. Mix flour, cocoa powder, and baking powder in a bowl.\n3. Beat butter and sugar until fluffy, then add eggs one by one.\n4. Gradually mix in the dry ingredients and milk.\n5. Pour batter into a greased pan and bake for 30 minutes.\n6. Let cool and top with chocolate ganache.',
      'image': 'https://example.com/chocolatecake.jpg',
      'ingredients': ['200g flour', '50g cocoa powder', '1 tsp baking powder', '150g butter', '200g sugar', '3 eggs', '100ml milk'],
      'name': 'Chocolate Cake',
      'price': '50000',
      'recipeid': 'recipe002',
      'userid': 'user456'
    },
    {
      'category': 'Drinks',
      'description': 'A refreshing iced lemon tea with a perfect balance of sweet and tangy flavors. Great for cooling down on a hot day.',
      'howtocook': '1. Brew the tea and let it cool.\n2. Squeeze fresh lemon juice into the tea.\n3. Add sugar or honey to taste.\n4. Fill a glass with ice cubes and pour the tea over.\n5. Garnish with a lemon slice and mint leaves.',
      'image': 'https://example.com/lemontea.jpg',
      'ingredients': ['2 tea bags', '1 lemon', '2 tbsp sugar', 'Ice cubes', 'Mint leaves'],
      'name': 'Iced Lemon Tea',
      'price': '15000',
      'recipeid': 'recipe003',
      'userid': 'user456'
    }
  ];

  for (int i = 4; i <= 20; i++) {
    recipes.add({
      'category': 'Snacks',
      'description': 'Delicious crispy fried tofu served with spicy dipping sauce. Perfect for an afternoon snack.',
      'howtocook': '1. Cut tofu into bite-sized pieces.\n2. Season with salt and pepper.\n3. Coat with flour and fry until golden brown.\n4. Serve with a spicy dipping sauce.',
      'image': 'https://example.com/friedtofu.jpg',
      'ingredients': ['1 block tofu', 'Salt', 'Pepper', 'Flour', 'Oil for frying', 'Chili sauce'],
      'name': 'Crispy Fried Tofu',
      'price': '20000',
      'recipeid': 'recipe00$i',
      'userid': i % 2 == 0 ? 'user123' : 'user456'
    });
  }

  for (var recipe in recipes) {
    await firestore.collection('recipes').add(recipe);
  }

  print('Detailed dummy data added successfully!');
}

// Call this function wherever needed, like in your main() or a button press
// addDummyData();

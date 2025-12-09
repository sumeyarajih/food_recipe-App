import 'package:flutter/material.dart';
import 'package:food_recipe/screens/widget/recipe_card.dart';
import 'package:food_recipe/model/recipe_model.dart';

// Recipe class moved to models/recipe_model.dart

final List<Map<String, dynamic>> recipeJsonList = [
  {
    "title": "Strawberry Pancakes",
    "description": "Fluffy pancakes topped with fresh strawberries",
    "time": "25 min",
    "rating": 5,
    "reviewCount": 128,
    "chefName": "Chef Maria",
    "isBookmarked": false,
    "imageUrl": "assets/images/recipe_card.jpeg",
    "category": "breakfast",
  },
  {
    "title": "Avocado Toast",
    "description": "Healthy breakfast toast with avocado",
    "time": "10 min",
    "rating": 4,
    "reviewCount": 89,
    "chefName": "Chef John",
    "isBookmarked": true,
    "imageUrl": "assets/images/recipe_card.jpeg",
    "category": "breakfast",
  },
  {
    "title": "Chicken Salad",
    "description": "Fresh salad with grilled chicken",
    "time": "20 min",
    "rating": 4,
    "reviewCount": 76,
    "chefName": "Chef Anna",
    "isBookmarked": false,
    "imageUrl": "assets/images/recipe_card.jpeg",
    "category": "lunch",
  },
  {
    "title": "Beef Steak",
    "description": "Juicy steak with vegetables",
    "time": "30 min",
    "rating": 5,
    "reviewCount": 215,
    "chefName": "Chef Luca",
    "isBookmarked": false,
    "imageUrl": "assets/images/recipe_card.jpeg",
    "category": "dinner",
  },
  {
    "title": "Chocolate Cake",
    "description": "Rich chocolate dessert",
    "time": "60 min",
    "rating": 5,
    "reviewCount": 180,
    "chefName": "Chef Sophia",
    "isBookmarked": false,
    "imageUrl": "assets/images/recipe_card.jpeg",
    "category": "desserts",
  },
];

class RecipeList extends StatelessWidget {
  final List<Recipe> recipes;

  const RecipeList({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return RecipeCard(
          title: recipe.title,
          description: recipe.description,
          time: recipe.time,
          rating: recipe.rating,
          reviewCount: recipe.reviewCount,
          chefName: recipe.chefName,
          isBookmarked: recipe.isBookmarked,
          imageUrl: recipe.imageUrl,
        );
      },
    );
  }
}
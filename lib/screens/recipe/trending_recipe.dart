import 'package:flutter/material.dart';
import 'package:food_recipe/screens/widget/recipe_card.dart';

enum RecipeCategory { all, breakfast, lunch, dinner, desserts }

class Recipe {
  final String title;
  final String description;
  final String time;
  final int rating;
  final int reviewCount;
  final String chefName;
  final bool isBookmarked;
  final String imageUrl;
  final RecipeCategory category;

  Recipe({
    required this.title,
    required this.description,
    required this.time,
    required this.rating,
    required this.reviewCount,
    required this.chefName,
    this.isBookmarked = false,
    required this.imageUrl,
    required this.category,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['title'],
      description: json['description'],
      time: json['time'],
      rating: json['rating'],
      reviewCount: json['reviewCount'],
      chefName: json['chefName'],
      isBookmarked: json['isBookmarked'] ?? false,
      imageUrl: json['imageUrl'],
      category: RecipeCategory.values.firstWhere(
        (e) => e.toString().split('.').last == json['category'],
        orElse: () => RecipeCategory.all,
      ),
    );
  }
}

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
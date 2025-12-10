import 'package:flutter/material.dart';
import 'package:food_recipe/model/recipe_model.dart';
import 'package:food_recipe/screens/widget/background_decoration.dart';

class RecipeSearchDelegate extends SearchDelegate<Recipe?> {
  final List<Recipe> recipes;

  RecipeSearchDelegate(this.recipes);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = recipes.where((recipe) =>
        recipe.title.toLowerCase().contains(query.toLowerCase())).toList();
    
    return _buildSearchResults(results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Recipe> suggestions;
    
    if (query.isEmpty) {
      suggestions = [];
    } else {
      suggestions = recipes.where((recipe) {
        return recipe.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    
    return _buildSearchResults(suggestions);
  }

  Widget _buildSearchResults(List<Recipe> results) {
    return Container(
      decoration: const BoxDecoration(
        // Apply the BackgroundDecoration here
        // If BackgroundDecoration is a BoxDecoration, use it directly
        // If it's a widget, you might need to wrap differently
      ),
      child: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final recipe = results[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            elevation: 1,
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  recipe.imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => 
                    Container(
                      width: 50,
                      height: 50,
                      color: Colors.grey[200],
                      child: const Icon(Icons.fastfood, color: Colors.grey),
                    ),
                ),
              ),
              title: Text(recipe.title),
              subtitle: Text(recipe.chefName),
              onTap: () {
                close(context, recipe);
              },
            ),
          );
        },
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // Apply the BackgroundDecoration to the entire Scaffold
      body: BackgroundDecoration(
      ),
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.grey[600]),
        border: InputBorder.none,
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:food_recipe/screens/recipe/trending_recipe.dart';

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
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final recipe = results[index];
        return ListTile(
          leading: Image.network(
            recipe.imageUrl,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.fastfood),
          ),
          title: Text(recipe.title),
          subtitle: Text(recipe.chefName),
          onTap: () {
            close(context, recipe);
          },
        );
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.grey[600]),
        border: InputBorder.none,
      ),
    );
  }
}
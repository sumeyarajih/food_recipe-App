import 'package:flutter/material.dart';
import 'package:food_recipe/screens/home/chef.dart';
import 'package:food_recipe/screens/recipe/recipe_search_delegate.dart';
import 'package:food_recipe/screens/recipe/trending_recipe.dart';
import 'package:food_recipe/screens/widget/button_nav_bar.dart';
import 'package:food_recipe/screens/widget/recipe_card.dart';
import 'package:food_recipe/screens/widget/top_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  final List<Recipe> recipes = recipeJsonList.map((json) => Recipe.fromJson(json)).toList();
  RecipeCategory _selectedCategory = RecipeCategory.all;

  List<Recipe> get filteredRecipes {
    if (_selectedCategory == RecipeCategory.all) {
      return recipes;
    }
    return recipes.where((recipe) => recipe.category == _selectedCategory).toList();
  }

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onCategorySelected(RecipeCategory category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void _onSearchTap() {
    showSearch(
      context: context,
      delegate: RecipeSearchDelegate(recipes),
    ).then((selectedRecipe) {
      if (selectedRecipe != null) {
        // Handle recipe selection
        // Navigator.push(context, MaterialPageRoute(
        //   builder: (context) => RecipeDetailsPage(recipe: selectedRecipe),
        // ));
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 230, 235),
      appBar: const TopNavBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 16.0 : 24.0,
                vertical: 16.0,
              ),
              child: GestureDetector(
                onTap: _onSearchTap,
                child: AbsorbPointer(
                  child: SearchBar(
                    controller: _searchController,
                    hintText: 'Search recipes...',
                    leading: const Icon(Icons.search, color: Colors.grey),
                    backgroundColor: WidgetStateProperty.all(Colors.white),
                    elevation: WidgetStateProperty.all(0),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Featured Chefs Section
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 16.0 : 24.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Featured Chefs',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                 TextButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ChefPage()),
    );
  },
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        color: Color(0xFFEC407A),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 16.0 : 24.0,
                ),
                children: const [
                  ChefCard(name: 'Emma W.', image: 'assets/chef1.jpg'),
                  ChefCard(name: 'James C.', image: 'assets/chef2.jpg'),
                  ChefCard(name: 'Sophia C.', image: 'assets/chef3.jpg'),
                  ChefCard(name: 'Michael B.', image: 'assets/chef4.jpg'),
                  ChefCard(name: 'Olivia T.', image: 'assets/chef5.jpg'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Categories Section
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 16.0 : 24.0,
              ),
              child: const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 16.0 : 24.0,
                ),
                children: [
                  _buildCategoryChip('All', RecipeCategory.all),
                  _buildCategoryChip('Breakfast', RecipeCategory.breakfast),
                  _buildCategoryChip('Lunch', RecipeCategory.lunch),
                  _buildCategoryChip('Dinner', RecipeCategory.dinner),
                  _buildCategoryChip('Desserts', RecipeCategory.desserts),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Popular Recipes Section
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 16.0 : 24.0,
              ),
              child: const Text(
                'Trending Recipes',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 16.0 : 24.0,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredRecipes.length,
                itemBuilder: (context, index) {
                  final recipe = filteredRecipes[index];
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
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTabSelected: _onTabSelected,
      ),
    );
  }

  Widget _buildCategoryChip(String label, RecipeCategory category) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(label),
        selected: _selectedCategory == category,
        selectedColor: const Color(0xFFEC407A),
        labelStyle: TextStyle(
          color: _selectedCategory == category ? Colors.white : Colors.black,
        ),
        backgroundColor: Colors.white,
        onSelected: (selected) {
          _onCategorySelected(category);
        },
      ),
    );
  }
}

class ChefCard extends StatelessWidget {
  final String name;
  final String image;
  const ChefCard({super.key, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: image.isNotEmpty
                    ? Image.asset(
                        image,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.person,
                          size: 40,
                          color: Color(0xFFEC407A),
                        ),
                      )
                    : Icon(
                        Icons.person,
                        size: 40,
                        color: Color(0xFFEC407A),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}







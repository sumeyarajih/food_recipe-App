// import 'package:flutter/material.dart';
// import 'package:food_recipe/screens/home/chef.dart';
// import 'package:food_recipe/screens/recipe/recipe_search_delegate.dart';
// import 'package:food_recipe/screens/recipe/trending_recipe.dart';
// import 'package:food_recipe/screens/widget/button_nav_bar.dart';
// import 'package:food_recipe/screens/widget/recipe_card.dart';
// import 'package:food_recipe/screens/widget/top_nav_bar.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;
//   final TextEditingController _searchController = TextEditingController();
//   final List<Recipe> recipes = recipeJsonList.map((json) => Recipe.fromJson(json)).toList();
//   RecipeCategory _selectedCategory = RecipeCategory.all;

//   List<Recipe> get filteredRecipes {
//     if (_selectedCategory == RecipeCategory.all) {
//       return recipes;
//     }
//     return recipes.where((recipe) => recipe.category == _selectedCategory).toList();
//   }

//   void _onTabSelected(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   void _onCategorySelected(RecipeCategory category) {
//     setState(() {
//       _selectedCategory = category;
//     });
//   }

//   void _onSearchTap() {
//     showSearch(
//       context: context,
//       delegate: RecipeSearchDelegate(recipes),
//     ).then((selectedRecipe) {
//       if (selectedRecipe != null) {
//         // Handle recipe selection
//         // Navigator.push(context, MaterialPageRoute(
//         //   builder: (context) => RecipeDetailsPage(recipe: selectedRecipe),
//         // ));
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isSmallScreen = screenWidth < 400;

//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 247, 230, 235),
//       appBar: const TopNavBar(),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Search Bar
//             Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: isSmallScreen ? 16.0 : 24.0,
//                 vertical: 16.0,
//               ),
//               child: GestureDetector(
//                 onTap: _onSearchTap,
//                 child: AbsorbPointer(
//                   child: SearchBar(
//                     controller: _searchController,
//                     hintText: 'Search recipes...',
//                     leading: const Icon(Icons.search, color: Colors.grey),
//                     backgroundColor: WidgetStateProperty.all(Colors.white),
//                     elevation: WidgetStateProperty.all(0),
//                     shape: WidgetStateProperty.all(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),

//             // Featured Chefs Section
//             Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: isSmallScreen ? 16.0 : 24.0,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     'Featured Chefs',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                  TextButton(
//   onPressed: () {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const ChefPage()),
//     );
//   },
//                     child: const Text(
//                       'See All',
//                       style: TextStyle(
//                         color: Color(0xFFEC407A),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 8),
//             SizedBox(
//               height: 120,
//               child: ListView(
//                 scrollDirection: Axis.horizontal,
//                 padding: EdgeInsets.symmetric(
//                   horizontal: isSmallScreen ? 16.0 : 24.0,
//                 ),
//                 children: const [
//                   ChefCard(name: 'Emma W.', image: 'assets/chef1.jpg'),
//                   ChefCard(name: 'James C.', image: 'assets/chef2.jpg'),
//                   ChefCard(name: 'Sophia C.', image: 'assets/chef3.jpg'),
//                   ChefCard(name: 'Michael B.', image: 'assets/chef4.jpg'),
//                   ChefCard(name: 'Olivia T.', image: 'assets/chef5.jpg'),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 24),

//             // Categories Section
//             Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: isSmallScreen ? 16.0 : 24.0,
//               ),
//               child: const Text(
//                 'Categories',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 8),
//             SizedBox(
//               height: 50,
//               child: ListView(
//                 scrollDirection: Axis.horizontal,
//                 padding: EdgeInsets.symmetric(
//                   horizontal: isSmallScreen ? 16.0 : 24.0,
//                 ),
//                 children: [
//                   _buildCategoryChip('All', RecipeCategory.all),
//                   _buildCategoryChip('Breakfast', RecipeCategory.breakfast),
//                   _buildCategoryChip('Lunch', RecipeCategory.lunch),
//                   _buildCategoryChip('Dinner', RecipeCategory.dinner),
//                   _buildCategoryChip('Desserts', RecipeCategory.desserts),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 24),

//             // Popular Recipes Section
//             Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: isSmallScreen ? 16.0 : 24.0,
//               ),
//               child: const Text(
//                 'Trending Recipes',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: isSmallScreen ? 16.0 : 24.0,
//               ),
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: filteredRecipes.length,
//                 itemBuilder: (context, index) {
//                   final recipe = filteredRecipes[index];
//                   return RecipeCard(
//                     title: recipe.title,
//                     description: recipe.description,
//                     time: recipe.time,
//                     rating: recipe.rating,
//                     reviewCount: recipe.reviewCount,
//                     chefName: recipe.chefName,
//                     isBookmarked: recipe.isBookmarked,
//                     imageUrl: recipe.imageUrl,
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: CustomBottomNav(
//         currentIndex: _currentIndex,
//         onTabSelected: _onTabSelected,
//       ),
//     );
//   }

//   Widget _buildCategoryChip(String label, RecipeCategory category) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 8.0),
//       child: ChoiceChip(
//         label: Text(label),
//         selected: _selectedCategory == category,
//         selectedColor: const Color(0xFFEC407A),
//         labelStyle: TextStyle(
//           color: _selectedCategory == category ? Colors.white : Colors.black,
//         ),
//         backgroundColor: Colors.white,
//         onSelected: (selected) {
//           _onCategorySelected(category);
//         },
//       ),
//     );
//   }
// }

// class ChefCard extends StatelessWidget {
//   final String name;
//   final String image;
//   const ChefCard({super.key, required this.name, required this.image});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 80,
//       margin: const EdgeInsets.only(right: 16),
//       child: Column(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               shape: BoxShape.circle,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.2),
//                   spreadRadius: 2,
//                   blurRadius: 5,
//                   offset: const Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: CircleAvatar(
//               radius: 40,
//               backgroundColor: Colors.white,
//               child: ClipOval(
//                 child: image.isNotEmpty
//                     ? Image.asset(
//                         image,
//                         width: 70,
//                         height: 70,
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) => Icon(
//                           Icons.person,
//                           size: 40,
//                           color: Color(0xFFEC407A),
//                         ),
//                       )
//                     : Icon(
//                         Icons.person,
//                         size: 40,
//                         color: Color(0xFFEC407A),
//                       ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.2),
//                   spreadRadius: 1,
//                   blurRadius: 3,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: Text(
//               name,
//               style: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//               ),
//               textAlign: TextAlign.center,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
////////////////////////////////////////////////


import 'package:flutter/material.dart';
import 'package:food_recipe/screens/home/chef.dart';
import 'package:food_recipe/screens/recipe/recipe_search_delegate.dart';
// import 'package:food_recipe/screens/recipe/trending_recipe.dart';
import 'package:food_recipe/screens/widget/button_nav_bar.dart';
import 'package:food_recipe/screens/widget/recipe_card.dart';
import 'package:food_recipe/screens/widget/top_nav_bar.dart';
import 'package:food_recipe/model/recipe_model.dart';

// Add these imports if they don't exist
// If Recipe class and enum are defined elsewhere, make sure to import them

// Recipe class moved to models/recipe_model.dart

// Add your recipeJsonList here or import it
final List<Map<String, dynamic>> recipeJsonList = [
  // Your recipe data here
  {
    'title': 'Spaghetti Carbonara',
    'description': 'Classic Italian pasta dish with eggs and cheese',
    'time': '30 min',
    'rating': 4.8,
    'reviewCount': 245,
    'chefName': 'Maria R.',
    'isBookmarked': true,
    'imageUrl': 'assets/spaghetti.jpg',
    'category': 'dinner',
  },
  {
    'title': 'Avocado Toast',
    'description': 'Healthy breakfast with avocado on toasted bread',
    'time': '10 min',
    'rating': 4.5,
    'reviewCount': 128,
    'chefName': 'Emma W.',
    'isBookmarked': false,
    'imageUrl': 'assets/avocado_toast.jpg',
    'category': 'breakfast',
  },
  {
    'title': 'Chocolate Cake',
    'description': 'Rich and moist chocolate dessert',
    'time': '60 min',
    'rating': 4.9,
    'reviewCount': 312,
    'chefName': 'Sophia C.',
    'isBookmarked': true,
    'imageUrl': 'assets/chocolate_cake.jpg',
    'category': 'desserts',
  },
  {
    'title': 'Caesar Salad',
    'description': 'Fresh salad with chicken and Caesar dressing',
    'time': '20 min',
    'rating': 4.3,
    'reviewCount': 89,
    'chefName': 'James C.',
    'isBookmarked': false,
    'imageUrl': 'assets/caesar_salad.jpg',
    'category': 'lunch',
  },
  {
    'title': 'Pancakes',
    'description': 'Fluffy breakfast pancakes with maple syrup',
    'time': '25 min',
    'rating': 4.6,
    'reviewCount': 167,
    'chefName': 'Michael B.',
    'isBookmarked': true,
    'imageUrl': 'assets/pancakes.jpg',
    'category': 'breakfast',
  },
  {
    'title': 'Grilled Salmon',
    'description': 'Healthy grilled salmon with lemon butter sauce',
    'time': '35 min',
    'rating': 4.7,
    'reviewCount': 201,
    'chefName': 'Olivia T.',
    'isBookmarked': false,
    'imageUrl': 'assets/salmon.jpg',
    'category': 'dinner',
  },
  {
    'title': 'Tiramisu',
    'description': 'Classic Italian coffee-flavored dessert',
    'time': '45 min',
    'rating': 4.9,
    'reviewCount': 278,
    'chefName': 'Maria R.',
    'isBookmarked': true,
    'imageUrl': 'assets/tiramisu.jpg',
    'category': 'desserts',
  },
  {
    'title': 'Club Sandwich',
    'description': 'Triple-decker sandwich with chicken and bacon',
    'time': '15 min',
    'rating': 4.4,
    'reviewCount': 95,
    'chefName': 'Emma W.',
    'isBookmarked': false,
    'imageUrl': 'assets/sandwich.jpg',
    'category': 'lunch',
  },
];

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
            // Welcome Section with Beautiful Text
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 24.0 : 32.0,
                vertical: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Welcome , ',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 24 : 28,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                            fontFamily: 'PlayfairDisplay',
                          ),
                        ),
                        TextSpan(
                          text: 'name',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 24 : 28,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFEC407A),
                            fontFamily: 'PlayfairDisplay',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Discover ',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 16 : 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                        TextSpan(
                          text: 'delicious ',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 16 : 18,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFEC407A),
                          ),
                        ),
                        TextSpan(
                          text: 'recipes to cook',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 16 : 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 16.0 : 24.0,
                vertical: 8.0,
              ),
              child: GestureDetector(
                onTap: _onSearchTap,
                child: AbsorbPointer(
                  child: SearchBar(
                    controller: _searchController,
                    hintText: 'Search recipes, ingredients, chefs...',
                    hintStyle: WidgetStateProperty.all(
                      TextStyle(
                        color: Colors.grey.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    leading: Icon(
                      Icons.search,
                      color: const Color(0xFFEC407A),
                    ),
                    backgroundColor: WidgetStateProperty.all(Colors.white),
                    elevation: WidgetStateProperty.all(2),
                    shadowColor: WidgetStateProperty.all(
                      const Color(0xFFEC407A).withOpacity(0.2),
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: const Color(0xFFEC407A).withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                    ),
                    padding: WidgetStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
              ),
            ),

            // Featured Chefs Section
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 16.0 : 24.0,
                vertical: 24,
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
                        fontWeight: FontWeight.w600,
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
            const SizedBox(height: 32),

            // Categories Section with Functional Tabs
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 16.0 : 24.0,
              ),
              child: const Text(
                'Browse Categories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 55,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 16.0 : 24.0,
                ),
                children: [
                  _buildCategoryChip('All', RecipeCategory.all, Icons.restaurant),
                  _buildCategoryChip('Breakfast', RecipeCategory.breakfast, Icons.breakfast_dining),
                  _buildCategoryChip('Lunch', RecipeCategory.lunch, Icons.lunch_dining),
                  _buildCategoryChip('Dinner', RecipeCategory.dinner, Icons.dinner_dining),
                  _buildCategoryChip('Desserts', RecipeCategory.desserts, Icons.cake),
                ],
              ),
            ),
            
            // Category Selection Indicator
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 16.0 : 24.0,
                vertical: 8,
              ),
              child: Text(
                _selectedCategory == RecipeCategory.all 
                  ? 'Showing all recipes' 
                  : 'Showing ${_selectedCategory.toString().split('.').last} recipes',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            
            const SizedBox(height: 16),

            // Trending Recipes Section
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 16.0 : 24.0,
                vertical: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedCategory == RecipeCategory.all 
                      ? 'Trending Recipes' 
                      : '${_selectedCategory.toString().split('.').last} Recipes',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  if (filteredRecipes.isNotEmpty)
                    Text(
                      '${filteredRecipes.length} recipes',
                      style: TextStyle(
                        fontSize: 14,
                        color: const Color(0xFFEC407A),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Recipes Grid
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 16.0 : 24.0,
              ),
              child: filteredRecipes.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50),
                      child: Column(
                        children: [
                          Icon(
                            Icons.restaurant_menu,
                            size: 80,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No ${_selectedCategory == RecipeCategory.all ? '' : _selectedCategory.toString().split('.').last + ' '}recipes found',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Try selecting a different category',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isSmallScreen ? 1 : 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: isSmallScreen ? 1.8 : 1.6,
                      ),
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
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTabSelected: _onTabSelected,
      ),
    );
  }

  Widget _buildCategoryChip(String label, RecipeCategory category, IconData icon) {
    final isSelected = _selectedCategory == category;
    
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: GestureDetector(
        onTap: () {
          _onCategorySelected(category);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFEC407A) : Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(isSelected ? 0.3 : 0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(
              color: isSelected 
                ? const Color(0xFFEC407A) 
                : Colors.grey.shade300,
              width: isSelected ? 0 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 18,
                color: isSelected ? Colors.white : const Color(0xFFEC407A),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
        ),
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






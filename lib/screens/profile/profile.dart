import 'package:flutter/material.dart';
import 'package:food_recipe/screens/profile/edit_profile.dart';
import 'package:food_recipe/screens/profile/message.dart';
import 'package:food_recipe/screens/widget/top_nav_bar.dart';
import 'package:food_recipe/screens/widget/button_nav_bar.dart';
import 'package:food_recipe/screens/widget/recipe_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedTab = 0; // 0 = My Recipes, 1 = Liked, 2 = Message
  int _currentBottomNavIndex = 4;

  // Sample recipe data for My Recipes
  final List<Map<String, dynamic>> _myRecipes = [
    {
      'title': 'Spicy Ramen Bowl',
      'description': 'Authentic Japanese ramen with rich broth',
      'time': '30 min',
      'rating': 4.8,
      'reviewCount': 245,
      'chefName': 'Alex Johnson',
      'isBookmarked': true,
      'imageUrl': 'assets/images/recipe-image.jpg',
    },
    {
      'title': 'Greek Salad',
      'description': 'Fresh Mediterranean salad with feta',
      'time': '15 min',
      'rating': 4.5,
      'reviewCount': 189,
      'chefName': 'Alex Johnson',
      'isBookmarked': false,
      'imageUrl': 'assets/images/recipe-image.jpg',
    },
    {
      'title': 'Chocolate Lava Cake',
      'description': 'Decadent dessert with molten center',
      'time': '25 min',
      'rating': 4.9,
      'reviewCount': 312,
      'chefName': 'Alex Johnson',
      'isBookmarked': true,
      'imageUrl': 'assets/images/recipe-image.jpg',
    },
  ];

  // Sample liked recipes data
  final List<Map<String, dynamic>> _likedRecipes = [
    {
      'title': 'Avocado Toast',
      'description': 'Healthy breakfast with fresh avocado',
      'time': '10 min',
      'rating': 4.6,
      'reviewCount': 156,
      'chefName': 'Chef Maria',
      'isBookmarked': true,
      'imageUrl': 'assets/images/recipe-image.jpg',
    },
    {
      'title': 'Sushi Platter',
      'description': 'Assorted fresh sushi rolls',
      'time': '45 min',
      'rating': 4.9,
      'reviewCount': 423,
      'chefName': 'Chef Tanaka',
      'isBookmarked': true,
      'imageUrl': 'assets/images/recipe-image.jpg',
    },
  ];

  // Sample chef data for messages
  final List<Map<String, String>> _chefs = [
    {
      'name': 'Emma Wilson',
      'username': '@emmawilson',
      'image': 'https://randomuser.me/api/portraits/women/1.jpg',
      'lastMessage': 'Thanks for the recipe!',
      'time': '2h ago',
    },
    {
      'name': 'James Carter',
      'username': '@jamescarter',
      'image': 'https://randomuser.me/api/portraits/men/2.jpg',
      'lastMessage': 'Let\'s collaborate!',
      'time': '5h ago',
    },
    {
      'name': 'Maria Rodriguez',
      'username': '@mariarodriguez',
      'image': 'https://randomuser.me/api/portraits/women/3.jpg',
      'lastMessage': 'Great cooking tips!',
      'time': '1d ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 230, 235),
      appBar: const TopNavBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/profile.jpg'),
                    backgroundColor: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Alex Johnson',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '@chefalex',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatItem('${_myRecipes.length}', 'Recipes'),
                      _buildStatItem('1.2k', 'Followers'),
                      _buildStatItem('384', 'Following'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEC407A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Tab Bar
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildProfileTab('My Recipes', 0),
                  _buildProfileTab('Liked', 1),
                  _buildProfileTab('Message', 2),
                ],
              ),
            ),

            // Tab Content
            if (_selectedTab == 0) _buildMyRecipes(),
            if (_selectedTab == 1) _buildLikedRecipes(),
            if (_selectedTab == 2) _buildChefsList(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentBottomNavIndex,
        onTabSelected: (index) {
          setState(() {
            _currentBottomNavIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileTab(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: _selectedTab == index 
                  ? const Color(0xFFEC407A) 
                  : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: _selectedTab == index ? Colors.black : Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildMyRecipes() {
    if (_myRecipes.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(40.0),
        child: Center(
          child: Column(
            children: [
              Icon(Icons.restaurant_menu, size: 60, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'No recipes yet',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Start creating your first recipe!',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: _myRecipes.map((recipe) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: RecipeCard(
              title: recipe['title'],
              description: recipe['description'],
              time: recipe['time'],
              rating: recipe['rating'],
              reviewCount: recipe['reviewCount'],
              chefName: recipe['chefName'],
              isBookmarked: recipe['isBookmarked'],
              imageUrl: recipe['imageUrl'],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLikedRecipes() {
    if (_likedRecipes.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(40.0),
        child: Center(
          child: Column(
            children: [
              Icon(Icons.favorite_border, size: 60, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'No liked recipes yet',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Start liking recipes to see them here!',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: _likedRecipes.map((recipe) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: RecipeCard(
              title: recipe['title'],
              description: recipe['description'],
              time: recipe['time'],
              rating: recipe['rating'],
              reviewCount: recipe['reviewCount'],
              chefName: recipe['chefName'],
              isBookmarked: recipe['isBookmarked'],
              imageUrl: recipe['imageUrl'],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildChefsList() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: _chefs.map((chef) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: GestureDetector(
              onTap: () {
                // Navigate to message page with selected chef
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MessagePage(
                      chefName: chef['name']!,
                      chefUsername: chef['username']!,
                      chefImage: chef['image']!,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(chef['image']!),
                      backgroundColor: Colors.grey[300],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            chef['name']!,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            chef['lastMessage']!,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          chef['time']!,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFFEC407A),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
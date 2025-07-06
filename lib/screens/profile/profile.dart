import 'package:flutter/material.dart';
import 'package:food_recipe/screens/widget/top_nav_bar.dart';
import 'package:food_recipe/screens/widget/button_nav_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isDarkMode = true;
  int _selectedTab = 0; // 0 = My Recipes, 1 = Liked, 2 = Chefs
  int _currentBottomNavIndex = 4; // Assuming profile is index 4 in bottom nav

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 230, 235),
      appBar: const TopNavBar(
      ),
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
                      _buildStatItem('24', 'Recipes'),
                      _buildStatItem('1.2k', 'Followers'),
                      _buildStatItem('384', 'Following'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Handle edit profile
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
            if (_selectedTab == 0) _buildRecipesGrid(),
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
          // Add navigation logic here
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

  Widget _buildRecipesGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.8,
      padding: const EdgeInsets.all(16),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: const [
        _RecipeCard(
          title: 'Spicy Ramen Bowl',
          rating: 4.5,
          time: '20 min',
          image: 'assets/ramen.jpg',
        ),
        _RecipeCard(
          title: 'Greek Salad',
          rating: 4.3,
          time: '10 min',
          image: 'assets/salad.jpg',
        ),
      ],
    );
  }

  Widget _buildLikedRecipes() {
    return const Center(
      child: Text(
        'Your liked recipes will appear here',
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _buildChefsList() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: const [
          _ChefCard(
            name: 'Emma Wilson',
            username: '@emmawilson',
            image: 'assets/chef1.jpg',
          ),
          SizedBox(height: 16),
          _ChefCard(
            name: 'James Carter',
            username: '@jamescarter',
            image: 'assets/chef2.jpg',
          ),
        ],
      ),
    );
  }
}

class _RecipeCard extends StatelessWidget {
  final String title;
  final double rating;
  final String time;
  final String image;

  const _RecipeCard({
    required this.title,
    required this.rating,
    required this.time,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                image,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.fastfood, color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          rating.toString(),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.timer, color: Colors.grey, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          time,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChefCard extends StatelessWidget {
  final String name;
  final String username;
  final String image;

  const _ChefCard({
    required this.name,
    required this.username,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(image),
            backgroundColor: Colors.grey[300],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  username,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.person_add_alt_1, color: Color(0xFFEC407A)),
            onPressed: () {
              // Handle follow chef
            },
          ),
        ],
      ),
    );
  }
}
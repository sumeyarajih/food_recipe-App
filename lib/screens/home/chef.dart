import 'package:flutter/material.dart';
import 'package:food_recipe/screens/widget/top_nav_bar.dart';
import 'package:food_recipe/screens/widget/button_nav_bar.dart';

class ChefPage extends StatefulWidget {
  const ChefPage({super.key});

  @override
  State<ChefPage> createState() => _ChefPageState();
}

class _ChefPageState extends State<ChefPage> {
  int _currentBottomNavIndex = 3; // Assuming chefs is index 1 in bottom nav
  final List<Chef> _chefs = [
    Chef(
      name: 'Gordon Ramsay',
      username: '@gordonramsay',
      bio: 'World-renowned chef, restaurateur, and television personality',
      followers: '5.2M',
      recipes: '1.4K',
      image: 'assets/chefs/gordon.jpg',
      isFollowing: false,
    ),
    Chef(
      name: 'Jamie Oliver',
      username: '@jamieoliver',
      bio: 'British chef and cookbook author known for simple recipes',
      followers: '3.8M',
      recipes: '890',
      image: 'assets/chefs/jamie.jpg',
      isFollowing: true,
    ),
    Chef(
      name: 'Nigella Lawson',
      username: '@nigellalawson',
      bio: 'Food writer and television personality',
      followers: '2.9M',
      recipes: '720',
      image: 'assets/chefs/nigella.jpg',
      isFollowing: false,
    ),
    Chef(
      name: 'David Chang',
      username: '@davidchang',
      bio: 'Chef and founder of Momofuku restaurant group',
      followers: '1.7M',
      recipes: '430',
      image: 'assets/chefs/david.jpg',
      isFollowing: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const TopNavBar(
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search chefs...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 20,
                  ),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _chefs.length,
              itemBuilder: (context, index) {
                return _ChefCard(
                  chef: _chefs[index],
                  onFollowPressed: () {
                    setState(() {
                      _chefs[index].isFollowing = !_chefs[index].isFollowing;
                    });
                  },
                );
              },
            ),
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
}

class Chef {
  final String name;
  final String username;
  final String bio;
  final String followers;
  final String recipes;
  final String image;
  bool isFollowing;

  Chef({
    required this.name,
    required this.username,
    required this.bio,
    required this.followers,
    required this.recipes,
    required this.image,
    required this.isFollowing,
  });
}

class _ChefCard extends StatelessWidget {
  final Chef chef;
  final VoidCallback onFollowPressed;

  const _ChefCard({
    required this.chef,
    required this.onFollowPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(chef.image),
                  backgroundColor: Colors.grey[200],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chef.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        chef.username,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        chef.bio,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _buildStatItem(chef.recipes, 'Recipes'),
                          const SizedBox(width: 16),
                          _buildStatItem(chef.followers, 'Followers'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey[200]),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: onFollowPressed,
                    style: TextButton.styleFrom(
                      foregroundColor: chef.isFollowing ? Colors.grey : const Color(0xFFEC407A),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text(
                      chef.isFollowing ? 'FOLLOWING' : 'FOLLOW',
                    ),
                  ),
                ),
                Container(
                  height: 24,
                  width: 1,
                  color: Colors.grey[300],
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      // Navigate to chef's profile
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text('VIEW PROFILE'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
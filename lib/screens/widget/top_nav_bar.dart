import 'package:flutter/material.dart';
import 'package:food_recipe/screens/Notification/notification.dart';
import 'package:food_recipe/screens/profile/profile.dart';

class TopNavBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onProfilePressed;
  final VoidCallback? onNotificationPressed;

  const TopNavBar({
    super.key,
    this.onProfilePressed,
    this.onNotificationPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFEC407A), // Pink background
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side - "Tasty Bites" text
          const Text(
            'Tasty Bites',
            style: TextStyle(
              color: Colors.black, // Black text
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          // Right side - Icons
          Row(
            children: [
              // Notification icon
              IconButton(
               onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotificationsScreen()),
    );
               },
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.black, // Black icon
                  size: 28,
                ),
              ),
              
              // Profile circle avatar with menu
PopupMenuButton<String>(
  icon: Container(
    width: 36,
    height: 36,
    decoration: const BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
    ),
    child: const Icon(
      Icons.person_outline,
      color: Colors.black,
      size: 20,
    ),
  ),
  onSelected: (value) {
    if (value == 'profile') {
      // Navigate to ProfilePage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfilePage()),
      );
    } else if (value == 'logout') {
      // Handle logout logic
      print("User logged out");
    }
  },
  itemBuilder: (BuildContext context) => [
    const PopupMenuItem(
      value: 'profile',
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text('Profile'),
      ),
    ),
    const PopupMenuItem(
      value: 'logout',
      child: ListTile(
        leading: Icon(Icons.logout),
        title: Text('Logout'),
      ),
    ),
  ],
),

            ],
          ),
        ],
      ),
    );
  }
}
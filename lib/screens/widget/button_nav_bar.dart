// import 'package:flutter/material.dart';
// import 'package:food_recipe/screens/home/chef.dart';
// import 'package:food_recipe/screens/home/home.dart';
// import 'package:food_recipe/screens/profile/profile.dart';
// import 'package:food_recipe/screens/recipe/create_recipe.dart';

// class CustomBottomNav extends StatelessWidget {
//   final int currentIndex;
//   final Function(int) onTabSelected;
//   final Color activeColor = const Color(0xFFEC407A); // Pink when active
//   final Color inactiveColor = Colors.grey; // Grey when inactive

//   const CustomBottomNav({
//     super.key,
//     required this.currentIndex,
//     required this.onTabSelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 80.0,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, -5),
//           ),
//         ],
//       ),
//       child: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // Left side items (Home, Explore)
//               Expanded(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     _buildNavItem(
//                       icon: Icons.home_outlined,
//                       activeIcon: Icons.home,
//                       label: "Home",
//                       index: 0,
//                       context: context,
//                     ),
//                     _buildNavItem(
//                       icon: Icons.explore_outlined,
//                       activeIcon: Icons.explore,
//                       label: "Explore",
//                       index: 1,
//                       context: context,
//                     ),
//                   ],
//                 ),
//               ),
              
//               // Center placeholder (for Add button)
//               const SizedBox(width: 80),
              
//               // Right side items (Bookmark, Profile)
//               Expanded(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     _buildNavItem(
//   icon: Icons.people_outline,      // Outline version for inactive state
//   activeIcon: Icons.people,        // Filled version for active state
//   label: "Chefs",
//   index: 3,
//   context: context,
// ),
//                     _buildNavItem(
//                       icon: Icons.person_outline,
//                       activeIcon: Icons.person,
//                       label: "Profile",
//                       index: 4,
//                       context: context,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
          
//           // Floating Add Button with Text
//           Positioned(
//             left: MediaQuery.of(context).size.width / 2 - 30,
//             top: -20,
//             child: Column(
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     if (currentIndex != 2) {
//                       onTabSelected(2); // Update active index
//                       // You might want to change this to your "Add" page
//                       Navigator.pushReplacement(
//                         context,
//                         PageRouteBuilder(
//                           pageBuilder: (_, __, ___) => CreateRecipeScreen(),
//                           transitionDuration: Duration.zero,
//                         ),
//                       );
//                     }
//                   },
//                   child: Container(
//                     width: 60,
//                     height: 60,
//                     decoration: BoxDecoration(
//                       color: currentIndex == 2 ? activeColor : inactiveColor,
//                       shape: BoxShape.circle,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.2),
//                           blurRadius: 8,
//                           offset: const Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: const Icon(
//                       Icons.add,
//                       color: Colors.white,
//                       size: 30,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   "Add",
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: currentIndex == 2 ? FontWeight.bold : FontWeight.normal,
//                     color: currentIndex == 2 ? activeColor : inactiveColor,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildNavItem({
//     required IconData icon,
//     required IconData activeIcon,
//     required String label,
//     required int index,
//     required BuildContext context,
//   }) {
//     final isSelected = currentIndex == index;
//     return GestureDetector(
//       onTap: () {
//         if (!isSelected) {
//           onTabSelected(index); // Update active index
//           Navigator.pushReplacement(
//             context,
//             PageRouteBuilder(
//               pageBuilder: (_, __, ___) => _getPageByIndex(index),
//               transitionDuration: Duration.zero,
//             ),
//           );
//         }
//       },
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             isSelected ? activeIcon : icon,
//             size: 30,
//             color: isSelected ? activeColor : inactiveColor,
//           ),
//           const SizedBox(height: 4),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//               color: isSelected ? activeColor : inactiveColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _getPageByIndex(int index) {
//     switch (index) {
//       case 0: return HomePage(); // Changed from SimulationPage to HomePage
//     //  case 1: return const ExplorePage(); // You might want to rename this to ExplorePage
//      case 2: return CreateRecipeScreen(); // This is your "Add" page - you might want to create a new page
//       case 3: return const ChefPage(); // Changed to Bookmark - you might want to create a BookmarkPage
//       case 4: return const ProfilePage();
//       default: return HomePage();
//     }
//   }
// }
///////////////////////////////////////////////////
import 'package:flutter/material.dart';
import 'package:food_recipe/screens/home/chef.dart';
import 'package:food_recipe/screens/home/home.dart';
import 'package:food_recipe/screens/home/shortcut_video.dart';
import 'package:food_recipe/screens/profile/profile.dart';
import 'package:food_recipe/screens/recipe/create_recipe.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;
  final Color activeColor = const Color(0xFFEC407A); // Pink when active
  final Color inactiveColor = Colors.grey; // Grey when inactive

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side items (Home, Shortcut Video)
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(
                      icon: Icons.home_outlined,
                      activeIcon: Icons.home,
                      label: "Home",
                      index: 0,
                      context: context,
                    ),
                    _buildNavItem(
                      icon: Icons.play_circle_outline, // TikTok-like icon outline
                      activeIcon: Icons.play_circle_filled, // TikTok-like icon filled
                      label: "Videos",
                      index: 1,
                      context: context,
                    ),
                  ],
                ),
              ),
              
              // Center placeholder (for Add button)
              const SizedBox(width: 80),
              
              // Right side items (Chefs, Profile)
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(
                      icon: Icons.people_outline,
                      activeIcon: Icons.people,
                      label: "Chefs",
                      index: 3,
                      context: context,
                    ),
                    _buildNavItem(
                      icon: Icons.person_outline,
                      activeIcon: Icons.person,
                      label: "Profile",
                      index: 4,
                      context: context,
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          // Floating Add Button with Text
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 30,
            top: -20,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    if (currentIndex != 2) {
                      onTabSelected(2); // Update active index
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => CreateRecipeScreen(),
                          transitionDuration: Duration.zero,
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: currentIndex == 2 ? activeColor : inactiveColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Add",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: currentIndex == 2 ? FontWeight.bold : FontWeight.normal,
                    color: currentIndex == 2 ? activeColor : inactiveColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
    required BuildContext context,
  }) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          onTabSelected(index); // Update active index
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => _getPageByIndex(index),
              transitionDuration: Duration.zero,
            ),
          );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSelected ? activeIcon : icon,
            size: 30,
            color: isSelected ? activeColor : inactiveColor,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? activeColor : inactiveColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getPageByIndex(int index) {
    switch (index) {
      case 0: return HomePage();
     case 1: return const ShortcutVideoPage(); // Changed from ExplorePage to ShortcutVideoPage
      case 2: return CreateRecipeScreen();
      case 3: return const ChefPage();
      case 4: return const ProfilePage();
      default: return HomePage();
    }
  }
}
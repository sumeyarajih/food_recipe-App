import 'package:flutter/material.dart';
import 'package:food_recipe/screens/widget/button_nav_bar.dart';
import 'package:food_recipe/screens/widget/top_nav_bar.dart';
import 'package:food_recipe/screens/profile/view_profile_chef.dart';

class RecipeDetailPage extends StatefulWidget {
  final String recipeName;
  final String chefName;
  final double rating;
  final int preparationTime;
  final int servings;
  final int likeCount;

  const RecipeDetailPage({
    super.key,
    required this.recipeName,
    required this.chefName,
    required this.rating,
    required this.preparationTime,
    required this.servings,
    required this.likeCount, 
    required int commentCount, 
    required String difficulty, 
    required bool isShared, 
    required String imageUrl,
  });

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  bool likeChecked = false;
  double userRating = 0;
  final TextEditingController _commentController = TextEditingController();

  final List<Map<String, dynamic>> ingredients = [
    {'name': '2 cups flour', 'checked': false},
    {'name': '2 eggs', 'checked': false},
  ];

  final List<String> steps = [
    '1. Mix all dry ingredients in a large bowl.',
    '2. In another bowl, beat the eggs and milk together.',
    '3. Combine wet and dry ingredients, stirring until just mixed.',
    '4. Heat a griddle or pan over medium heat and lightly grease.',
    '5. Pour batter onto the griddle and cook until bubbles form.',
    '6. Flip and cook until golden brown on the other side.',
    '7. Serve with fresh strawberries and maple syrup.',
  ];

  final List<Map<String, dynamic>> comments = [
    {
      'user': 'John Doe',
      'avatar': '',
      'comment': 'This recipe is amazing! My family loved it.',
      'time': '2 days ago'
    },
    {
      'user': 'Jane Smith',
      'avatar': '',
      'comment': 'I added some blueberries too and it was perfect!',
      'time': '1 week ago'
    },
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _showShareDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Share Recipe',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.link, color: Color(0xFFEC407A)),
                title: const Text('Copy Link'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Link copied to clipboard!'),
                      backgroundColor: Color(0xFFEC407A),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.message, color: Color(0xFFEC407A)),
                title: const Text('Share via Message'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Opening messages...'),
                      backgroundColor: Color(0xFFEC407A),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.share, color: Color(0xFFEC407A)),
                title: const Text('Share to Social Media'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Opening share options...'),
                      backgroundColor: Color(0xFFEC407A),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.more_horiz, color: Color(0xFFEC407A)),
                title: const Text('More Options'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToChefProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewChefProfilePage(
          chefId: '1',
          chefName: widget.chefName,
          chefUsername: '@${widget.chefName.toLowerCase().replaceAll(' ', '')}',
          chefImage: 'https://randomuser.me/api/portraits/women/1.jpg',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 230, 235),
      appBar: const TopNavBar(),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 0.2)),
        ),
        child: SizedBox(
          height: 70,
          child: CustomBottomNav(
            currentIndex: -1,
            onTabSelected: (index) {},
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/recipe_card.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: IconButton(
                    icon: Icon(
                      likeChecked ? Icons.favorite : Icons.favorite_border,
                      color: likeChecked ? Colors.red : Colors.white,
                      size: 30,
                    ),
                    onPressed: () => setState(() => likeChecked = !likeChecked),
                  ),
                ),
              ],
            ),

            // Header Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.recipeName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Clickable Chef Profile
                  GestureDetector(
                    onTap: _navigateToChefProfile,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: const NetworkImage(
                            'https://randomuser.me/api/portraits/women/1.jpg',
                          ),
                          backgroundColor: Colors.grey[300],
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'by ${widget.chefName}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFFEC407A),
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: Color(0xFFEC407A),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Stats Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatItem(
                        icon: Icons.star,
                        value: widget.rating.toString(),
                        color: const Color(0xFFFFD700),
                      ),
                      _buildStatItem(
                        icon: Icons.access_time,
                        value: '${widget.preparationTime} min',
                        color: Colors.grey,
                      ),
                      _buildStatItem(
                        icon: Icons.people_outline,
                        value: '${widget.servings} servings',
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => setState(() => likeChecked = !likeChecked),
                          icon: Icon(
                            likeChecked ? Icons.favorite : Icons.favorite_border,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Like (${widget.likeCount + (likeChecked ? 1 : 0)})',
                            style: const TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEC407A),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _showShareDialog,
                          icon: const Icon(Icons.share, color: Color(0xFFEC407A)),
                          label: const Text(
                            'Share',
                            style: TextStyle(color: Color(0xFFEC407A)),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),

            // Ingredients Section
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Ingredients',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: ingredients.map(_buildIngredientItem).toList(),
              ),
            ),
            const Divider(),

            // Steps Section
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Steps',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: steps.map((step) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(step, style: const TextStyle(fontSize: 16)),
                )).toList(),
              ),
            ),
            const Divider(),

            // Rating Section
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Rate this recipe',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: List.generate(5, (index) => IconButton(
                  icon: Icon(
                    index < userRating ? Icons.star : Icons.star_border,
                    color: const Color(0xFFFFD700),
                    size: 30,
                  ),
                  onPressed: () => setState(() => userRating = index + 1.0),
                )),
              ),
            ),
            const Divider(),

            // Comments Section
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Comments',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: comments.map(_buildCommentItem).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // Add Comment Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: 'Add a comment...',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: const Color(0xFFEC407A),
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: () {
                        if (_commentController.text.isNotEmpty) {
                          setState(() {
                            comments.insert(0, {
                              'user': 'You',
                              'avatar': '',
                              'comment': _commentController.text,
                              'time': 'Just now'
                            });
                            _commentController.clear();
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({required IconData icon, required String value, required Color color}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildIngredientItem(Map<String, dynamic> ingredient) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Checkbox(
            value: ingredient['checked'],
            onChanged: (value) => setState(() => ingredient['checked'] = value),
            activeColor: const Color(0xFFEC407A),
          ),
          Text(
            ingredient['name'],
            style: TextStyle(
              fontSize: 16,
              decoration: ingredient['checked'] ? TextDecoration.lineThrough : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentItem(Map<String, dynamic> comment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundColor: Color(0xFFEC407A),
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(comment['user'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 8),
                    Text(
                      comment['time'],
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(comment['comment']),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
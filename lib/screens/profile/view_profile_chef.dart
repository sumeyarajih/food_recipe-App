import 'package:flutter/material.dart';
import 'package:food_recipe/screens/profile/message.dart';
import 'package:food_recipe/screens/widget/recipe_card.dart';

class ViewChefProfilePage extends StatefulWidget {
  final String chefId;
  final String chefName;
  final String chefUsername;
  final String chefImage;

  const ViewChefProfilePage({
    super.key,
    required this.chefId,
    required this.chefName,
    required this.chefUsername,
    required this.chefImage,
  });

  @override
  State<ViewChefProfilePage> createState() => _ViewChefProfilePageState();
}

class _ViewChefProfilePageState extends State<ViewChefProfilePage> {
  int _selectedTab = 0; // 0 = Recipes, 1 = Videos, 2 = About
  bool _isFollowing = false;

  // Sample recipe data for this chef
  final List<Map<String, dynamic>> _chefRecipes = [
    {
      'title': 'Spicy Ramen Bowl',
      'description': 'Authentic Japanese ramen with rich broth',
      'time': '30 min',
      'rating': 4.8,
      'reviewCount': 245,
      'chefName': 'Chef Alex',
      'isBookmarked': false,
      'imageUrl': 'assets/images/recipe-image.jpg',
    },
    {
      'title': 'Greek Salad',
      'description': 'Fresh Mediterranean salad with feta cheese',
      'time': '15 min',
      'rating': 4.5,
      'reviewCount': 189,
      'chefName': 'Chef Alex',
      'isBookmarked': true,
      'imageUrl': 'assets/images/recipe-image.jpg',
    },
    {
      'title': 'Chocolate Lava Cake',
      'description': 'Decadent dessert with molten chocolate center',
      'time': '25 min',
      'rating': 4.9,
      'reviewCount': 312,
      'chefName': 'Chef Alex',
      'isBookmarked': false,
      'imageUrl': 'assets/images/recipe-image.jpg',
    },
    {
      'title': 'Sushi Platter',
      'description': 'Assorted fresh sushi rolls',
      'time': '45 min',
      'rating': 4.7,
      'reviewCount': 423,
      'chefName': 'Chef Alex',
      'isBookmarked': true,
      'imageUrl': 'assets/images/recipe-image.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 230, 235),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEC407A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () => _showOptionsDialog(context),
          ),
        ],
        centerTitle: true,
        title: Text(
          widget.chefName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header Section
            _buildProfileHeader(),

            // Stats Section
            _buildStatsSection(),

            // Bio Section
            _buildBioSection(),

            // Action Buttons
            _buildActionButtons(),

            // Tab Bar
            _buildTabBar(),

            // Tab Content
            _buildTabContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFEC407A),
                    width: 3,
                  ),
                ),
                child: CircleAvatar(
                  radius: 55,
                  backgroundImage: NetworkImage(widget.chefImage),
                  backgroundColor: Colors.grey[200],
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFEC407A),
                  ),
                  child: const Icon(
                    Icons.verified,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            widget.chefName,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.chefUsername,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatColumn('${_chefRecipes.length}', 'Recipes'),
          _buildStatColumn('1.2M', 'Followers'),
          _buildStatColumn('24.8M', 'Likes'),
          _buildStatColumn('384', 'Following'),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
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

  Widget _buildBioSection() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Professional Chef 🍳 | Food Blogger',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Creating delicious recipes since 2018. '
            'Passionate about sharing culinary knowledge with food lovers worldwide. '
            'Check out my cooking tutorials! 👨‍🍳',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.link, color: Colors.grey, size: 16),
              const SizedBox(width: 8),
              Text(
                'chefalex.com/recipes',
                style: TextStyle(
                  fontSize: 14,
                  color: const Color(0xFFEC407A),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _isFollowing = !_isFollowing;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _isFollowing
                    ? Colors.grey[200]
                    : const Color(0xFFEC407A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(
                _isFollowing ? 'Following' : 'Follow',
                style: TextStyle(
                  color: _isFollowing ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton(
              onPressed: () => _sendMessage(),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFEC407A)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.message, color: Color(0xFFEC407A), size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Message',
                    style: TextStyle(
                      color: Color(0xFFEC407A),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: Row(
        children: [
          _buildProfileTab('Recipes', 0),
          _buildProfileTab('Videos', 1),
          _buildProfileTab('About', 2),
        ],
      ),
    );
  }

  Widget _buildProfileTab(String text, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTab = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: _selectedTab == index
                    ? const Color(0xFFEC407A)
                    : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: _selectedTab == index ? Colors.black : Colors.grey,
                fontWeight:
                    _selectedTab == index ? FontWeight.bold : FontWeight.normal,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTab) {
      case 0:
        return _buildRecipesTab();
      case 1:
        return _buildVideosGrid();
      case 2:
        return _buildAboutSection();
      default:
        return Container();
    }
  }

  Widget _buildRecipesTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: _chefRecipes.map((recipe) {
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

  Widget _buildVideosGrid() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      itemBuilder: (context, index) {
        final videoData = [
          {
            'title': 'How to Make Perfect Carbonara',
            'views': '245K',
            'duration': '8:32',
            'thumbnail': 'assets/images/recipe-image.jpg',
          },
          {
            'title': 'Quick & Easy Breakfast Ideas',
            'views': '189K',
            'duration': '5:45',
            'thumbnail': 'assets/images/recipe-image.jpg',
          },
          {
            'title': 'Chocolate Cake Tutorial',
            'views': '412K',
            'duration': '12:15',
            'thumbnail': 'assets/images/recipe-image.jpg',
          },
          {
            'title': 'Sushi Rolling Masterclass',
            'views': '356K',
            'duration': '15:20',
            'thumbnail': 'assets/images/recipe-image.jpg',
          },
          {
            'title': 'Grilled Salmon Techniques',
            'views': '298K',
            'duration': '10:05',
            'thumbnail': 'assets/images/recipe-image.jpg',
          },
          {
            'title': 'Dessert Plating Tips',
            'views': '167K',
            'duration': '6:40',
            'thumbnail': 'assets/images/recipe-image.jpg',
          },
        ];

        final video = videoData[index % videoData.length];
        
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Video Thumbnail
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.asset(
                        video['thumbnail']!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: Colors.grey[300],
                          child: const Center(
                            child: Icon(
                              Icons.videocam,
                              size: 60,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  // Play Button Overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.3),
                          ],
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.play_circle_filled,
                          size: 64,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  
                  // Duration Badge
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        video['duration']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              // Video Info
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video['title']!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.play_arrow,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${video['views']} views',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '2 days ago',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAboutSection() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(Icons.cake, 'Joined March 2018'),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.location_on, 'Los Angeles, California'),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.restaurant, 'Specializes in Asian & Fusion Cuisine'),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.school, 'Culinary Institute of America'),
          const SizedBox(height: 20),
          const Text(
            'Achievements',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildAchievementChip('🏆 Top Chef 2022'),
              _buildAchievementChip('🔥 1M Followers'),
              _buildAchievementChip('⭐ Verified Chef'),
              _buildAchievementChip('📚 5 Cookbooks'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFFEC407A), size: 20),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFEC407A).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEC407A).withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFFEC407A),
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void _sendMessage() {
    // Navigate to message page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MessagePage(
          chefName: widget.chefName,
          chefUsername: widget.chefUsername,
          chefImage: widget.chefImage,
        ),
      ),
    );
  }

  void _showOptionsDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.report, color: Colors.red),
                title: const Text('Report User',
                    style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.block, color: Colors.grey),
                title: const Text('Block User'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.share, color: Colors.blue),
                title: const Text('Share Profile'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.copy, color: Colors.grey),
                title: const Text('Copy Profile Link'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
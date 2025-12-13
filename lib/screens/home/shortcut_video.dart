import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:food_recipe/screens/widget/button_nav_bar.dart';

class ShortcutVideoPage extends StatefulWidget {
  const ShortcutVideoPage({Key? key}) : super(key: key);

  @override
  _ShortcutVideoPageState createState() => _ShortcutVideoPageState();
}

class _ShortcutVideoPageState extends State<ShortcutVideoPage> {
  // Sample video data with YouTube video IDs
  final List<VideoItem> _forYouVideos = [
    VideoItem(
      id: '1',
      videoUrl: '907vZOyWTo8',
      userAvatar: 'https://randomuser.me/api/portraits/women/1.jpg',
      username: 'Chef Maria',
      title: 'Perfect Carbonara Recipe',
      likes: 2300,
      comments: 156,
      shares: 45,
      recipeName: 'Carbonara Pasta',
      cookingTime: '15 min',
      difficulty: 'Easy',
      isLiked: false,
      isBookmarked: false,
    ),
    VideoItem(
      id: '2',
      videoUrl: '3SVi80fjs7U',
      userAvatar: 'https://randomuser.me/api/portraits/men/2.jpg',
      username: 'Master Chef John',
      title: 'Homemade Pizza from Scratch',
      likes: 5100,
      comments: 342,
      shares: 89,
      recipeName: 'Neapolitan Pizza',
      cookingTime: '2 hours',
      difficulty: 'Medium',
      isLiked: false,
      isBookmarked: false,
    ),
    VideoItem(
      id: '3',
      videoUrl: 'f2qsR2rrl8M',
      userAvatar: 'https://randomuser.me/api/portraits/women/3.jpg',
      username: 'Vegan Delights',
      title: 'Vegan Buddha Bowl',
      likes: 1800,
      comments: 98,
      shares: 32,
      recipeName: 'Rainbow Buddha Bowl',
      cookingTime: '20 min',
      difficulty: 'Easy',
      isLiked: false,
      isBookmarked: false,
    ),
  ];

  final List<VideoItem> _followingVideos = [
    VideoItem(
      id: '5',
      videoUrl: '-BYWbosiYlw',
      userAvatar: 'https://randomuser.me/api/portraits/women/5.jpg',
      username: 'Pastry Queen',
      title: 'Chocolate Croissants',
      likes: 3700,
      comments: 198,
      shares: 52,
      recipeName: 'French Croissant',
      cookingTime: '3 hours',
      difficulty: 'Hard',
      isLiked: false,
      isBookmarked: false,
    ),
    VideoItem(
      id: '6',
      videoUrl: 'iLnmTe5Q2Qw',
      userAvatar: 'https://randomuser.me/api/portraits/men/6.jpg',
      username: 'Sushi Master',
      title: 'Authentic Sushi Rolls',
      likes: 4900,
      comments: 321,
      shares: 78,
      recipeName: 'California Roll',
      cookingTime: '40 min',
      difficulty: 'Medium',
      isLiked: false,
      isBookmarked: false,
    ),
  ];

  final List<VideoItem> _trendingVideos = [
    VideoItem(
      id: '7',
      videoUrl: 's6zR2T9vn2c',
      userAvatar: 'https://randomuser.me/api/portraits/women/7.jpg',
      username: 'Soup Goddess',
      title: 'Hearty Tomato Soup',
      likes: 8200,
      comments: 512,
      shares: 124,
      recipeName: 'Tomato Basil Soup',
      cookingTime: '30 min',
      difficulty: 'Easy',
      isLiked: false,
      isBookmarked: false,
    ),
    VideoItem(
      id: '8',
      videoUrl: 'dQw4w9WgXcQ',
      userAvatar: 'https://randomuser.me/api/portraits/men/8.jpg',
      username: 'Burger Expert',
      title: 'Gourmet Burger',
      likes: 6500,
      comments: 432,
      shares: 96,
      recipeName: 'Double Cheeseburger',
      cookingTime: '25 min',
      difficulty: 'Easy',
      isLiked: false,
      isBookmarked: false,
    ),
  ];

  final PageController _pageController = PageController();
  final List<YoutubePlayerController?> _youtubeControllers = [];
  int _currentTab = 0;
  List<VideoItem> _currentVideos = [];

  @override
  void initState() {
    super.initState();
    _currentVideos = _forYouVideos;
    _initializeVideos();
  }

  void _initializeVideos() {
    _clearControllers();
    for (var video in _currentVideos) {
      final controller = YoutubePlayerController(
        initialVideoId: video.videoUrl,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          hideControls: false,
          controlsVisibleAtStart: true,
        ),
      );
      _youtubeControllers.add(controller);
    }
    setState(() {});
  }

  void _clearControllers() {
    for (var controller in _youtubeControllers) {
      controller?.dispose();
    }
    _youtubeControllers.clear();
  }

  void _switchTab(int tabIndex) {
    setState(() {
      _currentTab = tabIndex;
      _pageController.jumpToPage(0);
      
      switch (tabIndex) {
        case 0:
          _currentVideos = _forYouVideos;
          break;
        case 1:
          _currentVideos = _followingVideos;
          break;
        case 2:
          _currentVideos = _trendingVideos;
          break;
      }
      
      _initializeVideos();
    });
  }

  void _toggleLike(int index) {
    setState(() {
      _currentVideos[index].isLiked = !_currentVideos[index].isLiked;
      if (_currentVideos[index].isLiked) {
        _currentVideos[index].likes++;
      } else {
        _currentVideos[index].likes--;
      }
    });
  }

  void _toggleBookmark(int index) {
    setState(() {
      _currentVideos[index].isBookmarked = !_currentVideos[index].isBookmarked;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_currentVideos[index].isBookmarked ? 'Recipe saved!' : 'Recipe removed'),
        duration: const Duration(seconds: 1),
        backgroundColor: const Color(0xFFEC407A),
      ),
    );
  }

  void _handleShare(VideoItem video) {
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.link, color: Color(0xFFEC407A)),
                title: const Text('Copy Link'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Link copied!')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.message, color: Color(0xFFEC407A)),
                title: const Text('Share via Message'),
                onTap: () => Navigator.pop(context),
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

  @override
  void dispose() {
    _pageController.dispose();
    _clearControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Video PageView
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: _currentVideos.length,
            onPageChanged: (index) {
              setState(() {
              });
              // Pause previous video
              if (_youtubeControllers.isNotEmpty && index > 0 && index - 1 < _youtubeControllers.length) {
                _youtubeControllers[index - 1]?.pause();
              }
            },
            itemBuilder: (context, index) {
              if (index >= _youtubeControllers.length || _youtubeControllers[index] == null) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }

              final video = _currentVideos[index];
              final controller = _youtubeControllers[index]!;
              
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.black,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // YouTube Video Player - Full Screen
                    Center(
                      child: AspectRatio(
                        aspectRatio: 9 / 16,
                        child: YoutubePlayer(
                          controller: controller,
                          progressIndicatorColor: const Color(0xFFEC407A),
                          progressColors: const ProgressBarColors(
                            playedColor: Color(0xFFEC407A),
                            handleColor: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    // Video Info Overlay
                    Positioned(
                      bottom: 100,
                      left: 16,
                      right: 90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Username
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundImage: NetworkImage(video.userAvatar),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                video.username,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(blurRadius: 4, color: Colors.black),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Video Title
                          Text(
                            video.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(blurRadius: 6, color: Colors.black),
                              ],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),

                          // Recipe Info
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildInfoChip(Icons.restaurant, video.recipeName),
                                const SizedBox(width: 12),
                                _buildInfoChip(Icons.timer, video.cookingTime),
                                const SizedBox(width: 12),
                                _buildInfoChip(Icons.star, video.difficulty),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Right Side Actions
                    Positioned(
                      right: 8,
                      bottom: 100,
                      child: Column(
                        children: [
                          // Like Button
                          _buildActionButton(
                            icon: video.isLiked ? Icons.favorite : Icons.favorite_border,
                            label: _formatCount(video.likes),
                            onTap: () => _toggleLike(index),
                            isActive: video.isLiked,
                          ),
                          const SizedBox(height: 20),

                          // Comment Button
                          _buildActionButton(
                            icon: Icons.comment,
                            label: _formatCount(video.comments),
                            onTap: () => _showCommentsSheet(context, video),
                          ),
                          const SizedBox(height: 20),

                          // Share Button
                          _buildActionButton(
                            icon: Icons.share,
                            label: _formatCount(video.shares),
                            onTap: () => _handleShare(video),
                          ),
                          const SizedBox(height: 20),

                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          // Top Bar with tabs
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => _switchTab(0),
                  child: _buildTopButton('For You', isActive: _currentTab == 0),
                ),
                GestureDetector(
                  onTap: () => _switchTab(1),
                  child: _buildTopButton('Following', isActive: _currentTab == 1),
                ),
                GestureDetector(
                  onTap: () => _switchTab(2),
                  child: _buildTopButton('Trending', isActive: _currentTab == 2),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: 1,
        onTabSelected: (index) {
          // Handle navigation
        },
      ),
    );
  }

  String _formatCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.white),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isActive ? const Color(0xFFEC407A) : Colors.white,
              size: 28,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildTopButton(String text, {bool isActive = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFEC407A) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: isActive ? null : Border.all(color: Colors.white54, width: 1),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  void _showCommentsSheet(BuildContext context, VideoItem video) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          builder: (_, controller) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Comments (${_formatCount(video.comments)})',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: controller,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const CircleAvatar(
                            backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/1.jpg'),
                          ),
                          title: const Text('Food Lover'),
                          subtitle: const Text('This recipe looks amazing! Can\'t wait to try it!'),
                          trailing: IconButton(
                            icon: const Icon(Icons.favorite_border, size: 20),
                            onPressed: () {},
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.grey[300]!)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Add a comment...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          icon: const Icon(Icons.send, color: Color(0xFFEC407A)),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class VideoItem {
  final String id;
  final String videoUrl;
  final String userAvatar;
  final String username;
  final String title;
  int likes;
  final int comments;
  final int shares;
  final String recipeName;
  final String cookingTime;
  final String difficulty;
  bool isLiked;
  bool isBookmarked;

  VideoItem({
    required this.id,
    required this.videoUrl,
    required this.userAvatar,
    required this.username,
    required this.title,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.recipeName,
    required this.cookingTime,
    required this.difficulty,
    required this.isLiked,
    required this.isBookmarked,
  });
}
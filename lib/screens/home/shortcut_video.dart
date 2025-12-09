import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class ShortcutVideoPage extends StatefulWidget {
  const ShortcutVideoPage({Key? key}) : super(key: key);

  @override
  _ShortcutVideoPageState createState() => _ShortcutVideoPageState();
}

class _ShortcutVideoPageState extends State<ShortcutVideoPage> {
  // Sample video data - in real app, fetch from API
  final List<VideoItem> _forYouVideos = [
    VideoItem(
      id: '1',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
      userAvatar: 'https://randomuser.me/api/portraits/women/1.jpg',
      username: 'Chef Maria',
      title: 'Perfect Carbonara Recipe',
      likes: '2.3k',
      comments: '156',
      shares: '45',
      recipeName: 'Carbonara Pasta',
      cookingTime: '15 min',
      difficulty: 'Easy',
    ),
    VideoItem(
      id: '2',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
      userAvatar: 'https://randomuser.me/api/portraits/men/2.jpg',
      username: 'Master Chef John',
      title: 'Homemade Pizza from Scratch',
      likes: '5.1k',
      comments: '342',
      shares: '89',
      recipeName: 'Neapolitan Pizza',
      cookingTime: '2 hours',
      difficulty: 'Medium',
    ),
    VideoItem(
      id: '3',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      userAvatar: 'https://randomuser.me/api/portraits/women/3.jpg',
      username: 'Vegan Delights',
      title: 'Vegan Buddha Bowl',
      likes: '1.8k',
      comments: '98',
      shares: '32',
      recipeName: 'Rainbow Buddha Bowl',
      cookingTime: '20 min',
      difficulty: 'Easy',
    ),
    VideoItem(
      id: '4',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
      userAvatar: 'https://randomuser.me/api/portraits/men/4.jpg',
      username: 'BBQ King',
      title: 'Perfect Steak Grilling',
      likes: '4.2k',
      comments: '287',
      shares: '67',
      recipeName: 'Ribeye Steak',
      cookingTime: '25 min',
      difficulty: 'Medium',
    ),
  ];

  final List<VideoItem> _followingVideos = [
    VideoItem(
      id: '5',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
      userAvatar: 'https://randomuser.me/api/portraits/women/5.jpg',
      username: 'Pastry Queen',
      title: 'Chocolate Croissants',
      likes: '3.7k',
      comments: '198',
      shares: '52',
      recipeName: 'French Croissant',
      cookingTime: '3 hours',
      difficulty: 'Hard',
    ),
    VideoItem(
      id: '6',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
      userAvatar: 'https://randomuser.me/api/portraits/men/6.jpg',
      username: 'Sushi Master',
      title: 'Authentic Sushi Rolls',
      likes: '4.9k',
      comments: '321',
      shares: '78',
      recipeName: 'California Roll',
      cookingTime: '40 min',
      difficulty: 'Medium',
    ),
  ];

  final List<VideoItem> _trendingVideos = [
    VideoItem(
      id: '7',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
      userAvatar: 'https://randomuser.me/api/portraits/women/7.jpg',
      username: 'Soup Goddess',
      title: 'Hearty Tomato Soup',
      likes: '8.2k',
      comments: '512',
      shares: '124',
      recipeName: 'Tomato Basil Soup',
      cookingTime: '30 min',
      difficulty: 'Easy',
    ),
    VideoItem(
      id: '8',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
      userAvatar: 'https://randomuser.me/api/portraits/men/8.jpg',
      username: 'Burger Expert',
      title: 'Gourmet Burger',
      likes: '6.5k',
      comments: '432',
      shares: '96',
      recipeName: 'Double Cheeseburger',
      cookingTime: '25 min',
      difficulty: 'Easy',
    ),
  ];

  final PageController _pageController = PageController();
  final List<ChewieController?> _chewieControllers = [];
  int _currentTab = 0; // 0 = For You, 1 = Following, 2 = Trending
  List<VideoItem> _currentVideos = [];

  @override
  void initState() {
    super.initState();
    _currentVideos = _forYouVideos;
    _initializeVideos();
  }

  void _initializeVideos() async {
    _clearControllers();
    for (var video in _currentVideos) {
      final videoPlayerController = VideoPlayerController.network(video.videoUrl);
      await videoPlayerController.initialize();
      _chewieControllers.add(ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: false,
        looping: true,
        showControls: false,
        allowMuting: true,
        allowFullScreen: true,
        autoInitialize: true,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      ));
    }
    setState(() {});
  }

  void _clearControllers() {
    for (var controller in _chewieControllers) {
      controller?.dispose();
    }
    _chewieControllers.clear();
  }

  void _switchTab(int tabIndex) {
    setState(() {
      _currentTab = tabIndex;
      _pageController.jumpToPage(0);
      
      // Update current videos based on tab
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
      
      // Reinitialize videos for new tab
      _initializeVideos();
    });
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
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: _currentVideos.length,
            onPageChanged: (index) {
              setState(() {
              });
              // Pause previous video
              if (_chewieControllers.isNotEmpty && index > 0) {
                _chewieControllers[index - 1]?.pause();
              }
            },
            itemBuilder: (context, index) {
              if (index >= _chewieControllers.length || _chewieControllers[index] == null) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }

              final video = _currentVideos[index];
              return Stack(
                children: [
                  // Video Player
                  GestureDetector(
                    onTap: () {
                      if (_chewieControllers[index]!.isPlaying) {
                        _chewieControllers[index]!.pause();
                      } else {
                        _chewieControllers[index]!.play();
                      }
                      setState(() {});
                    },
                    child: Chewie(controller: _chewieControllers[index]!),
                  ),

                  // Video Info Overlay
                  Positioned(
                    bottom: 80,
                    left: 16,
                    right: 100,
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
                                  Shadow(
                                    blurRadius: 4,
                                    color: Colors.black,
                                  ),
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
                              Shadow(
                                blurRadius: 6,
                                color: Colors.black,
                              ),
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
                    right: 16,
                    bottom: 80,
                    child: Column(
                      children: [
                        // Like Button
                        _buildActionButton(
                          icon: Icons.favorite_border,
                          label: video.likes,
                          onTap: () {
                            // Handle like
                          },
                        ),
                        const SizedBox(height: 20),

                        // Comment Button
                        _buildActionButton(
                          icon: Icons.comment,
                          label: video.comments,
                          onTap: () {
                            _showCommentsSheet(context, video);
                          },
                        ),
                        const SizedBox(height: 20),

                        // Share Button
                        _buildActionButton(
                          icon: Icons.share,
                          label: video.shares,
                          onTap: () {
                            // Handle share
                          },
                        ),
                        const SizedBox(height: 20),

                        // Bookmark Button
                        _buildActionButton(
                          icon: Icons.bookmark_border,
                          label: 'Save',
                          onTap: () {
                            // Handle bookmark
                          },
                        ),
                      ],
                    ),
                  ),

                  // Play/Pause Indicator
                  if (!_chewieControllers[index]!.isPlaying)
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: () {
                          _chewieControllers[index]!.play();
                          setState(() {});
                        },
                        child: Container(
                          color: Colors.black38,
                          child: const Center(
                            child: Icon(
                              Icons.play_circle_filled,
                              size: 80,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),

          // Top Bar with functional tabs
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
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Row(
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
            child: Icon(icon, color: Colors.white, size: 28),
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
        style: TextStyle(
          color: isActive ? Colors.white : Colors.white,
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
                color: Colors.black87,
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
                          'Comments (${video.comments})',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
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
                          title: const Text(
                            'Food Lover',
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: const Text(
                            'This recipe looks amazing! Can\'t wait to try it!',
                            style: TextStyle(color: Colors.white70),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.favorite_border, color: Colors.white, size: 20),
                            onPressed: () {},
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border(top: BorderSide(color: Colors.grey[800]!)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Add a comment...',
                              hintStyle: const TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey[900],
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
  final String likes;
  final String comments;
  final String shares;
  final String recipeName;
  final String cookingTime;
  final String difficulty;

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
  });
}
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:food_recipe/screens/widget/button_nav_bar.dart';
import 'package:food_recipe/screens/widget/top_nav_bar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CreateRecipeScreen extends StatefulWidget {
  const CreateRecipeScreen({super.key});

  @override
  _CreateRecipeScreenState createState() => _CreateRecipeScreenState();
}

class _CreateRecipeScreenState extends State<CreateRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final Color _pinkColor = const Color(0xFFEC407A);
  final Color _whiteColor = const Color(0xFFFFFFFF);

  // Media
  File? _imageFile; // Required image
// Optional YouTube URL
  YoutubePlayerController? _youtubeController;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _youtubeUrlController = TextEditingController();

  // Recipe fields
  // ignore: unused_field
  String _title = '';
  final List<String> _ingredients = [''];
  final List<String> _steps = [''];
  int _prepTime = 15;
  int _cookTime = 30;
  int _serving = 2;
  String _difficulty = 'Easy';
  String _category = 'Breakfast';
  
  final List<String> _difficultyLevels = ['Easy', 'Medium', 'Hard'];
  final List<String> _categories = [
    'Breakfast', 'Lunch', 'Dinner', 
    'Dessert', 'Vegan', 'Keto'
  ];

  @override
  void dispose() {
    _youtubeController?.dispose();
    _youtubeUrlController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _initializeYoutubePlayer(String url) {
    final videoId = YoutubePlayer.convertUrlToId(url);
    if (videoId != null) {
      _youtubeController?.dispose();
      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );
      setState(() {
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid YouTube URL')),
      );
    }
  }

  void _removeImage() {
    setState(() {
      _imageFile = null;
    });
  }

  void _removeVideo() {
    setState(() {
      _youtubeController?.dispose();
      _youtubeController = null;
      _youtubeUrlController.clear();
    });
  }

  void _addIngredient() {
    setState(() {
      _ingredients.add('');
    });
  }

  void _addStep() {
    setState(() {
      _steps.add('');
    });
  }

  void _submitRecipe() {
    if (_formKey.currentState!.validate()) {
      // Check if image is uploaded (required)
      if (_imageFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Please add an image for your recipe'),
            backgroundColor: _pinkColor,
          ),
        );
        return;
      }
      
      _formKey.currentState!.save();
      _showConfirmationDialog();
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Publish Recipe?', style: TextStyle(color: _pinkColor)),
          content: const Text('Are you sure you want to publish this recipe?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close confirmation
                _showSuccessModal(); // Show premium success modal
              },
              style: ElevatedButton.styleFrom(backgroundColor: _pinkColor),
              child: const Text('Publish', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessModal() {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: 'Success',
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Scaffold(
          backgroundColor: Colors.black.withOpacity(0.8),
          body: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                   BoxShadow(
                    color: _pinkColor.withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ScaleTransition(
                    scale: CurvedAnimation(
                      parent: animation,
                      curve: Curves.elasticOut,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: _pinkColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check_rounded,
                        size: 60,
                        color: _pinkColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.5),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOut,
                    )),
                    child: Column(
                      children: [
                         Text(
                          'Published!',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Your recipe is now live and ready to inspire others!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); 
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _pinkColor,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'View Recipe',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: () {
                           Navigator.of(context).pop();
                           Navigator.of(context).pop(); 
                        },
                        child: Text(
                          'Back to Home',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutBack,
            ),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      backgroundColor: _whiteColor,
      appBar: const TopNavBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isSmallScreen ? 12 : 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Picker Section (Required)
              _buildImagePicker(),
              const SizedBox(height: 16),
              
              // YouTube URL Input (Optional)
              _buildYoutubeInput(),
              const SizedBox(height: 24),

              // Recipe Title
              _buildSectionTitle('Recipe Title'),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Give your dish a catchy name...',
                  fillColor: Colors.grey[50],
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: _pinkColor, width: 1.5),
                  ),
                  prefixIcon: Icon(Icons.restaurant_menu, color: _pinkColor),
                ),
                style: const TextStyle(fontWeight: FontWeight.w600),
                validator: (value) => value!.isEmpty ? 'Required' : null,
                onSaved: (value) => _title = value!,
              ),
              SizedBox(height: isSmallScreen ? 20 : 24),

              // Time & Servings Row
              Row(
                children: [
                  Expanded(
                    child: _buildTimeInput('Prep', _prepTime, (val) => setState(() => _prepTime = val), Icons.timer_outlined),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTimeInput('Cook', _cookTime, (val) => setState(() => _cookTime = val), Icons.outdoor_grill_outlined),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTimeInput('Serves', _serving, (val) => setState(() => _serving = val), Icons.people_outline),
                  ),
                ],
              ),
              SizedBox(height: isSmallScreen ? 20 : 24),

              // Difficulty & Category
               Row(
                children: [
                  Expanded(
                    child: _buildDropdownSection(
                      'Difficulty', 
                      _difficulty, 
                      _difficultyLevels, 
                      (value) => setState(() => _difficulty = value.toString()),
                      Icons.bar_chart,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildDropdownSection(
                      'Category', 
                      _category, 
                      _categories, 
                      (value) => setState(() => _category = value.toString()),
                      Icons.category_outlined,
                    ),
                  ),
                ],
              ),
              SizedBox(height: isSmallScreen ? 20 : 24),

              // Ingredients
              _buildSectionHeader('Ingredients', Icons.shopping_basket_outlined, _addIngredient),
              const SizedBox(height: 8),
              ..._ingredients.asMap().entries.map((entry) {
                int idx = entry.key;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Container(
                        width: 8, height: 8,
                        decoration: BoxDecoration(color: _pinkColor, shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          initialValue: _ingredients[idx],
                          decoration: InputDecoration(
                            hintText: 'e.g. 2 cups of flour',
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                          onChanged: (value) => _ingredients[idx] = value,
                        ),
                      ),
                      if (_ingredients.length > 1)
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.grey, size: 20),
                          onPressed: () {
                             setState(() {
                               _ingredients.removeAt(idx);
                             });
                          },
                        ),
                    ],
                  ),
                );
              }).toList(),
              const SizedBox(height: 24),

              // Steps
              _buildSectionHeader('Instructions', Icons.format_list_numbered, _addStep),
               const SizedBox(height: 8),
              ..._steps.asMap().entries.map((entry) {
                int idx = entry.key;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 4, right: 12),
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: _pinkColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: _pinkColor.withOpacity(0.5)),
                        ),
                        child: Center(
                          child: Text(
                            '${idx + 1}',
                            style: TextStyle(color: _pinkColor, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          initialValue: _steps[idx],
                          decoration: InputDecoration(
                            hintText: 'Describe this step...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          maxLines: 3,
                          onChanged: (value) => _steps[idx] = value,
                        ),
                      ),
                       if (_steps.length > 1)
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.grey, size: 20),
                          onPressed: () {
                             setState(() {
                               _steps.removeAt(idx);
                             });
                          },
                        ),
                    ],
                  ),
                );
              }).toList(),
              const SizedBox(height: 40),

              // Publish Button
              Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: _pinkColor.withOpacity(0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  gradient: LinearGradient(
                    colors: [_pinkColor, _pinkColor.withOpacity(0.8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: ElevatedButton(
                  onPressed: _submitRecipe,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: const Text(
                    'Publish Recipe',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
       bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.2),
          ),
        ),
        child: SizedBox(
          height: 70,
          child: CustomBottomNav(
            currentIndex: 2,
            onTabSelected: (index) {},
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildSectionTitle('Recipe Image'),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Required',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: _imageFile != null
                ? Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                          _imageFile!,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: _removeImage,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.close, color: Colors.white, size: 20),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _pinkColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.add_a_photo, size: 40, color: _pinkColor),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Add Recipe Image',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Required - Tap to upload',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.red[400],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildYoutubeInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildSectionTitle('YouTube Video'),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Optional',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (_youtubeController == null)
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _youtubeUrlController,
                  decoration: InputDecoration(
                    hintText: 'Paste YouTube URL here...',
                    fillColor: Colors.grey[50],
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.video_library, color: _pinkColor),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  if (_youtubeUrlController.text.isNotEmpty) {
                    _initializeYoutubePlayer(_youtubeUrlController.text);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _pinkColor,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Add', style: TextStyle(color: Colors.white)),
              ),
            ],
          )
        else
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black,
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: YoutubePlayer(
                    controller: _youtubeController!,
                    showVideoProgressIndicator: true,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: _removeVideo,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, VoidCallback onAdd) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSectionTitle(title, icon: icon),
        TextButton.icon(
          onPressed: onAdd,
          icon: Icon(Icons.add, size: 18, color: _pinkColor),
          label: Text('Add', style: TextStyle(color: _pinkColor, fontWeight: FontWeight.bold)),
          style: TextButton.styleFrom(
            backgroundColor: _pinkColor.withOpacity(0.1),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          if (icon != null) ...[ 
            Icon(icon, size: 20, color: _pinkColor),
            const SizedBox(width: 8),
          ],
          Text(
            title,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeInput(String label, int value, Function(int) onChanged, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Padding(
           padding: const EdgeInsets.only(bottom: 8),
           child: Text(label, style: TextStyle(color: Colors.grey[700], fontSize: 13, fontWeight: FontWeight.bold)),
         ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              Icon(icon, size: 20, color: Colors.grey[400]),
              const SizedBox(height: 4),
              Text(
                '$value',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => onChanged(value > 1 ? value - 1 : 1),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(Icons.remove_circle_outline, size: 20, color: Colors.grey[400]),
                    ),
                  ),
                  InkWell(
                    onTap: () => onChanged(value + 1),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(Icons.add_circle, size: 20, color: _pinkColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownSection(
    String title, 
    String value, 
    List<String> items, 
    Function(dynamic) onChanged,
    IconData icon
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
           padding: const EdgeInsets.only(bottom: 8),
           child: Text(title, style: TextStyle(color: Colors.grey[700], fontSize: 13, fontWeight: FontWeight.bold)),
         ),
        ButtonTheme(
          alignedDropdown: true,
          child: DropdownButtonFormField(
            value: value,
            items: items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item, style: const TextStyle(fontSize: 14)),
              );
            }).toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              prefixIcon: Icon(icon, color: _pinkColor, size: 20),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            icon: const Icon(Icons.keyboard_arrow_down, size: 20),
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:food_recipe/screens/widget/button_nav_bar.dart';
import 'package:food_recipe/screens/widget/top_nav_bar.dart';

class CreateRecipeScreen extends StatefulWidget {
  @override
  _CreateRecipeScreenState createState() => _CreateRecipeScreenState();
}

class _CreateRecipeScreenState extends State<CreateRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final Color _pinkColor = Color(0xFFEC407A);
  final Color _whiteColor = Color(0xFFFFFFFF);

  // Recipe fields
  String _title = '';
  List<String> _ingredients = [''];
  List<String> _steps = [''];
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
      _formKey.currentState!.save();
      _showConfirmationDialog();
    }
  }

  void _showConfirmationDialog() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(isSmallScreen ? 20 : 25),
            decoration: BoxDecoration(
              color: _whiteColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.help_outline,
                  size: 60,
                  color: _pinkColor,
                ),
                SizedBox(height: 20),
                Text(
                  'Confirm Recipe Publication',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 18 : 22,
                    fontWeight: FontWeight.bold,
                    color: _pinkColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15),
                Text(
                  'Are you sure you want to publish this recipe?',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 14 : 16,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          side: BorderSide(color: _pinkColor),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: _pinkColor,
                            fontSize: isSmallScreen ? 14 : 16,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _showSuccessDialog();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _pinkColor,
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          'Publish',
                          style: TextStyle(
                            color: _whiteColor,
                            fontSize: isSmallScreen ? 14 : 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSuccessDialog() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(Duration(milliseconds: 1500), () {
          Navigator.of(context).pop();
          Navigator.of(context).pop(); // Also pop the CreateRecipeScreen
        });

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(isSmallScreen ? 20 : 25),
            decoration: BoxDecoration(
              color: _whiteColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle,
                  size: 60,
                  color: Colors.green,
                ),
                SizedBox(height: 20),
                Text(
                  'Recipe Published!',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 18 : 22,
                    fontWeight: FontWeight.bold,
                    color: _pinkColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15),
                Text(
                  'Your recipe has been successfully published.',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 14 : 16,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25),
              ],
            ),
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
      appBar: TopNavBar(), // Using your TopNavBar component
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isSmallScreen ? 12 : 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Recipe Title
              _buildSectionTitle('Recipe Title'),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter recipe name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: _pinkColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: _pinkColor, width: 2),
                  ),
                ),
                validator: (value) => value!.isEmpty ? 'Required' : null,
                onSaved: (value) => _title = value!,
              ),
              SizedBox(height: isSmallScreen ? 16 : 24),

              // Recipe Details Row - Responsive layout
              if (isSmallScreen) ...[
                // Mobile layout - vertical
                _buildTimeInput('Prep (min)', _prepTime, (value) {
                  setState(() => _prepTime = value);
                }),
                SizedBox(height: 16),
                _buildTimeInput('Cook (min)', _cookTime, (value) {
                  setState(() => _cookTime = value);
                }),
                SizedBox(height: 16),
                _buildTimeInput('Servings', _serving, (value) {
                  setState(() => _serving = value);
                }),
              ] else ...[
                // Desktop/tablet layout - horizontal
                Row(
                  children: [
                    Expanded(
                      child: _buildTimeInput('Prep (min)', _prepTime, (value) {
                        setState(() => _prepTime = value);
                      }),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildTimeInput('Cook (min)', _cookTime, (value) {
                        setState(() => _cookTime = value);
                      }),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildTimeInput('Servings', _serving, (value) {
                        setState(() => _serving = value);
                      }),
                    ),
                  ],
                ),
              ],
              SizedBox(height: isSmallScreen ? 16 : 24),

              // Difficulty & Category - Responsive layout
              if (isSmallScreen) ...[
                // Mobile layout - vertical
                Column(
                  children: [
                    _buildDropdownSection(
                      'Difficulty', 
                      _difficulty, 
                      _difficultyLevels, 
                      (value) => setState(() => _difficulty = value.toString())
                    ),
                    SizedBox(height: 16),
                    _buildDropdownSection(
                      'Category', 
                      _category, 
                      _categories, 
                      (value) => setState(() => _category = value.toString())
                    ),
                  ],
                ),
              ] else ...[
                // Desktop/tablet layout - horizontal
                Row(
                  children: [
                    Expanded(
                      child: _buildDropdownSection(
                        'Difficulty', 
                        _difficulty, 
                        _difficultyLevels, 
                        (value) => setState(() => _difficulty = value.toString())
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildDropdownSection(
                        'Category', 
                        _category, 
                        _categories, 
                        (value) => setState(() => _category = value.toString())
                      ),
                    ),
                  ],
                ),
              ],
              SizedBox(height: isSmallScreen ? 16 : 24),

              // Ingredients
              _buildSectionTitle('Ingredients'),
              ..._ingredients.asMap().entries.map((entry) {
                int idx = entry.key;
                return Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Ingredient ${idx + 1}',
                            prefixIcon: Icon(Icons.circle, size: 8, color: _pinkColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onChanged: (value) => _ingredients[idx] = value,
                        ),
                      ),
                      if (idx == _ingredients.length - 1)
                        IconButton(
                          icon: Icon(Icons.add_circle, color: _pinkColor),
                          onPressed: _addIngredient,
                        ),
                    ],
                  ),
                );
              }).toList(),
              SizedBox(height: isSmallScreen ? 12 : 16),

              // Steps
              _buildSectionTitle('Steps'),
              ..._steps.asMap().entries.map((entry) {
                int idx = entry.key;
                return Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12, right: 8),
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: _pinkColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${idx + 1}',
                            style: TextStyle(color: _whiteColor, fontSize: 12),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Describe step ${idx + 1}',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          maxLines: 3,
                          onChanged: (value) => _steps[idx] = value,
                        ),
                      ),
                      if (idx == _steps.length - 1)
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: IconButton(
                            icon: Icon(Icons.add_circle, color: _pinkColor),
                            onPressed: _addStep,
                          ),
                        ),
                    ],
                  ),
                );
              }).toList(),
              SizedBox(height: isSmallScreen ? 24 : 32),

              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: _submitRecipe,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _pinkColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 30 : 40, 
                      vertical: isSmallScreen ? 12 : 16
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Publish Recipe',
                    style: TextStyle(
                      color: _whiteColor,
                      fontSize: isSmallScreen ? 16 : 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: isSmallScreen ? 16 : 24),
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

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          color: _pinkColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildTimeInput(String label, int value, Function(int) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(label),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove, color: _pinkColor),
                onPressed: () => onChanged(value > 1 ? value - 1 : 1),
              ),
              Expanded(
                child: Text(
                  '$value',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add, color: _pinkColor),
                onPressed: () => onChanged(value + 1),
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
    Function(dynamic) onChanged
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
        DropdownButtonFormField(
          value: value,
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: _pinkColor),
            ),
          ),
        ),
      ],
    );
  }
}
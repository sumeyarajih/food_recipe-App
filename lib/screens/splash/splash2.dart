import 'package:flutter/material.dart';
import 'package:food_recipe/screens/auth/welcome_screen.dart';

class Splash2 extends StatefulWidget {
  const Splash2({super.key});

  @override
  State<Splash2> createState() => _Splash2State();
}

class _Splash2State extends State<Splash2> {
  final Color _pinkColor = const Color(0xFFEC407A);
  final Color _bgColor = const Color.fromARGB(255, 247, 230, 235);
  bool _showButton = false;

  @override
  void initState() {
    super.initState();

    // Show button after 1.5 seconds
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _showButton = true;
        });
      }
    });
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenHeight < 600;

    return Scaffold(
      backgroundColor: _bgColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App logo - natural image without tint or background
                Container(
                  height: isSmallScreen ? screenHeight * 0.2 : 150,
                  width: isSmallScreen ? screenHeight * 0.2 : 150,
                  margin: EdgeInsets.only(bottom: screenHeight * 0.04),
                  child: Image.asset(
                    'assets/images/food_logo.png',
                    fit: BoxFit.contain,
                  ),
                ),

                // App name
                Text(
                  'Tasty Bites',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 28 : 32,
                    fontWeight: FontWeight.bold,
                    color: _pinkColor,
                    shadows: [
                      Shadow(
                        blurRadius: 8,
                        color: _pinkColor.withOpacity(0.3),
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: isSmallScreen ? 10 : 15),

                // Tagline
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 20.0 : 40.0,
                  ),
                  child: Text(
                    'Discover Amazing Recipes',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 16 : 18,
                      color: Colors.grey[700],
                    ),
                  ),
                ),

                SizedBox(height: isSmallScreen ? 30 : 40),

                // Continue button or loader
                if (_showButton)
                  SizedBox(
                    width: isSmallScreen ? screenHeight * 0.25 : 200,
                    child: ElevatedButton(
                      onPressed: _navigateToHome,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _pinkColor,
                        padding: EdgeInsets.symmetric(
                          vertical: isSmallScreen ? 12 : 15,
                          horizontal: isSmallScreen ? 20 : 30,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 3,
                      ),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 16 : 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                else
                  SizedBox(
                    width: isSmallScreen ? 40 : 50,
                    height: isSmallScreen ? 40 : 50,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(_pinkColor),
                      strokeWidth: 3,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

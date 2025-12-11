import 'package:flutter/material.dart';
import 'package:food_recipe/screens/auth/welcome_screen.dart';

class Splash2 extends StatefulWidget {
  const Splash2({super.key});

  @override
  State<Splash2> createState() => _Splash2State();
}

class _Splash2State extends State<Splash2> {
  final Color _pinkColor = const Color(0xFFEC407A);
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
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const WelcomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenHeight < 600;

    return Scaffold(
      backgroundColor: _pinkColor, // Pink background to match end of Splash1
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App logo 
                Container(
                  height: isSmallScreen ? screenHeight * 0.2 : 150,
                  width: isSmallScreen ? screenHeight * 0.2 : 150,
                  margin: EdgeInsets.only(bottom: screenHeight * 0.04),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Image.asset(
                    'assets/images/food_logo.png',
                    fit: BoxFit.contain,
                  ),
                ),

                // App name
                Text(
                  'Tasty Bites',
                  style: TextStyle(
                    fontFamily: 'PlayfairDisplay',
                    fontSize: isSmallScreen ? 32 : 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // White text on Pink bg
                    letterSpacing: 1.2,
                    shadows: [
                      Shadow(
                        blurRadius: 8,
                        color: Colors.black.withOpacity(0.1),
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
                      color: Colors.white.withOpacity(0.9), // White text
                      fontStyle: FontStyle.italic,
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
                        backgroundColor: Colors.white, // White button
                        foregroundColor: _pinkColor,   // Pink text
                        padding: EdgeInsets.symmetric(
                          vertical: isSmallScreen ? 12 : 15,
                          horizontal: isSmallScreen ? 20 : 30,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 4,
                      ),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 16 : 18,
                          fontWeight: FontWeight.bold,
                          color: _pinkColor,
                        ),
                      ),
                    ),
                  )
                else
                  SizedBox(
                    width: isSmallScreen ? 40 : 50,
                    height: isSmallScreen ? 40 : 50,
                    child: CircularProgressIndicator(
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
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


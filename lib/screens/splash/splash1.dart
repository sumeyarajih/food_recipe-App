import 'package:flutter/material.dart';
import 'package:food_recipe/screens/splash/splash2.dart';

class Splash1 extends StatefulWidget {
  const Splash1({super.key});

  @override
  State<Splash1> createState() => _Splash1State();
}

class _Splash1State extends State<Splash1> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _letterAnimations;
  final String _appName = "Tasty Bites";
  final Color _pinkColor = const Color(0xFFEC407A);
  final Color _bgColor = Colors.white;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _letterAnimations = List.generate(
      _appName.length,
      (index) => Tween<double>(begin: -50.0, end: 0.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            0.1 * index,
            0.1 * index + 0.5,
            curve: Curves.elasticOut,
          ),
        ),
      ),
    );

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const Splash2()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenHeight < 600;

    return Scaffold(
      backgroundColor: _bgColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated letters - responsive sizing
                SizedBox(
                  height: screenHeight * 0.2,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _appName.length,
                        (index) => AnimatedBuilder(
                          animation: _letterAnimations[index],
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(0, _letterAnimations[index].value),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.01,
                                ),
                                child: Text(
                                  _appName[index],
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 32 : 42,
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
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: screenHeight * 0.05),
                
                // Responsive loading indicator
                SizedBox(
                  width: isSmallScreen ? 40 : 50,
                  height: isSmallScreen ? 40 : 50,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(_pinkColor),
                    strokeWidth: 3,
                  ),
                ),
                
                SizedBox(height: screenHeight * 0.03),
                
                // Responsive subtitle
                AnimatedOpacity(
                  opacity: _controller.isCompleted ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1,
                    ),
                    child: Text(
                      'Discover Delicious Recipes',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 16 : 18,
                        color: _pinkColor.withOpacity(0.8),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
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
import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:food_recipe/screens/splash/splash2.dart';

class Splash1 extends StatefulWidget {
  const Splash1({super.key});

  @override
  State<Splash1> createState() => _Splash1State();
}

class _Splash1State extends State<Splash1> with SingleTickerProviderStateMixin {
  // Animation state
  late AnimationController _revealController;
  
  // Typewriter state
  String _displayedText = "";
  final String _fullText = "Tasty Bites";
  int _currentIndex = 0;
  Timer? _typewriterTimer;

  // Colors
  final Color _pinkColor = const Color(0xFFEC407A);

  @override
  void initState() {
    super.initState();

    // Initialize circular reveal controller
    _revealController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), 
    );

    // Prepare radius animation (will be initialized properly in build with screen size, 
    // but we can set up the listener structure here or defer start)
    
    // Sequence: 
    // 1. Start Typewriter immediately
    // 2. Once typing finishes, Start Reveal
    // 3. Navigate
    
    _startTypewriter();
  }

  void _startTypewriter() {
    // Slight initial delay
    Future.delayed(const Duration(milliseconds: 200), () {
      _typewriterTimer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
        if (_currentIndex < _fullText.length) {
          if (mounted) {
            setState(() {
              _displayedText += _fullText[_currentIndex];
              _currentIndex++;
            });
          }
        } else {
          timer.cancel();
          // Text finished, waiting a beat then starting reveal
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              _revealController.forward().then((_) {
                 // Animation done, navigate
                 _navigateToNext();
              });
            }
          });
        }
      });
    });
  }

  void _navigateToNext() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const Splash2(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  @override
  void dispose() {
    _typewriterTimer?.cancel();
    _revealController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // Calculate max radius to cover the screen from center
    final double maxRadius = math.sqrt(math.pow(screenSize.width, 2) + math.pow(screenSize.height, 2));

    return Scaffold(
      body: Stack(
        children: [
          // Layer 1: Base State (White Background, Pink Text)
          Container(
            color: Colors.white,
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: _buildTypewriterText(color: _pinkColor),
            ),
          ),

          // Layer 2: Reveal State (Pink Background, White Text)
          // Clipped by the expanding circle
          AnimatedBuilder(
            animation: _revealController,
            builder: (context, child) {
              return ClipPath(
                clipper: CircleRevealClipper(
                  radius: _revealController.value * maxRadius,
                ),
                child: Container(
                  color: _pinkColor,
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                    child: _buildTypewriterText(color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTypewriterText({required Color color}) {
    return Text(
      _displayedText,
      key: ValueKey<String>(_displayedText), // Helps consistency
      style: TextStyle(
        fontFamily: 'PlayfairDisplay', 
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: color,
        letterSpacing: 1.2,
      ),
    );
  }
}

class CircleRevealClipper extends CustomClipper<Path> {
  final double radius;

  CircleRevealClipper({required this.radius});

  @override
  Path getClip(Size size) {
    if (radius <= 0) return Path(); // Nothing revealed yet
    
    final Path path = Path();
    path.addOval(Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: radius,
    ));
    return path;
  }

  @override
  bool shouldReclip(CircleRevealClipper oldClipper) {
    return oldClipper.radius != radius;
  }
}

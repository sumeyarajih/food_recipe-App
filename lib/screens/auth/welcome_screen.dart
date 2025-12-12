import 'package:flutter/material.dart';
import 'package:food_recipe/screens/auth/signin.dart';
import 'package:food_recipe/screens/auth/signup.dart';
import 'package:food_recipe/screens/widget/background_decoration.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _navigateToLogin() {
    _pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _navigateToSignup() {
    _pageController.animateToPage(
      2,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Static Background - stays put!
          const BackgroundDecoration(),

          // 2. Sliding Content
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(), // Prevent manual swiping if desired
            children: [
              // Page 0: Welcome
              WelcomeContent(
                onStart: _navigateToLogin,
                onSignIn: _navigateToLogin,
                onCreateAccount: _navigateToSignup,
              ),

              // Page 1: Login
              LoginContent(
                onToggleSignUp: _navigateToSignup,
              ),

              // Page 2: Signup
              SignupContent(
                onToggleSignIn: _navigateToLogin,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WelcomeContent extends StatelessWidget {
  final VoidCallback onStart;
  final VoidCallback onSignIn;
  final VoidCallback onCreateAccount;

  const WelcomeContent({
    super.key,
    required this.onStart,
    required this.onSignIn,
    required this.onCreateAccount,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 450,
          ),
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.95),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFE6398C).withOpacity(0.2),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logo
              Image.asset(
                'assets/images/food_logo.png',
                height: 150, // Increased size
              ),
              const SizedBox(height: 40),

              // Welcome back text
              const Column(
                children: [
                  Text(
                    'Welcome ',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFE6398C),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Sign in to continue exploring and discovering recipes.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Let's Start Button
              ElevatedButton(
                onPressed: onStart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE6398C),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 8,
                  shadowColor: const Color(0xFFE6398C).withOpacity(0.4),
                ),
                child: const Text(
                  "Let's Start",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Sign in Button (Secondary)
              OutlinedButton(
                onPressed: onSignIn,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFE6398C), width: 2),
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Sign in',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFE6398C),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Divider with "or"
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey[400],
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'or',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey[400],
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Create Account Section
              const Text(
                "Don't have an account?",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 15),

              // Create Account Button
              ElevatedButton(
                onPressed: onCreateAccount,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE6398C),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                  shadowColor: const Color(0xFFFF85A2).withOpacity(0.3),
                ),
                child: const Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

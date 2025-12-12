import 'package:flutter/material.dart';
import 'package:food_recipe/screens/widget/background_decoration.dart';

class ForgetPasswordContent extends StatelessWidget {
  final VoidCallback onSendOtp;

  const ForgetPasswordContent({
    super.key,
    required this.onSendOtp,
  });

  void _navigateToSignIn(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background decoration
          const BackgroundDecoration(),

          // Content
          Center(
            child: SingleChildScrollView(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 450),
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
                      height: 150,
                    ),
                    const SizedBox(height: 20),

                    // Forgot Password text
                    const Column(
                      children: [
                        Text(
                          'Forgot Password',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFE6398C),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Enter your email and we’ll send you a verification code.',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Helpful description text
                    const Text(
                      'Please enter the email address associated with your account. '
                      'You will receive an OTP code to reset your password.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),

                    // Email field
                    const TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Color(0xFF555555)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Color(0xFFE6398C)),
                        ),
                        prefixIcon: Icon(Icons.email, color: Color(0xFFE6398C)),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Send button
                    ElevatedButton(
                      onPressed: onSendOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE6398C),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                        shadowColor:
                            const Color(0xFFE6398C).withOpacity(0.3),
                      ),
                      child: const Text(
                        'Send OTP',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Sign in link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Remember your password? ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        GestureDetector(
                          onTap: () => _navigateToSignIn(context),
                          child: const Text(
                            'Sign in',
                            style: TextStyle(
                              color: Color(0xFFE6398C),
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
          ),
        ],
      ),
    );
  }
}

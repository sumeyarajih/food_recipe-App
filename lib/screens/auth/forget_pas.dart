import 'package:flutter/material.dart';

class ForgetPasswordContent extends StatelessWidget {
  final VoidCallback onSendOtp;
  final VoidCallback onSignIn;

  const ForgetPasswordContent({super.key, required this.onSendOtp, required this.onSignIn});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
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
                      'Learn spam asks at email, contactbar',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                
                // Lorem ipsum text
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                  'Maecenas ipsum dolor sit amet, consectetur adipiscing.',
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
                    shadowColor: const Color(0xFFE6398C).withOpacity(0.3),
                  ),
                  child: const Text(
                    'Send',
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
                      "Have an account? ",
                      style: TextStyle(color: Colors.grey),
                    ),
                    GestureDetector(
                      onTap: onSignIn,
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
    );
  }
}
import 'package:flutter/material.dart';

class BackgroundDecoration extends StatelessWidget {
  const BackgroundDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Pink background
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFF9D6E4),
                Color(0xFFF5C2D8),
                Color(0xFFF0AECB),
              ],
            ),
          ),
        ),
        
        // Floating white circles
        Positioned(
          top: MediaQuery.of(context).size.height * 0.1,
          left: MediaQuery.of(context).size.width * 0.05,
          child: _buildCircle(80, 0),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.6,
          right: MediaQuery.of(context).size.width * 0.08,
          child: _buildCircle(120, 1),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.15,
          left: MediaQuery.of(context).size.width * 0.15,
          child: _buildCircle(60, 2),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.2,
          right: MediaQuery.of(context).size.width * 0.15,
          child: _buildCircle(100, 3),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.25,
          right: MediaQuery.of(context).size.width * 0.2,
          child: _buildCircle(70, 4),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.7,
          left: MediaQuery.of(context).size.width * 0.1,
          child: _buildCircle(90, 5),
        ),
      ],
    );
  }

  Widget _buildCircle(double size, int index) {
    return AnimatedContainer(
      duration: Duration(seconds: 15 + index),
      curve: Curves.easeInOut,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        shape: BoxShape.circle,
      ),
    );
  }
}
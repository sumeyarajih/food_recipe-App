import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final int rating;
  final int reviewCount;
  final String chefName;
  final bool isBookmarked;
  final String imageUrl;

  const RecipeCard({
    super.key,
    required this.title,
    required this.description,
    required this.time,
    required this.rating,
    required this.reviewCount,
    required this.chefName,
    this.isBookmarked = false,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFfa8b9a).withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recipe Image with Bookmark
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  imageUrl,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: isBookmarked ? const Color(0xFFfa8b9a) : Colors.white,
                  size: 28,
                ),
              ),
              Positioned(
                bottom: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    time,
                    style: const TextStyle(
                      color: Color(0xFFfa8b9a),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          // Recipe Details
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Rating Row
                Row(
                  children: [
                    ...List.generate(5, (index) => Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: const Color(0xFFfa8b9a),
                      size: 16,
                    )),
                    const SizedBox(width: 4),
                    Text(
                      '($reviewCount)',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                
                // Title
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                
                // Description
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                
                // Chef Row
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFfa8b9a),
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 12,
                        color: Color(0xFFfa8b9a),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      chefName,
                      style: const TextStyle(
                        color: Color(0xFFfa8b9a),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Example usage:
// RecipeCard(
//   imageUrl: 'https://example.com/pancakes.jpg',
//   title: 'Strawberry Pancakes',
//   description: 'Fluffy pancakes topped with fresh strawberries and maple syrup',
//   time: '25 min',
//   rating: 5,
//   reviewCount: 128,
//   chefName: 'Chef Maria',
//   isBookmarked: false,
// )
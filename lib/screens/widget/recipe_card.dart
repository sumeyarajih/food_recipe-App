import 'package:flutter/material.dart';
import 'package:food_recipe/screens/recipe/recipe_details.dart';

class RecipeCard extends StatefulWidget {
  final String title;
  final String description;
  final String time;
  final double rating;
  final int reviewCount;
  final String chefName;
  final bool isBookmarked;
  final String imageUrl;
  final VoidCallback? onLike;
  final VoidCallback? onViewRecipe;

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
    this.onLike,
    this.onViewRecipe,
  });

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  bool _isLiked = false;
  bool _showLikeAnimation = false;

  void _handleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _showLikeAnimation = _isLiked;
    });
    
    if (_showLikeAnimation) {
      Future.delayed(const Duration(milliseconds: 800), () {
        if (mounted) {
          setState(() {
            _showLikeAnimation = false;
          });
        }
      });
    }
    
    widget.onLike?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFEC407A).withOpacity(0.1),
            blurRadius: 12,
            spreadRadius: 2,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  widget.imageUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 180,
                    color: Colors.grey[200],
                    child: const Icon(Icons.fastfood, size: 50, color: Colors.grey),
                  ),
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
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    widget.time,
                    style: const TextStyle(
                      color: Color(0xFFEC407A),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ...List.generate(5, (index) => Icon(
                      index < widget.rating ? Icons.star : Icons.star_border,
                      color: const Color(0xFFEC407A),
                      size: 16,
                    )),
                    const SizedBox(width: 4),
                    Text(
                      '(${widget.reviewCount})',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: _handleLike,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_showLikeAnimation)
                              const Icon(
                                Icons.favorite,
                                color: Color(0xFFEC407A),
                                size: 24,
                              ),
                            Icon(
                              _isLiked ? Icons.favorite : Icons.favorite_border,
                              color: _isLiked ? const Color(0xFFEC407A) : Colors.black87,
                              size: 24,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.description,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFEC407A),
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 12,
                        color: Color(0xFFEC407A),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.chefName,
                      style: const TextStyle(
                        color: Color(0xFFEC407A),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeDetailPage(
                              recipeName: widget.title,
                              chefName: widget.chefName,
                              rating: widget.rating.toDouble(),
                              commentCount: widget.reviewCount,
                              preparationTime: int.tryParse(widget.time.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0,
                              difficulty: 'Medium', // You might want to add this to your RecipeCard parameters
                              servings: 4, // You might want to add this to your RecipeCard parameters
                              likeCount: 0, // You might want to add this to your RecipeCard parameters
                              isShared: false, imageUrl: '', // You might want to add this to your RecipeCard parameters
                            ),
                          ),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(const Color(0xFFEC407A)),
                        foregroundColor: WidgetStateProperty.all(Colors.white),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        elevation: WidgetStateProperty.all(2),
                      ),
                      child: const Text(
                        'View Recipe',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
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
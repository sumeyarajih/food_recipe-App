enum RecipeCategory { all, breakfast, lunch, dinner, desserts }

class Recipe {
  final String title;
  final String description;
  final String time;
  final double rating;
  final int reviewCount;
  final String chefName;
  final bool isBookmarked;
  final String imageUrl;
  final RecipeCategory category;

  Recipe({
    required this.title,
    required this.description,
    required this.time,
    required this.rating,
    required this.reviewCount,
    required this.chefName,
    this.isBookmarked = false,
    required this.imageUrl,
    required this.category,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      time: json['time'] ?? '',
      rating: (json['rating'] is int) 
          ? (json['rating'] as int).toDouble() 
          : (json['rating'] ?? 0.0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      chefName: json['chefName'] ?? '',
      isBookmarked: json['isBookmarked'] ?? false,
      imageUrl: json['imageUrl'] ?? '',
      category: RecipeCategory.values.firstWhere(
        (e) => e.toString().split('.').last == json['category'],
        orElse: () => RecipeCategory.all,
      ),
    );
  }
}

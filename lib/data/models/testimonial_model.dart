/// Testimonial Model for Firebase data
class TestimonialModel {
  final String id;
  final String name;
  final String title;
  final String message;
  final String? image;
  final double rating;
  final DateTime createdAt;

  TestimonialModel({
    required this.id,
    required this.name,
    required this.title,
    required this.message,
    this.image,
    required this.rating,
    required this.createdAt,
  });

  factory TestimonialModel.fromMap(Map<String, dynamic> map, String id) {
    return TestimonialModel(
      id: id,
      name: map['name'] ?? '',
      title: map['title'] ?? '',
      message: map['message'] ?? '',
      image: map['image'],
      rating: (map['rating'] ?? 5.0).toDouble(),
      createdAt: map['createdAt']?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'title': title,
      'message': message,
      'image': image,
      'rating': rating,
      'createdAt': createdAt,
    };
  }
}

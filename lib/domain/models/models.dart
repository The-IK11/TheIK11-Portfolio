/// Models for Firebase data
class ProjectModel {
  final String id;
  final String title;
  final String description;
  final String? image;
  final String? githubUrl;
  final String? playstoreUrl;
  final String? websiteUrl;
  final List<String> technologies;
  final DateTime createdAt;

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    this.image,
    this.githubUrl,
    this.playstoreUrl,
    this.websiteUrl,
    required this.technologies,
    required this.createdAt,
  });

  factory ProjectModel.fromMap(Map<String, dynamic> map, String id) {
    return ProjectModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      image: map['image'],
      githubUrl: map['githubUrl'],
      playstoreUrl: map['playstoreUrl'],
      websiteUrl: map['websiteUrl'],
      technologies: List<String>.from(map['technologies'] ?? []),
      createdAt: map['createdAt']?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'image': image,
      'githubUrl': githubUrl,
      'playstoreUrl': playstoreUrl,
      'websiteUrl': websiteUrl,
      'technologies': technologies,
      'createdAt': createdAt,
    };
  }
}

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

class ContactSubmissionModel {
  final String id;
  final String name;
  final String email;
  final String subject;
  final String message;
  final DateTime createdAt;
  final bool isRead;

  ContactSubmissionModel({
    required this.id,
    required this.name,
    required this.email,
    required this.subject,
    required this.message,
    required this.createdAt,
    this.isRead = false,
  });

  factory ContactSubmissionModel.fromMap(Map<String, dynamic> map, String id) {
    return ContactSubmissionModel(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      subject: map['subject'] ?? '',
      message: map['message'] ?? '',
      createdAt: map['createdAt']?.toDate() ?? DateTime.now(),
      isRead: map['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'subject': subject,
      'message': message,
      'createdAt': createdAt,
      'isRead': isRead,
    };
  }
}

class ExperienceModel {
  final String id;
  final String title;
  final String company;
  final String description;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isCurrent;

  ExperienceModel({
    required this.id,
    required this.title,
    required this.company,
    required this.description,
    required this.startDate,
    this.endDate,
    this.isCurrent = false,
  });

  factory ExperienceModel.fromMap(Map<String, dynamic> map, String id) {
    return ExperienceModel(
      id: id,
      title: map['title'] ?? '',
      company: map['company'] ?? '',
      description: map['description'] ?? '',
      startDate: map['startDate']?.toDate() ?? DateTime.now(),
      endDate: map['endDate']?.toDate(),
      isCurrent: map['isCurrent'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'company': company,
      'description': description,
      'startDate': startDate,
      'endDate': endDate,
      'isCurrent': isCurrent,
    };
  }
}

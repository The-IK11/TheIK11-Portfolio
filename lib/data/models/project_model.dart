/// Project Model for Firebase data
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

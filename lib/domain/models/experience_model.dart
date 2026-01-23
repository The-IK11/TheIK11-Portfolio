/// Experience Model for Firebase data
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

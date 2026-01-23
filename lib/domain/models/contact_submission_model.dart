/// Contact Submission Model for Firebase data
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

class UserInfo {
  final String name;
  final String subTitle;
  final String aboutMe;

  UserInfo({
    required this.name,
    required this.subTitle,
    required this.aboutMe,
  });

  // Convert Firestore data to UserInfo object
  factory UserInfo.fromMap(Map<String, dynamic> data) {
    return UserInfo(
      name: data['name'] ?? '',
      subTitle: data['sub_title'] ?? '',
      aboutMe: data['about_me'] ?? '',
    );
  }

  // Convert UserInfo object to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'sub_title': subTitle,
      'about_me': aboutMe,
    };
  }
}

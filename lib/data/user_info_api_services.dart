import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:theik11_portfolio/domain/models/user_info_model.dart';

class UserInfoApiServices {

  // Singleton
  UserInfoApiServices.instance();

  

final String userInfoDocId= 'eWnhMz4MBWVXBo2Rm4zO';

  
Future<UserInfo> fetchUserInfo() async {
  final doc = await FirebaseFirestore.instance
      .collection('user info')
      .doc(userInfoDocId)
      .get();

  if (doc.exists) {
    return UserInfo.fromMap(doc.data()!);
  } else {
    throw Exception('User info not found');
  }
}

  // Additional methods for interacting with Firebase can be added here

}
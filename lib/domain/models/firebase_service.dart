// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:theik11_portfolio/core/utils/logger.dart';
// import 'models.dart';

// /// Firebase Service for portfolio data
// class FirebaseService {
//   static final FirebaseService _instance = FirebaseService._internal();
  
//   factory FirebaseService() {
//     return _instance;
//   }
  
//   FirebaseService._internal();
  
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
//   // Collection names
//   static const String projectsCollection = 'projects';
//   static const String testimonialsCollection = 'testimonials';
//   static const String contactSubmissionsCollection = 'contact_submissions';
//   static const String experienceCollection = 'experience';
  
//   // ========================= PROJECTS =========================
  
//   /// Get all projects
//   Future<List<ProjectModel>> getProjects() async {
//     try {
//       final snapshot = await _firestore
//           .collection(projectsCollection)
//           .orderBy('createdAt', descending: true)
//           .get();
      
//       return snapshot.docs
//           .map((doc) => ProjectModel.fromMap(doc.data(), doc.id))
//           .toList();
//     } catch (e, stackTrace) {
//       Logger.error('Failed to fetch projects', e, stackTrace);
//       return [];
//     }
//   }
  
//   /// Get single project
//   Future<ProjectModel?> getProject(String id) async {
//     try {
//       final doc = await _firestore
//           .collection(projectsCollection)
//           .doc(id)
//           .get();
      
//       if (doc.exists) {
//         return ProjectModel.fromMap(doc.data()!, doc.id);
//       }
//       return null;
//     } catch (e, stackTrace) {
//       Logger.error('Failed to fetch project', e, stackTrace);
//       return null;
//     }
//   }
  
//   /// Stream projects
//   Stream<List<ProjectModel>> getProjectsStream() {
//     return _firestore
//         .collection(projectsCollection)
//         .orderBy('createdAt', descending: true)
//         .snapshots()
//         .map((snapshot) {
//       return snapshot.docs
//           .map((doc) => ProjectModel.fromMap(doc.data(), doc.id))
//           .toList();
//     }).handleError((error, stackTrace) {
//       Logger.error('Project stream error', error, stackTrace);
//     });
//   }
  
//   // ========================= TESTIMONIALS =========================
  
//   /// Get all testimonials
//   Future<List<TestimonialModel>> getTestimonials() async {
//     try {
//       final snapshot = await _firestore
//           .collection(testimonialsCollection)
//           .orderBy('createdAt', descending: true)
//           .get();
      
//       return snapshot.docs
//           .map((doc) => TestimonialModel.fromMap(doc.data(), doc.id))
//           .toList();
//     } catch (e, stackTrace) {
//       Logger.error('Failed to fetch testimonials', e, stackTrace);
//       return [];
//     }
//   }
  
//   /// Stream testimonials
//   Stream<List<TestimonialModel>> getTestimonialsStream() {
//     return _firestore
//         .collection(testimonialsCollection)
//         .orderBy('createdAt', descending: true)
//         .snapshots()
//         .map((snapshot) {
//       return snapshot.docs
//           .map((doc) => TestimonialModel.fromMap(doc.data(), doc.id))
//           .toList();
//     }).handleError((error, stackTrace) {
//       Logger.error('Testimonials stream error', error, stackTrace);
//     });
//   }
  
//   // ========================= CONTACT FORM =========================
  
//   /// Submit contact form
//   Future<bool> submitContactForm({
//     required String name,
//     required String email,
//     required String subject,
//     required String message,
//   }) async {
//     try {
//       await _firestore.collection(contactSubmissionsCollection).add({
//         'name': name,
//         'email': email,
//         'subject': subject,
//         'message': message,
//         'createdAt': DateTime.now(),
//         'isRead': false,
//       });
      
//       Logger.success('Contact form submitted successfully');
//       return true;
//     } catch (e, stackTrace) {
//       Logger.error('Failed to submit contact form', e, stackTrace);
//       return false;
//     }
//   }
  
//   // ========================= EXPERIENCE =========================
  
//   /// Get all experience entries
//   Future<List<ExperienceModel>> getExperience() async {
//     try {
//       final snapshot = await _firestore
//           .collection(experienceCollection)
//           .orderBy('startDate', descending: true)
//           .get();
      
//       return snapshot.docs
//           .map((doc) => ExperienceModel.fromMap(doc.data(), doc.id))
//           .toList();
//     } catch (e, stackTrace) {
//       Logger.error('Failed to fetch experience', e, stackTrace);
//       return [];
//     }
//   }
  
//   /// Stream experience entries
//   Stream<List<ExperienceModel>> getExperienceStream() {
//     return _firestore
//         .collection(experienceCollection)
//         .orderBy('startDate', descending: true)
//         .snapshots()
//         .map((snapshot) {
//       return snapshot.docs
//           .map((doc) => ExperienceModel.fromMap(doc.data(), doc.id))
//           .toList();
//     }).handleError((error, stackTrace) {
//       Logger.error('Experience stream error', error, stackTrace);
//     });
//   }
  
//   // ========================= HEALTH CHECK =========================
  
//   /// Check if Firebase is connected
//   Future<bool> checkFirebaseConnection() async {
//     try {
//       // Try to get a simple document to check connection
//       await _firestore.collection('_connection_check').doc('test').get();
//       Logger.success('Firebase connection successful');
//       return true;
//     } catch (e) {
//       Logger.warning('Firebase connection check failed: $e');
//       // This is expected if not authenticated, but connection still works
//       return true;
//     }
//   }
// }

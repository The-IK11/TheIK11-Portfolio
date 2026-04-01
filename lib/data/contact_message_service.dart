import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ContactMessageService {
  // Singleton
  static final ContactMessageService _instance = ContactMessageService._internal();

  factory ContactMessageService() {
    return _instance;
  }

  ContactMessageService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collectionName = 'contactMessages';

  /// Submit a contact message to Firebase
  /// Returns the document ID of the created message
  Future<String> submitContactMessage({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    try {
      // Validate inputs
      if (name.isEmpty || email.isEmpty || subject.isEmpty || message.isEmpty) {
        throw Exception('All fields are required');
      }

      // Create message document
      final docRef = await _firestore.collection(_collectionName).add({
        'name': name.trim(),
        'email': email.trim(),
        'subject': subject.trim(),
        'message': message.trim(),
        'timestamp': FieldValue.serverTimestamp(),
      });

      debugPrint('Contact message submitted successfully with ID: ${docRef.id}');
      return docRef.id;
    } on FirebaseException catch (e) {
      debugPrint('Firebase error submitting contact message: $e');
      throw Exception('Failed to send message: ${e.message}');
    } catch (e) {
      debugPrint('Error submitting contact message: $e');
      throw Exception('An error occurred while sending your message');
    }
  }

  /// Fetch all contact messages (admin use)
  Future<List<Map<String, dynamic>>> getAllMessages() async {
    try {
      final snapshot = await _firestore
          .collection(_collectionName)
          .orderBy('timestamp', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => {...doc.data(), 'id': doc.id})
          .toList();
    } catch (e) {
      debugPrint('Error fetching contact messages: $e');
      throw Exception('Failed to fetch messages');
    }
  }

  /// Fetch unread messages count
  Future<int> getUnreadMessagesCount() async {
    try {
      final snapshot = await _firestore
          .collection(_collectionName)
          .where('isRead', isEqualTo: false)
          .count()
          .get();

      return snapshot.count ?? 0;
    } catch (e) {
      debugPrint('Error fetching unread count: $e');
      return 0;
    }
  }

  /// Mark a message as read
  Future<void> markMessageAsRead(String messageId) async {
    try {
      await _firestore
          .collection(_collectionName)
          .doc(messageId)
          .update({
        'isRead': true,
        'status': 'read',
      });
    } catch (e) {
      debugPrint('Error marking message as read: $e');
      throw Exception('Failed to update message status');
    }
  }

  /// Delete a message
  Future<void> deleteMessage(String messageId) async {
    try {
      await _firestore.collection(_collectionName).doc(messageId).delete();
      debugPrint('Message deleted successfully: $messageId');
    } catch (e) {
      debugPrint('Error deleting message: $e');
      throw Exception('Failed to delete message');
    }
  }

  /// Update message status
  Future<void> updateMessageStatus(String messageId, String status) async {
    try {
      if (!['new', 'read', 'responded'].contains(status)) {
        throw Exception('Invalid status');
      }

      await _firestore
          .collection(_collectionName)
          .doc(messageId)
          .update({'status': status});
    } catch (e) {
      debugPrint('Error updating message status: $e');
      throw Exception('Failed to update message status');
    }
  }

  /// Stream of new messages (real-time updates)
  Stream<QuerySnapshot> getMessagesStream() {
    return _firestore
        .collection(_collectionName)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  /// Stream of unread messages
  Stream<QuerySnapshot> getUnreadMessagesStream() {
    return _firestore
        .collection(_collectionName)
        .where('isRead', isEqualTo: false)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}

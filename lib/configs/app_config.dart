/// App configuration constants
class AppConfig {
  // Firebase Configuration
  // Note: Set your Firebase configuration values here
  // These are empty and need to be configured with your Firebase project
  static const String firebaseProjectId = 'your-firebase-project-id';
  static const String firebaseWebApiKey = 'your-web-api-key';
  static const String firebaseAppId = 'your-app-id';
  static const String firebaseMessagingSenderId = 'your-messaging-sender-id';
  
  // App URLs
  static const String baseUrl = 'https://api.example.com';
  
  // Feature Flags
  static const bool enableFirebase = true;
  static const bool enableAnalytics = true;
  
  // API Endpoints
  static const String projectsEndpoint = '/api/projects';
  static const String testimonialsEndpoint = '/api/testimonials';
  static const String contactEndpoint = '/api/contact';
}

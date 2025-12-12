/// Example data for local testing without Firebase
class ExampleData {
  static const List<Map<String, dynamic>> projects = [
    {
      'title': 'E-Commerce Mobile App',
      'description':
          'Full-featured e-commerce application with payment integration and real-time inventory management built with Flutter and Firebase.',
      'image': 'assets/images/ecommerce.png',
      'technologies': ['Flutter', 'Firebase', 'Payment Gateway', 'REST API'],
      'github': 'https://github.com/theik11/ecommerce-app',
      'playstore': 'https://play.google.com/store/apps/details?id=com.example.ecommerce',
    },
    {
      'title': 'Social Media Chat App',
      'description':
          'Real-time messaging app with user authentication, media sharing, and notification system using Flutter and Firebase Realtime Database.',
      'image': 'assets/images/chat.png',
      'technologies': ['Flutter', 'Firebase', 'Real-time DB', 'WebSocket'],
      'github': 'https://github.com/theik11/chat-app',
      'playstore': 'https://play.google.com/store/apps/details?id=com.example.chat',
    },
  ];

  static const List<Map<String, dynamic>> testimonials = [
    {
      'name': 'John Smith',
      'title': 'CEO at TechCorp',
      'message':
          'Ibrahim delivered an exceptional mobile app that exceeded all our expectations. His attention to detail and professional approach made the entire project seamless.',
      'rating': 5.0,
    },
    {
      'name': 'Sarah Johnson',
      'title': 'Product Manager at StartUp Hub',
      'message':
          'Working with Ibrahim was a pleasure. The app quality was outstanding, delivered on time, and he was very responsive to feedback. Highly recommended!',
      'rating': 5.0,
    },
    {
      'name': 'Alex Chen',
      'title': 'Founder at Digital Studio',
      'message':
          'One of the best Flutter developers I\'ve collaborated with. Clean code, great UI sense, and excellent problem-solving skills. Will definitely work together again!',
      'rating': 5.0,
    },
  ];

  static const List<Map<String, dynamic>> experience = [
    {
      'title': 'Senior Flutter Developer',
      'company': 'Tech Innovations Inc.',
      'duration': 'Jan 2023 - Present',
      'description':
          'Lead mobile app development, mentor junior developers, architected scalable app solutions, improved app performance by 40%.',
    },
    {
      'title': 'Flutter Developer',
      'company': 'Digital Solutions Ltd.',
      'duration': 'Jun 2021 - Dec 2022',
      'description':
          'Developed and maintained 10+ production apps, integrated multiple payment gateways and APIs, implemented state management patterns.',
    },
    {
      'title': 'Junior Flutter Developer',
      'company': 'StartUp Studio',
      'duration': 'Jan 2021 - May 2021',
      'description':
          'Built mobile applications from scratch, learned Flutter best practices, collaborated with designers and backend teams.',
    },
  ];
}

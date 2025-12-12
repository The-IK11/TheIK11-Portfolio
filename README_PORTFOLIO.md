# The IK11 Portfolio - Flutter Web

A modern, responsive, and animated portfolio website built with Flutter Web for MD. Ibrahim Khalil (The IK11).

## ✨ Features

- 🎨 **Modern Design**: Clean, elegant dark theme with smooth animations
- 📱 **Fully Responsive**: Works seamlessly on desktop, tablet, and mobile devices
- ✨ **Smooth Animations**: Fade, slide, and scale animations throughout
- 🎯 **Custom Cursor**: Animated cursor effect on desktop
- 📊 **Multiple Sections**:
  - Hero/Home Section with typing animation
  - About Section with profile info
  - Skills Section with skill badges
  - Experience Section with timeline
  - Projects Section with project cards
  - Services Section showcasing services
  - Testimonials Section with reviews
  - Contact Section with form and social links
- 🔥 **Firebase Integration**: 
  - Firestore for projects, testimonials, and contact submissions
  - Real-time data updates
- 🚀 **Performance Optimized**: Fast loading, smooth scrolling, lazy loading
- 📧 **Contact Form**: Send messages directly to Firebase
- 🎯 **Navigation**: Smooth scroll-to-section navigation

## 🛠️ Tech Stack

- **Framework**: Flutter 3.x
- **Language**: Dart
- **Backend**: Firebase Firestore
- **State Management**: Provider, RxDart (ready to integrate)
- **UI**: Material Design 3
- **Animations**: Custom animations with AnimationController

## 📦 Dependencies

```yaml
firebase_core: ^2.24.0
cloud_firestore: ^4.13.0
provider: ^6.0.0
rxdart: ^0.27.7
flutter_animate: ^4.1.0
url_launcher: ^6.2.0
font_awesome_flutter: ^10.7.0
```

## 🚀 Getting Started

### Prerequisites

- Flutter 3.0 or higher
- Dart 3.0 or higher
- Firebase project (for backend integration)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/theik11/theik11_portfolio.git
   cd theik11_portfolio
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase** (Optional)
   - Create a Firebase project
   - Add your Firebase configuration to `lib/configs/app_config.dart`
   - Enable Firestore database

4. **Run the app**
   ```bash
   flutter run -d chrome
   ```

## 📁 Project Structure

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_constants.dart
│   │   └── app_spacing.dart
│   ├── theme/
│   │   └── app_theme.dart
│   └── utils/
│       ├── responsive.dart
│       ├── extensions.dart
│       └── logger.dart
├── data/
│   ├── firebase_service.dart
│   └── models.dart
├── ui/
│   ├── widgets/
│   │   ├── custom_widgets.dart
│   │   └── navbar.dart
│   ├── sections/
│   │   ├── hero_section.dart
│   │   ├── about_section.dart
│   │   ├── skills_section.dart
│   │   ├── experience_section.dart
│   │   ├── projects_section.dart
│   │   ├── services_section.dart
│   │   ├── testimonials_section.dart
│   │   └── contact_section.dart
│   └── pages/
│       └── home_page.dart
├── configs/
│   └── app_config.dart
└── main.dart
```

## 🎨 Customization

### Colors
Edit `lib/core/theme/app_theme.dart` to customize the color scheme:
- `AppColors.primary` - Main accent color (Purple)
- `AppColors.bgPrimary` - Dark background
- `AppColors.textPrimary` - Main text color

### Spacing
Edit `lib/core/constants/app_spacing.dart` to adjust spacing throughout the app.

### Content
Update content in respective sections:
- `AppConstants` in `lib/core/constants/app_constants.dart`
- Section-specific data in each section file

### Fonts
To add custom fonts:
1. Place font files in `assets/fonts/`
2. Update `pubspec.yaml` with font configuration
3. Apply in theme or specific widgets

## 🔥 Firebase Setup

1. Create a Firestore collection called `projects`:
   ```json
   {
     "title": "Project Name",
     "description": "Project Description",
     "image": "image_url",
     "githubUrl": "https://github.com/...",
     "playstoreUrl": "https://play.google.com/...",
     "technologies": ["Flutter", "Firebase"],
     "createdAt": "2024-01-01"
   }
   ```

2. Create a `testimonials` collection:
   ```json
   {
     "name": "Client Name",
     "title": "Client Title",
     "message": "Testimonial message",
     "image": "image_url",
     "rating": 5.0,
     "createdAt": "2024-01-01"
   }
   ```

3. Create an `experience` collection:
   ```json
   {
     "title": "Job Title",
     "company": "Company Name",
     "description": "Job description",
     "startDate": "2023-01-01",
     "endDate": "2024-01-01",
     "isCurrent": false
   }
   ```

4. Contact form submissions go to `contact_submissions` collection

## 🚀 Deployment

### Netlify (Recommended)

1. **Build for web**
   ```bash
   flutter build web --release
   ```

2. **Deploy to Netlify**
   ```bash
   netlify deploy --prod --dir build/web
   ```

### GitHub Pages

1. **Build for web**
   ```bash
   flutter build web --release --base-href /theik11_portfolio/
   ```

2. **Push to gh-pages branch**
   ```bash
   git subtree push --prefix build/web origin gh-pages
   ```

### Firebase Hosting

1. **Install Firebase CLI**
   ```bash
   npm install -g firebase-tools
   ```

2. **Initialize Firebase**
   ```bash
   firebase init hosting
   ```

3. **Build and deploy**
   ```bash
   flutter build web --release
   firebase deploy
   ```

## 📱 Responsive Breakpoints

- **Mobile**: < 768px
- **Tablet**: 768px - 1200px
- **Desktop**: > 1200px

Use `Responsive` utility class for responsive design:
```dart
if (Responsive.isMobile(context)) {
  // Mobile layout
}
```

## 🎯 Performance Tips

1. Use lazy loading for sections
2. Optimize images with appropriate sizes
3. Cache Firebase data
4. Use `const` constructors where possible
5. Minimize animation complexity for mobile

## 🔗 Social Links

Update social links in `lib/core/constants/app_constants.dart`:
- GitHub
- LinkedIn
- Twitter
- Instagram

## 📄 License

This project is open source and available under the MIT License.

## 👤 Author

**MD. Ibrahim Khalil (The IK11)**
- Portfolio: [theik11.com](https://theik11.com)
- GitHub: [@theik11](https://github.com/theik11)
- LinkedIn: [@theik11](https://linkedin.com/in/theik11)

## 💡 Support

For issues, suggestions, or contributions, please feel free to create an issue or pull request.

---

**Built with ❤️ using Flutter**

# 🎯 Quick Reference Guide

## 🚀 Quick Commands

```bash
# Get dependencies
flutter pub get

# Run development
flutter run -d chrome

# Run release (better performance)
flutter run -d chrome --release

# Build for production
flutter build web --release

# Deploy to Netlify
netlify deploy --prod --dir build/web

# Deploy to Firebase
firebase deploy

# Format code
dart format .

# Analyze code
flutter analyze
```

## 📁 Important Files

| File | Purpose |
|------|---------|
| `lib/main.dart` | App entry point |
| `lib/ui/pages/home_page.dart` | Main page with all sections |
| `lib/core/constants/app_constants.dart` | Personal info, skills, services |
| `lib/core/theme/app_theme.dart` | Colors and theme |
| `lib/data/firebase_service.dart` | Firebase operations |
| `pubspec.yaml` | Dependencies |
| `web/index.html` | Web metadata |

## 🎨 Color Palette

```dart
Primary:     #7C3AED (Purple)
Background:  #0F172A (Very Dark)
Secondary:   #1E293B (Dark)
Accent1:     #06B6D4 (Cyan)
Accent2:     #10B981 (Green)
Accent3:     #F59E0B (Amber)
Accent4:     #F87171 (Red)
```

## 📱 Responsive Breakpoints

```
Mobile:   < 768px
Tablet:   768px - 1200px
Desktop:  > 1200px
```

## 🔄 Update Personal Info

**File**: `lib/core/constants/app_constants.dart`

```dart
// Update these
fullName = 'Your Name'
nickname = 'Your Nickname'
email = 'your@email.com'
phone = '+1 (555) 123-4567'
```

## 🎨 Update Colors

**File**: `lib/core/theme/app_theme.dart`

```dart
// Change primary color
primary = Color(0xFFYOUR_HEX)

// Change background
bgPrimary = Color(0xFFYOUR_HEX)
bgSecondary = Color(0xFFYOUR_HEX)
```

## 📝 Update Content

### Skills
`lib/core/constants/app_constants.dart`
```dart
skills = [
  'Skill 1',
  'Skill 2',
  // Add more
]
```

### Projects
`lib/ui/sections/projects_section.dart`
```dart
final projects = [
  {
    'title': 'Your Project',
    'description': 'Description',
    // ... more fields
  }
];
```

### Testimonials
`lib/ui/sections/testimonials_section.dart`
```dart
final testimonials = [
  {
    'name': 'Client Name',
    'title': 'Client Title',
    'message': 'Testimonial',
    'rating': 5.0,
  }
];
```

### Experience
`lib/ui/sections/experience_section.dart`
```dart
final experiences = [
  {
    'title': 'Job Title',
    'company': 'Company',
    'duration': 'Jan 2023 - Present',
    'description': 'Description',
  }
];
```

## 🔥 Firebase Setup (Quick)

1. Create Firebase project
2. Add web app
3. Create Firestore database
4. Create collections: `projects`, `testimonials`, `experience`
5. Update `lib/configs/app_config.dart`

## 🎯 Key Classes

```dart
Responsive              // Responsive utilities
AppColors              // Color constants
AppTheme               // Theme definition
AppConstants           // App constants
FirebaseService        // Firebase operations
FadeInAnimation        // Fade animation
SlideInAnimation       // Slide animation
AnimatedHoverButton    // Button with hover
SkillChip              // Skill badge
```

## 📊 Sections Overview

| Section | File | Purpose |
|---------|------|---------|
| Hero | `hero_section.dart` | Welcome, CTA |
| About | `about_section.dart` | Bio, quick facts |
| Skills | `skills_section.dart` | Skills list |
| Experience | `experience_section.dart` | Work history |
| Projects | `projects_section.dart` | Portfolio |
| Services | `services_section.dart` | Services |
| Testimonials | `testimonials_section.dart` | Reviews |
| Contact | `contact_section.dart` | Form |

## 🧪 Testing

```bash
# Test on web
flutter run -d chrome

# Test on mobile (if set up)
flutter run

# Build web release
flutter build web --release

# Serve locally (optional)
python -m http.server 8000
# Visit http://localhost:8000/build/web
```

## 📱 Mobile Testing

- Chrome DevTools → Device Toolbar
- Responsive mode: Ctrl+Shift+M (or Cmd+Shift+M)
- Test at: 375px (mobile), 768px (tablet), 1200px (desktop)

## 🎯 Animation Durations

```dart
Short:   const Duration(milliseconds: 300)
Medium:  const Duration(milliseconds: 600)
Long:    const Duration(milliseconds: 800)
Very Long: const Duration(seconds: 1)
```

## 🔗 Social Links

**Update in**: `lib/core/constants/app_constants.dart`

```dart
githubUrl = 'https://github.com/your-username'
linkedinUrl = 'https://linkedin.com/in/your-profile'
twitterUrl = 'https://twitter.com/your-handle'
instagramUrl = 'https://instagram.com/your-handle'
```

## 🚀 Deployment Options

| Platform | Command |
|----------|---------|
| Netlify | `netlify deploy --prod --dir build/web` |
| Firebase | `firebase deploy` |
| GitHub Pages | Push to gh-pages branch |
| Vercel | Connect Git repo |

## 📊 Performance Tips

✅ Use release build
✅ Optimize images
✅ Minimize animations
✅ Cache data
✅ Use const constructors
✅ Lazy load sections

## 🐛 Common Issues

| Issue | Solution |
|-------|----------|
| Cursor not showing | Desktop only, check CustomCursorWidget |
| Animations lag | Use release build, reduce complexity |
| Firebase error | Check config, internet, rules |
| Responsive broken | Test on actual device, check breakpoints |
| Text overflow | Reduce font size, use `maxLines` |

## 📚 Resources

- Flutter: https://flutter.dev
- Firebase: https://firebase.google.com
- Material Design: https://material.io
- Dart: https://dart.dev
- Color Tools: https://material.io/resources/color

## ✅ Pre-Launch Checklist

- [ ] Personal info updated
- [ ] Colors customized
- [ ] Content filled in
- [ ] Firebase set up
- [ ] Tested on 3 devices
- [ ] SEO updated
- [ ] Build successful
- [ ] Deployed
- [ ] Live URL working

---

**That's it! You've got everything you need. Go build! 🚀**

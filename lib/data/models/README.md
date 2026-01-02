# Firebase Models

This folder contains all Firebase data models for the portfolio application.

## Models

### ProjectModel
- **File**: `project_model.dart`
- **Fields**: id, title, description, image, githubUrl, playstoreUrl, websiteUrl, technologies, createdAt
- **Firebase Collection**: `projects`
- **Usage**: Fetching and managing project data from Firebase

### TestimonialModel
- **File**: `testimonial_model.dart`
- **Fields**: id, name, title, message, image, rating, createdAt
- **Firebase Collection**: `testimonials`
- **Usage**: Fetching and managing testimonial/review data from Firebase

### ContactSubmissionModel
- **File**: `contact_submission_model.dart`
- **Fields**: id, name, email, subject, message, createdAt, isRead
- **Firebase Collection**: `contact_submissions`
- **Usage**: Storing and managing contact form submissions

### ExperienceModel
- **File**: `experience_model.dart`
- **Fields**: id, title, company, description, startDate, endDate, isCurrent
- **Firebase Collection**: `experience`
- **Usage**: Fetching and managing work experience data from Firebase

## How to Use

Import all models at once using the barrel file:

```dart
import 'package:theik11_portfolio/data/models/index.dart';

// Now you can use all models
final project = ProjectModel(...);
final experience = ExperienceModel(...);
```

Or import individual models:

```dart
import 'package:theik11_portfolio/data/models/project_model.dart';
```

## Firebase Conversion

Each model includes:
- **`fromMap()`**: Convert Firebase snapshot to Dart object
- **`toMap()`**: Convert Dart object to Firebase format

Example:

```dart
// From Firebase
final projectData = await firestore.collection('projects').doc(id).get();
final project = ProjectModel.fromMap(projectData.data()!, projectData.id);

// To Firebase
await firestore.collection('projects').doc(project.id).set(project.toMap());
```

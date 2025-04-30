# Financial Services Flutter App

A cross-platform mobile application showcasing core financial services flows, built with Flutter and Bloc/Cubit for state management. This README provides a comprehensive guide to the project’s architecture, setup, features, testing, and usage.

---

## 📑 Table of Contents

1. [Overview](#overview)
2. [Architecture & Folder Structure](#architecture--folder-structure)
3. [Features](#features)
4. [Getting Started](#getting-started)
   - [Prerequisites](#prerequisites)
   - [Installation](#installation)
5. [Project Structure](#project-structure)
6. [State Management](#state-management)
7. [Localization & RTL Support](#localization--rtl-support)
8. [Caching & Offline Data](#caching--offline-data)
9. [Testing](#testing)
10. [Screenshots](#screenshots)
11. [Future Enhancements](#future-enhancements)

---

## 🚀 Overview

The Financial Services Flutter App demonstrates a clean, modern user experience across five main screens:

- **Home**: Main navigation with logo and four feature buttons.
- **Contact Us**: Contact form + direct WhatsApp & email intents.
- **Products**: Responsive grid of financial products with details.
- **Submit Complaint**: Form with validation and submission flow.
- **About Company**: Company info + dynamic map based on user location.

The app uses **Bloc/Cubit** for predictable state management, **SharedPreferences** for caching form data, and **url_launcher** & **geolocator** to integrate external intents and location services.

---

## 🏗 Architecture & Folder Structure

```
lib/
├─ constants/               # Enums, styles, static constants
├─ data/                    # Models & repositories (mocked API)
├─ logic/                   # Cubit & state definitions
├─ view/                    # Screens & reusable widgets
└─ utils/                   # Theme, validators, local storage
```

This layered architecture enforces separation of concerns, making the codebase scalable and maintainable.

---

## ✨ Features

- **Bloc/Cubit State Management**: Clear loading, success, and error states.
- **Localization & RTL**: Supports English & Arabic with auto LTR/RTL direction.
- **Contact Integration**: Tap phone → WhatsApp; tap email → default mail app.
- **Products Listing**: Mocked API data with pull-to-refresh and retry on errors.
- **Complaint Submission**: Dropdown for complaint type, animated submit button.
- **Location-Based Map**: Shows user’s current location as “company” and links to Google Maps.
- **Local Caching**: Persists form entries across sessions using SharedPreferences.
- **Custom Animations**: Smooth slide transitions & button state animations.
- **Testing**: Unit tests for Cubits; widget tests for key screens.

---

## 🛠 Getting Started

### Prerequisites

- Flutter SDK (>= 3.0.0)
- An Android/iOS device or emulator
- (Optional) Google Static Maps API key for map images

### Installation

1. **Clone the repo**
   ```bash
   git clone https://github.com/yourusername/finance_flutter_app.git
   cd finance_flutter_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Add assets**
   - Place `logo.png` in `assets/` and declare it in `pubspec.yaml` under `flutter.assets`.

4. **Run the app**
   ```bash
   flutter run
   ```

---

## 🔍 Project Structure

- **constants/**: `enums/`, `styles/`, and `constants.dart` for app-wide values.
- **data/models/**: Plain Dart classes for `Product` and `Complaint`.
- **data/repositories/**: Mocked network calls with `Future.delayed`.
- **logic/cubits/**: Business logic and state classes for products & complaints.
- **view/screens/**: Five main screens, each in its own file.
- **view/widgets/**: Reusable components (buttons, cards, inputs).
- **utils/**: `app_theme.dart`, `validators.dart`, and `local_storage.dart`.

---

## 🧩 State Management

Using **flutter_bloc**, each feature has:

- **Cubit** (e.g. `ProductCubit`) that exposes methods like `loadProducts()`.
- **State** (e.g. `ProductState`) with `status`, data, and error fields.

Tests ensure transitions: `initial → loading → success/error`.

---

## 🌐 Localization & RTL Support

Configured in `MaterialApp`:

```dart
supportedLocales: [Locale('en'), Locale('ar')],
localizationsDelegates: [
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
],
localeResolutionCallback: …
```

This automatically translates system widgets and switches directions.

---

## 💾 Caching & Offline Data

Using `shared_preferences`:

- **Contact form**: last name, phone, message
- **Complaint form**: last inputs & selected type

Data loads on screen open, saving on field change or submit.

---

## ✅ Testing

Run all tests:
```bash
flutter test
```

- **Unit Tests**: `product_cubit_test.dart`, `complaint_cubit_test.dart`
- **Widget Tests**: `home_screen_test.dart`, `contact_us_screen_test.dart`

Tests cover state transitions and UI validation flows.

---

## 📸 Screenshots

<!-- Replace with your actual screenshot paths -->
| Home Screen | Products Screen |
| :---------: | :-------------: |
| ![](screenshots/home.png) | ![](screenshots/products.png) |

| Contact Us | Submit Complaint |
| :--------: | :---------------: |
| ![](screenshots/contact.png) | ![](screenshots/complaint.png) |

| About Company | Map View |
| :-----------: | :--------: |
| ![](screenshots/about.png) | ![](screenshots/map.png) |

---

## 🚀 Future Enhancements

- Authentication & secure API integration
- Real backend instead of mocked data
- Dark mode support
- Expanded localization (e.g. French, Spanish)
- More comprehensive test coverage (integration tests)

---

*Good luck, and happy coding!*


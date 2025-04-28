# Financial Services Flutter App

## Overview
A cross-platform Flutter app showcasing core financial services flows:
- Main navigation
- Contact Us form (with caching)
- Products listing (mocked API)
- Complaint submission (with caching)
- About Company

## Architecture
ib/
├─ constants/  # styles, enums, constants
├─ data/       # models & repositories
├─ logic/      # BLoC (Cubit) state management
├─ view/       # screens & widgets
└─ utils/      # themes, validators, local_storage

## Features
- Bloc/Cubit for state management
- SharedPreferences caching
- Custom slide transitions
- RTL & LTR support
- Form validation
- Unit & widget tests

## Getting Started
1. `git clone ...`
2. `flutter pub get`
3. Add `assets/logo.png`
4. `flutter run`

## Running Tests
flutter test

## Screenshots
![Home](screenshots/home.png)
![Products](screenshots/products.png)

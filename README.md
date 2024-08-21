
# WALLET_GURU

## What is this repository for?

This repository contains a Flutter application developed using Domain-Driven Design (DDD) principles. It provides a modular architecture that supports scalability and maintainability, focusing on clean code practices and a clear separation of concerns.

## Quick summary

This project is a Flutter app organized into distinct layers: Domain, Application, Infrastructure, and Presentation. It uses Bloc/Cubit for state management and follows best practices for a clean architecture.
Version: 1.0.0
Learn Markdown: Markdown guide for formatting documentation.
How do I get set up?
Summary of set up:

Clone the repository and install the necessary dependencies to start working on the project.

## Configuration

Ensure you have Flutter and Dart installed on your machine.
Configure your environment to work with the project, including any necessary API keys or environment variables.
Dependencies:

Run flutter pub get to install the project's dependencies listed in pubspec.yaml.
Database configuration:

This project may not require a local database setup but ensure any external APIs or services used are properly configured.
How to run tests:

Run unit tests and widget tests using the Flutter test framework.
Use flutter test to execute tests.

## Deployment instructions:

To build and deploy the application, follow the Flutter build and deployment instructions specific to your target platform (iOS, Android, etc.).
For example, use flutter build apk for Android and flutter build ios for iOS.
Contribution guidelines
Writing tests:

Ensure new features are covered with appropriate unit and widget tests.
Follow the existing test structure and conventions used in the project.
Code review:

Submit your code changes as a pull request.
Ensure your pull request includes a description of the changes and any relevant issues it addresses.
Code should be reviewed by at least one other team member before merging.
Other guidelines:

Follow the project's coding style guidelines and conventions.
Document any new features or changes in the codebase.
Who do I talk to?
Repo owner or admin: Cristian Dulcey
Other community or team contact: Feel free to open an issue in the repository for any questions or discussions.

if you have problems with this import 
```dart
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
```

run this command in the terminal
```bash
flutter gen-l10n
```
for update envs run this command
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

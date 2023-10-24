# Desk Reservation App

Welcome to the Desk Reservation App project! This application allows users to easily reserve desks in a company, facilitating a smoother workspace experience. Here, you'll find information on setting up and using the app.

## Getting Started

Follow these steps to get the project up and running on your local machine.

### Prerequisites

Before you begin, ensure that you have the following installed on your system:

- [Flutter](https://flutter.dev/docs/get-started/install)
- [Dart](https://dart.dev/get-dart)
- A code editor or IDE of your choice (e.g., Visual Studio Code)
- [Firebase](https://firebase.google.com/) for authentication and other features
- [Heroku](https://www.heroku.com/) for strapi server

### Setting up the Project

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/yourusername/desk-reservation-app.git
   ```

2. Navigate to the project directory:

   ```bash
   cd desk-reservation-app
   ```

3. Install the project dependencies:

   ```bash
   flutter pub get
   ```

4. Configure Firebase for authentication and other services as described below.

### Firebase Configuration

To use Firebase for authentication, please follow these steps:

1. Create a new project in the [Firebase Console](https://console.firebase.google.com/).

2. Add your Flutter app to the Firebase project. You will receive a `google-services.json` file that you should place in the `android/app` directory for Android and a `GoogleService-Info.plist` file that you should place in the `ios/Runner` directory for iOS.

3. Enable Firebase authentication methods (Google, Apple, email/password, etc.) in the Firebase Authentication section of your project.

4. Configure other Firebase services (Realtime Database, Cloud Firestore, etc.) as needed for your app.

### Running the App

You can now run the Flutter app on your device or emulator:

```bash
flutter run
```

## Features

- User-friendly desk reservation system.
- Authentication through Firebase with Google, Apple, and email/password methods.
- Light and Dark mode support.
- Multilingual support (English, Polish, German).
- User role management for admins.
- Filter and search options for workspaces.
- Extensive UI and logic for workspace blocking and filtering.
- Desk and room reservations, cancelation, and searching.
- Integration with Strapi for remote configuration and content.

Happy desk reservation! 🪑📅
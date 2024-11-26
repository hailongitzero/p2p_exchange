# p2p_exchange

# Flutter App

Welcome to the Flutter App! This guide will help you set up and build the project on your local machine.

---

## Prerequisites

Ensure you have the following installed:

1. **Flutter SDK**  
   [Install Flutter SDK](https://flutter.dev/docs/get-started/install)  
   Verify your installation with:

   ```bash
   flutter doctor
   ```

2. **Dart SDK** (Installed with Flutter)

3. **Android Studio** (or another IDE like VS Code)

   - Install the Flutter and Dart plugins.
   - Set up the Android emulator.

4. **Xcode** (For iOS development - macOS only)

5. **Device or Emulator**
   - Android: Use an emulator or a physical device in developer mode.
   - iOS: Use a simulator or a connected device.

---

## Getting Started

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd <repository-folder>
   ```

2. **Install dependencies**  
   Run the following command to fetch all necessary packages:

   ```bash
   flutter pub get
   ```

3. **Configure Environment**
   - Create a `.env` file if environment-specific configurations are required.
   - Add any API keys or configurations as needed.

---

## Running the App

### On Android:

1. Connect an Android device or start an emulator.
2. Run:
   ```bash
   flutter run
   ```

### On iOS:

1. Open the project in Xcode and configure the signing settings for your team.
2. Run:
   ```bash
   flutter run
   ```

---

## Building the App

### Android:

Build an APK:

```bash
flutter build apk
```

Build an App Bundle:

```bash
flutter build appbundle
```

### iOS:

Build the iOS app:

```bash
flutter build ios
```

Make sure to open the project in Xcode to archive and submit it to the App Store.

---

## Troubleshooting

- Run `flutter doctor` to check for any missing dependencies or errors.
- For detailed debugging, use `flutter logs`.

---

## Resources

![Alt text](lib/assets/slide/login.png?raw=true "Login")
<img src='lib/assets/slide/login.png' width=300>

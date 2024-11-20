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

## Database design

users
└── {userId}
├── username: "john_doe"
├── email: "johndoe@example.com"
├── profileImage: "https://example.com/image.jpg"
├── bio: "Tech enthusiast"
├── createdAt: <timestamp>
├── lastLogin: <timestamp>
├── userSettings
│ ├── notificationPreferences: true
│ ├── theme: "dark"
│ └── language: "en"
├── favorites: [productId1, productId2]
├── isAdmin: false
├── location
│ ├── latitude: 37.7749
│ └── longitude: -122.4194
├── address
│ ├── street: "123 Elm Street"
│ ├── city: "San Francisco"
│ ├── state: "CA"
│ └── zipCode: "94102"
└── idNumber: "A1234567890"

categories
└── {categoryId}
├── title: "Electronics"
├── description: "Latest gadgets and devices"
└── image: "https://example.com/electronics.jpg"

products
└── {productId}
├── name: "Smartphone X"
├── description: "A cutting-edge smartphone"
├── price: 999.99
├── categoryId: "categoryId"
├── image: "https://example.com/product-main.jpg" // main image
├── status
├── TinhTrang
├── imageSlides: [
"https://example.com/product-image1.jpg",//thư viện firebase async firebase
"https://example.com/product-image2.jpg",
"https://example.com/product-image3.jpg"
]
├── createdAt: <timestamp>
├── userId: "userId"
├── comments: [commentId1, commentId2]
└── tradeList: [productId2, productId3]

comments
└── {commentId}
├── userId: "userId"
├── productId: "productId"
├── content: "Great product!"
├── createdAt: <timestamp>
└── likes: 12

//them loadmore,
//try catch image
hang moi/ hang cu

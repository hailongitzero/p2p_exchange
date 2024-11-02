// user_model.dart
class UserModel {
  String? id;
  String? username;
  String? email;
  String? profileImage;
  String? bio;
  DateTime? createdAt;
  DateTime? lastLogin;
  bool isAdmin;
  UserSettings userSettings;
  List<String> favorites;
  Location location;
  Address address;
  String? idNumber;

  UserModel({
    this.id,
    this.username,
    this.email,
    this.profileImage,
    this.bio,
    this.createdAt,
    this.lastLogin,
    this.isAdmin = false,
    required this.userSettings,
    required this.favorites,
    required this.location,
    required this.address,
    this.idNumber,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'profileImage': profileImage,
        'bio': bio,
        'createdAt': createdAt?.millisecondsSinceEpoch,
        'lastLogin': lastLogin?.millisecondsSinceEpoch,
        'isAdmin': isAdmin,
        'userSettings': userSettings.toJson(),
        'favorites': favorites,
        'location': location.toJson(),
        'address': address.toJson(),
        'idNumber': idNumber,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        profileImage: json['profileImage'],
        bio: json['bio'],
        createdAt: json['createdAt'] != null
            ? DateTime.fromMillisecondsSinceEpoch(json['createdAt'])
            : null,
        lastLogin: json['lastLogin'] != null
            ? DateTime.fromMillisecondsSinceEpoch(json['lastLogin'])
            : null,
        isAdmin: json['isAdmin'] ?? false,
        userSettings: UserSettings.fromJson(json['userSettings']),
        favorites: List<String>.from(json['favorites'] ?? []),
        location: Location.fromJson(json['location']),
        address: Address.fromJson(json['address']),
        idNumber: json['idNumber'],
      );
}

class UserSettings {
  bool notificationPreferences;
  String theme;
  String language;

  UserSettings({
    this.notificationPreferences = true,
    this.theme = 'light',
    this.language = 'en',
  });

  Map<String, dynamic> toJson() => {
        'notificationPreferences': notificationPreferences,
        'theme': theme,
        'language': language,
      };

  factory UserSettings.fromJson(Map<String, dynamic> json) => UserSettings(
        notificationPreferences: json['notificationPreferences'] ?? true,
        theme: json['theme'] ?? 'light',
        language: json['language'] ?? 'en',
      );
}

class Location {
  double latitude;
  double longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json['latitude'],
        longitude: json['longitude'],
      );
}

class Address {
  String street;
  String city;
  String state;
  String zipCode;

  Address({
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
  });

  Map<String, dynamic> toJson() => {
        'street': street,
        'city': city,
        'state': state,
        'zipCode': zipCode,
      };

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        street: json['street'],
        city: json['city'],
        state: json['state'],
        zipCode: json['zipCode'],
      );
}

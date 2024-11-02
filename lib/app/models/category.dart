import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  String id;
  String title;
  String description;
  String image;

  Category({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
  });

  // Factory constructor to create a Category instance from a DocumentSnapshot
  factory Category.fromDocumentSnapshot(DocumentSnapshot doc) {
    return Category(
      id: doc.id,
      title: doc['title'] ?? '',
      description: doc['description'] ?? '',
      image: doc['image'] ?? '',
    );
  }

  // Factory constructor to create a Category instance from a JSON map
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
    );
  }

  // Method to convert Category instance to JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
    };
  }

  factory Category.fromMap(Map<String, dynamic> data) => Category(
        id: data['id'],
        title: data['title'],
        description: data['description'],
        image: data['image'],
      );

  // Method to convert Category instance to map (for Firestore usage)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'image': image,
    };
  }
}

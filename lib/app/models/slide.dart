import 'package:cloud_firestore/cloud_firestore.dart';

class Slide {
  String id;
  String productId;
  String title;
  String description;
  String image;

  Slide({
    required this.id,
    required this.productId,
    required this.title,
    required this.description,
    required this.image,
  });

  // Factory constructor to create a Category instance from a DocumentSnapshot
  factory Slide.fromDocumentSnapshot(DocumentSnapshot doc) {
    return Slide(
      id: doc.id,
      productId: doc['productId'] ?? '',
      title: doc['title'] ?? '',
      description: doc['description'] ?? '',
      image: doc['image'] ?? '',
    );
  }

  // Factory constructor to create a Category instance from a JSON map
  factory Slide.fromJson(Map<String, dynamic> json) {
    return Slide(
      id: json['id'] ?? '',
      productId: json['productId'] ?? '',
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

  factory Slide.fromMap(Map<String, dynamic> data) => Slide(
        id: data['id'],
        productId: data['productId'],
        title: data['title'],
        description: data['description'],
        image: data['image'],
      );

  // Method to convert Category instance to map (for Firestore usage)
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'title': title,
      'description': description,
      'image': image,
    };
  }
}

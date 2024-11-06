import 'package:cloud_firestore/cloud_firestore.dart';

class ProductCondition {
  String id;
  String meaning;

  ProductCondition({
    required this.id,
    required this.meaning,
  });

  // Factory constructor to create a Category instance from a DocumentSnapshot
  factory ProductCondition.fromDocumentSnapshot(DocumentSnapshot doc) {
    return ProductCondition(
      id: doc.id,
      meaning: doc['meaning'] ?? '',
    );
  }

  // Factory constructor to create a Category instance from a JSON map
  factory ProductCondition.fromJson(Map<String, dynamic> json) {
    return ProductCondition(
      id: json['id'] ?? '',
      meaning: json['meaning'] ?? '',
    );
  }

  // Method to convert Category instance to JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'meaning': meaning,
    };
  }

  factory ProductCondition.fromMap(Map<String, dynamic> data) =>
      ProductCondition(
        id: data['id'],
        meaning: data['meaning'],
      );

  // Method to convert Category instance to map (for Firestore usage)
  Map<String, dynamic> toMap() {
    return {
      'meaning': meaning,
    };
  }
}

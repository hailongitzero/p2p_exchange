import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  late String id;
  late String name;
  late String description;
  late double price;
  late String categoryId;
  late String image; // main product image
  late List<String> imageSlides; // additional images for slideshow
  late DateTime createdAt;
  late String userId;
  late List<String> comments;
  late List<String> tradeList;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.image,
    required this.imageSlides,
    required this.createdAt,
    required this.userId,
    required this.comments,
    required this.tradeList,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        price: json['price'].toDouble(),
        categoryId: json['categoryId'],
        image: json['image'],
        imageSlides: List<String>.from(json['imageSlides']),
        createdAt: (json['createdAt'] as Timestamp).toDate(),
        userId: json['userId'],
        comments: List<String>.from(json['comments']),
        tradeList: List<String>.from(json['tradeList']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'categoryId': categoryId,
        'image': image,
        'imageSlides': imageSlides,
        'createdAt': Timestamp.fromDate(createdAt),
        'userId': userId,
        'comments': comments,
        'tradeList': tradeList,
      };

  factory Product.fromMap(Map<String, dynamic> data) => Product(
        id: data['id'],
        name: data['name'],
        description: data['description'],
        price: data['price'],
        categoryId: data['categoryId'],
        image: data['image'],
        imageSlides: List<String>.from(data['imageSlides']),
        createdAt: (data['createdAt'] as Timestamp).toDate(),
        userId: data['userId'],
        comments: List<String>.from(data['comments']),
        tradeList: List<String>.from(data['tradeList']),
      );

  String? get productId => null;

  get mainImage => null;
}

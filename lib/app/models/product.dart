import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  late String? id;
  late String name;
  late String description;
  late double? price;
  late int? quantity;
  late String? categoryId;
  late String? status; //sold/stock
  late String? condition; //old new
  late String? image; // main product image
  late List<String>? imageSlides; // additional images for slideshow
  late DateTime? createdAt;
  late String userId;
  late List<String>? comments;
  late List<String>? tradeList;

  Product({
    this.id,
    required this.name,
    required this.description,
    this.price,
    this.quantity,
    this.categoryId,
    this.status,
    this.condition,
    this.image,
    this.imageSlides,
    this.createdAt,
    required this.userId,
    this.comments,
    this.tradeList,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        description: json['description'] ?? '',
        price: (json['price'] ?? 0).toDouble(),
        quantity: (json['quantity']),
        categoryId: json['categoryId'] ?? '',
        status: json['status'] ?? '',
        condition: json['condition'] ?? '',
        image: json['image'] ?? '',
        imageSlides: json['imageSlides'] != null
            ? List<String>.from(json['imageSlides'] as List)
            : [],
        createdAt:
            (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
        userId: json['userId'] ?? '',
        comments: json['comments'] != null
            ? List<String>.from(json['comments'] as List)
            : [],
        tradeList: json['tradeList'] != null
            ? List<String>.from(json['tradeList'] as List)
            : [],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'quantity': quantity,
        'categoryId': categoryId,
        'status': status,
        'condition': condition,
        'image': image,
        'imageSlides': imageSlides,
        'createdAt': Timestamp.fromDate(createdAt!),
        'userId': userId,
        'comments': comments,
        'tradeList': tradeList,
      };

  String? get productId => null;

  get mainImage => null;
}

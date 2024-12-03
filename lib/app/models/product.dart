import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:p2p_exchange/app/models/Trade.dart';
import 'package:p2p_exchange/app/models/comment.dart';

class Product {
  late String? id;
  late String name;
  late String description;
  late String? wishes;
  late double? price;
  late int? quantity;
  late String? categoryId;
  late String? status; //sold/stock
  late String? condition; //old new
  late String? image; // main product image
  late List<String>? imageSlides; // additional images for slideshow
  late DateTime? createdAt;
  late String userId;
  late List<Comment>? comments;
  late List<Trade>? tradeList;

  Product({
    this.id,
    required this.name,
    required this.description,
    this.price,
    this.quantity,
    this.categoryId,
    this.status,
    this.condition,
    this.wishes,
    this.image,
    this.imageSlides,
    this.createdAt,
    required this.userId,
    this.comments,
    this.tradeList,
  });

  factory Product.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    return Product(
      id: doc.id,
      name: data?['name'] ?? '',
      description: data?['description'] ?? '',
      wishes: data?['wishes'] ?? '',
      price: (data?['price'] ?? 0).toDouble(),
      quantity: data?['quantity'] ?? 0,
      categoryId: data?['categoryId'] ?? '',
      status: data?['status'] ?? '',
      condition: data?['condition'] ?? '',
      image: data?['image'] ?? '',
      imageSlides: data?['imageSlides'] != null
          ? List<String>.from(data?['imageSlides'] as List)
          : [],
      createdAt: (data?['createdAt'] as Timestamp).toDate(),
      userId: data?['userId'] ?? '',
      comments: data?['comments'] != null
          ? List<Comment>.from((data?['comments'] as List)
              .map((item) => Comment.fromMap(item as Map<String, dynamic>)))
          : [],
      tradeList: data?['tradeList'] != null
          ? List<Trade>.from((data?['tradeList'] as List)
              .map((item) => Trade.fromMap(item as Map<String, dynamic>)))
          : [],
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        description: json['description'] ?? '',
        wishes: json['wishes'] ?? '',
        price: (json['price'] ?? 0).toDouble(),
        quantity: (json['quantity']),
        categoryId: json['categoryId'] ?? '',
        status: json['status'] ?? '',
        condition: json['condition'] ?? '',
        image: json['image'] ?? '',
        imageSlides: json['imageSlides'] != null
            ? List<String>.from(json['imageSlides'] as List)
            : [],
        createdAt: (json['createdAt'] as Timestamp).toDate(),
        userId: json['userId'] ?? '',
        comments: json['comments'] != null
            ? List<Comment>.from((json['comments'] as List)
                .map((item) => Comment.fromMap(item as Map<String, dynamic>)))
            : [],
        tradeList: json['tradeList'] != null
            ? List<Trade>.from((json['tradeList'] as List)
                .map((item) => Trade.fromMap(item as Map<String, dynamic>)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'wishes': wishes,
        'price': price,
        'quantity': quantity,
        'categoryId': categoryId,
        'status': status,
        'condition': condition,
        'image': image,
        'imageSlides': imageSlides,
        'createdAt': createdAt,
        'userId': userId,
        'comments': comments,
        'tradeList': tradeList,
      };

  String? get productId => null;

  get mainImage => null;
}

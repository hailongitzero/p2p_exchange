import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String id;
  final String userId;
  final String productId;
  final String content;
  final DateTime createdAt;
  final int likes;

  Comment({
    required this.id,
    required this.userId,
    required this.productId,
    required this.content,
    required this.createdAt,
    required this.likes,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json['id'],
        userId: json['userId'],
        productId: json['productId'],
        content: json['content'],
        createdAt: (json['createdAt'] as Timestamp).toDate(),
        likes: json['likes'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'productId': productId,
        'content': content,
        'createdAt': Timestamp.fromDate(createdAt),
        'likes': likes,
      };
}

import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  late String? id;
  late String? userId;
  late String? productId;
  late String? content;
  late List<String>? images;
  late DateTime? createdAt;
  late int? likes;

  Comment({
    this.id,
    this.userId,
    this.productId,
    this.content,
    this.images,
    this.createdAt,
    this.likes,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json['id'],
        userId: json['userId'],
        productId: json['productId'],
        content: json['content'],
        images: json['images'],
        createdAt: (json['createdAt'] as Timestamp).toDate(),
        likes: json['likes'],
      );

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      userId: map['userId'],
      content: map['content'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      likes: map['likes'],
      images: List<String>.from(map['images'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'productId': productId,
        'content': content,
        'images': images,
        'createdAt': createdAt,
        'likes': likes,
      };
}

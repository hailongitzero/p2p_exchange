import 'package:cloud_firestore/cloud_firestore.dart';

class TradeComment {
  late String? id;
  late String? userId;
  late String? content;
  late DateTime? createdAt;

  TradeComment({
    this.id,
    this.userId,
    this.content,
    this.createdAt,
  });

  factory TradeComment.fromJson(Map<String, dynamic> json) => TradeComment(
        id: json['id'],
        userId: json['userId'],
        content: json['content'],
        createdAt: (json['createdAt'] as Timestamp).toDate(),
      );

  factory TradeComment.fromMap(Map<String, dynamic> map) {
    return TradeComment(
      userId: map['userId'],
      content: map['content'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'content': content,
        'createdAt': createdAt,
      };
}

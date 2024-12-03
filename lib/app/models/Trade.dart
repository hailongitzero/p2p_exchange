import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:p2p_exchange/app/models/TradeComment.dart';

class Trade {
  late String? id;
  late String? userId;
  late String? content;
  late String? status;
  late List<String>? images;
  late DateTime? createdAt;
  late List<TradeComment>? comments;

  Trade({
    this.id,
    this.userId,
    this.content,
    this.images,
    this.status,
    this.createdAt,
    this.comments,
  });

  factory Trade.fromJson(Map<String, dynamic> json) => Trade(
        id: json['id'],
        userId: json['userId'],
        content: json['content'],
        images: json['images'],
        status: json['status'],
        createdAt: (json['createdAt'] as Timestamp).toDate(),
        comments: json['comments'] != null
            ? List<TradeComment>.from((json['comments'] as List).map(
                (item) => TradeComment.fromMap(item as Map<String, dynamic>)))
            : [],
      );

  factory Trade.fromMap(Map<String, dynamic> map) {
    return Trade(
      id: map['id'],
      userId: map['userId'],
      content: map['content'],
      status: map['status'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      images: List<String>.from(map['images'] ?? []),
      comments: map['comments'] != null
          ? List<TradeComment>.from((map['comments'] as List).map(
              (item) => TradeComment.fromMap(item as Map<String, dynamic>)))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'content': content,
        'status': status,
        'images': images,
        'createdAt': createdAt,
        'comments': comments,
      };
}

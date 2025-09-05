import 'package:equatable/equatable.dart';

/// Domain entity representing a customer review in the Koozen Admin system.
/// Pure business object — no framework or persistence dependencies.
class ReviewEntity extends Equatable {
  final String id;
  final String productId;
  final String userId;
  final String userName;
  final int rating; // 1–5
  final String? comment;
  final String? title;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ReviewEntity({
    required this.id,
    required this.productId,
    required this.userId,
    required this.userName,
    required this.rating,
    required this.title,
    this.comment,
    required this.createdAt,
    required this.updatedAt,
  }) : assert(rating >= 1 && rating <= 5, 'Rating must be between 1 and 5');

  ReviewEntity copyWith({
    String? id,
    String? productId,
    String? userId,
    String? userName,
    int? rating,
    String? comment,
    String? title,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ReviewEntity(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        productId,
        userId,
        userName,
        rating,
        comment,
        title,
        createdAt,
        updatedAt,
      ];
}

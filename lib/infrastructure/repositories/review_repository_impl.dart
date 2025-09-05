import 'package:koozen_admin/core/entities/review_entity.dart';
import 'package:koozen_admin/core/repositories/review_repository.dart';

/// In-memory implementation of [ReviewRepository] for development and testing.
/// Replace with a real data source (e.g., REST API, Firebase) in production.
class ReviewRepositoryImpl implements ReviewRepository {
  final List<ReviewEntity> _reviews = [];

  @override
  Future<List<ReviewEntity>> getReviews({
    String? productId,
    int? minRating,
    int? maxRating,
    String? searchQuery,
    int? limit,
    int? offset,
  }) async {
    var results = _reviews;

    if (productId != null) {
      results = results.where((r) => r.productId == productId).toList();
    }

    if (minRating != null) {
      results = results.where((r) => r.rating >= minRating).toList();
    }

    if (maxRating != null) {
      results = results.where((r) => r.rating <= maxRating).toList();
    }

    if (searchQuery != null && searchQuery.isNotEmpty) {
      final q = searchQuery.toLowerCase();
      results = results
          .where((r) =>
              r.title!.toLowerCase().contains(q) ||
              r.comment!.toLowerCase().contains(q))
          .toList();
    }

    if (offset != null && offset > 0) {
      results = results.skip(offset).toList();
    }

    if (limit != null && limit > 0 && limit < results.length) {
      results = results.take(limit).toList();
    }

    return results;
  }

  @override
  Future<ReviewEntity?> getReviewById(String id) async {
    try {
      return _reviews.firstWhere((r) => r.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<ReviewEntity> createReview(ReviewEntity review) async {
    _reviews.add(review);
    return review;
  }

  @override
  Future<ReviewEntity> updateReview(ReviewEntity review) async {
    final index = _reviews.indexWhere((r) => r.id == review.id);
    if (index != -1) {
      _reviews[index] = review;
      return review;
    }
    throw Exception('Review not found');
  }

  @override
  Future<void> deleteReview(String id) async {
    _reviews.removeWhere((r) => r.id == id);
  }

  @override
  Future<double> getAverageRating(String productId) async {
    final productReviews =
        _reviews.where((r) => r.productId == productId).toList();
    if (productReviews.isEmpty) return 0.0;
    final total = productReviews.fold<int>(0, (sum, r) => sum + r.rating);
    return total / productReviews.length;
  }

  @override
  Future<List<ReviewEntity>> getRecentReviews(String productId,
      {int limit = 5}) async {
    final productReviews =
        _reviews.where((r) => r.productId == productId).toList();
    productReviews.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return productReviews.take(limit).toList();
  }
}

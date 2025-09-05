import 'package:koozen_admin/core/entities/review_entity.dart';

/// Repository contract for managing customer reviews in the Koozen Admin system.
/// This is a domain-level abstraction (port) that will be implemented
/// by infrastructure adapters (e.g., Firebase, REST API, analytics engine).
abstract class ReviewRepository {
  /// Retrieves all reviews, optionally filtered by product or rating.
  Future<List<ReviewEntity>> getReviews({
    String? productId,
    int? minRating,
    int? maxRating,
    String? searchQuery,
    int? limit,
    int? offset,
  });

  /// Retrieves a single review by its unique [id].
  Future<ReviewEntity?> getReviewById(String id);

  /// Creates a new review.
  Future<ReviewEntity> createReview(ReviewEntity review);

  /// Updates an existing review.
  Future<ReviewEntity> updateReview(ReviewEntity review);

  /// Deletes a review by its [id].
  Future<void> deleteReview(String id);

  /// Calculates the average rating for a given product.
  Future<double> getAverageRating(String productId);

  /// Retrieves the most recent reviews for a product.
  Future<List<ReviewEntity>> getRecentReviews(String productId,
      {int limit = 5});
}

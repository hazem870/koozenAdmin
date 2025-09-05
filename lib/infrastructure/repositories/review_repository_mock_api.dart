import 'dart:async';
import 'dart:math';

import 'package:koozen_admin/core/entities/review_entity.dart';
import 'package:koozen_admin/core/repositories/review_repository.dart';
import 'package:koozen_admin/core/exceptions/network_exception.dart';

/// Mock API implementation of [ReviewRepository].
/// Simulates network latency and responses for development/testing.
class ReviewRepositoryMockApi implements ReviewRepository {
  final List<ReviewEntity> _reviews = [];
  final Random _random = Random();

  Future<void> _simulateNetworkDelay() async {
    await Future.delayed(Duration(milliseconds: 300 + _random.nextInt(700)));
  }

  void _maybeThrowNetworkError() {
    if (_random.nextDouble() < 0.05) {
      throw NetworkException('Simulated network failure');
    }
  }

  @override
  Future<List<ReviewEntity>> getReviews({
    String? productId,
    int? minRating,
    int? maxRating,
    String? searchQuery,
    int? limit,
    int? offset,
  }) async {
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();

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
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();
    try {
      return _reviews.firstWhere((r) => r.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<ReviewEntity> createReview(ReviewEntity review) async {
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();
    _reviews.add(review);
    return review;
  }

  @override
  Future<ReviewEntity> updateReview(ReviewEntity review) async {
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();
    final index = _reviews.indexWhere((r) => r.id == review.id);
    if (index != -1) {
      _reviews[index] = review;
      return review;
    }
    throw NetworkException('Review not found', code: 'NOT_FOUND');
  }

  @override
  Future<void> deleteReview(String id) async {
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();
    _reviews.removeWhere((r) => r.id == id);
  }

  @override
  Future<double> getAverageRating(String productId) async {
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();
    final productReviews =
        _reviews.where((r) => r.productId == productId).toList();
    if (productReviews.isEmpty) return 0.0;
    final total = productReviews.fold<int>(0, (sum, r) => sum + r.rating);
    return total / productReviews.length;
  }

  @override
  Future<List<ReviewEntity>> getRecentReviews(String productId,
      {int limit = 5}) async {
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();
    final productReviews =
        _reviews.where((r) => r.productId == productId).toList();
    productReviews.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return productReviews.take(limit).toList();
  }
}

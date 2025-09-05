import 'package:flutter_test/flutter_test.dart';
import 'package:koozen_admin/di/service_locator.dart';
import 'package:koozen_admin/core/entities/review_entity.dart';
import 'package:koozen_admin/core/repositories/review_repository.dart';

void main() {
  setUp(() {
    setupServiceLocator();
  });

  test('Review workflow: create → list → average rating → recent → delete',
      () async {
    final reviewRepo = sl<ReviewRepository>();

    // Step 1: Create reviews
    final review1 = ReviewEntity(
      id: 'r1',
      productId: 'p1',
      title: 'Great product',
      comment: 'Really enjoyed using this!',
      rating: 5,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    );

    final review2 = ReviewEntity(
      id: 'r2',
      productId: 'p1',
      title: 'Good value',
      comment: 'Worth the price.',
      rating: 4,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    );

    await reviewRepo.createReview(review1);
    await reviewRepo.createReview(review2);

    // Step 2: List reviews
    var reviews = await reviewRepo.getReviews(productId: 'p1');
    expect(reviews.length, 2);

    // Step 3: Calculate average rating
    final avgRating = await reviewRepo.getAverageRating('p1');
    expect(avgRating, 4.5);

    // Step 4: Get recent reviews (limit 1)
    final recent = await reviewRepo.getRecentReviews('p1', limit: 1);
    expect(recent.length, 1);
    expect(recent.first.id, 'r2'); // Most recent

    // Step 5: Delete a review
    await reviewRepo.deleteReview('r1');
    reviews = await reviewRepo.getReviews(productId: 'p1');
    expect(reviews.length, 1);
    expect(reviews.first.id, 'r2');
  });
}

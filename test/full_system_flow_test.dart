import 'package:flutter_test/flutter_test.dart';
import 'package:koozen_admin/di/service_locator.dart';

// Entities
import 'package:koozen_admin/core/entities/product_entity.dart';
import 'package:koozen_admin/core/entities/order_entity.dart';
import 'package:koozen_admin/core/entities/supplier_entity.dart';
import 'package:koozen_admin/core/entities/performance_metrics.dart';
import 'package:koozen_admin/core/entities/review_entity.dart';

// Use cases
import 'package:koozen_admin/core/usecases/product/import_products.dart';
import 'package:koozen_admin/core/usecases/product/get_products.dart';
import 'package:koozen_admin/core/usecases/order/get_orders.dart';
import 'package:koozen_admin/core/usecases/order/update_order_status.dart';
import 'package:koozen_admin/core/usecases/supplier/add_supplier.dart';
import 'package:koozen_admin/core/usecases/supplier/sync_supplier.dart';

// Repositories
import 'package:koozen_admin/core/repositories/order_repository.dart';
import 'package:koozen_admin/core/repositories/review_repository.dart';

void main() {
  setUp(() {
    setupServiceLocator();
  });

  test('Full system flow: product → order → supplier sync → review', () async {
    // --- Step 1: Add a product ---
    final importProducts = sl<ImportProductsUseCase>();
    final getProducts = sl<GetProductsUseCase>();

    final product = ProductEntity(
      id: 'p1',
      name: 'Integration Test Product',
      description: 'A product for full-system testing',
      price: 49.99,
      stockQuantity: 20,
      categories: ['cat1'],
    );

    await importProducts.execute([product]);
    final products = await getProducts.execute();
    expect(products.length, 1);

    // --- Step 2: Place an order for the product ---
    final orderRepo = sl<OrderRepository>();
    final order = OrderEntity(
      id: 'o1',
      customerName: 'Test Customer',
      customerEmail: 'customer@example.com',
      status: 'pending',
      createdAt: DateTime.now(),
      items: [product],
      totalAmount: product.price,
    );

    await orderRepo.createOrder(order);
    var orders = await sl<GetOrdersUseCase>().execute();
    expect(orders.length, 1);

    // --- Step 3: Update order status to confirmed ---
    await sl<UpdateOrderStatusUseCase>().execute(
      orderId: 'o1',
      newStatus: 'confirmed',
    );
    orders = await sl<GetOrdersUseCase>().execute();
    expect(orders.first.status, 'confirmed');

    // --- Step 4: Add a supplier and sync ---
    final addSupplier = sl<AddSupplierUseCase>();
    final syncSupplier = sl<SyncSupplierUseCase>();

    final supplier = SupplierEntity(
      id: 's1',
      name: 'Integration Supplier',
      website: 'https://supplier.example.com',
      apiKey: 'dummy-key',
      performanceMetrics: PerformanceMetrics(
        averageDeliveryTimeDays: 4,
        fulfillmentRate: 0.95,
        returnRate: 0.03,
      ),
    );

    await addSupplier.execute(supplier);
    final syncOk = await syncSupplier.execute('s1');
    expect(syncOk, true);

    // --- Step 5: Leave a review for the product ---
    final reviewRepo = sl<ReviewRepository>();
    final review = ReviewEntity(
      id: 'r1',
      productId: 'p1',
      title: 'Excellent!',
      comment: 'This product exceeded expectations.',
      rating: 5,
      createdAt: DateTime.now(),
    );

    await reviewRepo.createReview(review);
    final reviews = await reviewRepo.getReviews(productId: 'p1');
    expect(reviews.length, 1);
    expect(reviews.first.rating, 5);
  });
}

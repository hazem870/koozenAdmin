import 'package:koozen_admin/core/entities/order_entity.dart';

/// Repository contract for managing orders in the Koozen Admin system.
/// This is a domain-level abstraction (port) that will be implemented
/// by infrastructure adapters (e.g., Firebase, REST API, ERP integration).
abstract class OrderRepository {
  /// Retrieves all orders, optionally filtered by status, date range, or search term.
  Future<List<OrderEntity>> getOrders({
    String? status,
    DateTime? startDate,
    DateTime? endDate,
    String? searchQuery,
    int? limit,
    int? offset,
  });

  /// Retrieves a single order by its unique [id].
  Future<OrderEntity?> getOrderById(String id);

  /// Creates a new order in the system.
  Future<OrderEntity> createOrder(OrderEntity order);

  /// Updates an existing order.
  Future<OrderEntity> updateOrder(OrderEntity order);

  /// Deletes an order by its [id].
  Future<void> deleteOrder(String id);

  /// Updates the status of an order.
  Future<void> updateOrderStatus({
    required String orderId,
    required String newStatus,
  });

  /// Assigns a tracking number and shipping provider to an order.
  Future<void> assignTrackingInfo({
    required String orderId,
    required String trackingNumber,
    required String shippingProvider,
  });

  /// Retrieves orders that require urgent attention (e.g., delayed, payment issues).
  Future<List<OrderEntity>> getUrgentOrders();
}

import 'package:koozen_admin/core/entities/order_entity.dart';
import 'package:koozen_admin/core/repositories/order_repository.dart';

/// In-memory implementation of [OrderRepository] for development and testing.
/// Replace with a real data source (e.g., REST API, Firebase) in production.
class OrderRepositoryImpl implements OrderRepository {
  final List<OrderEntity> _orders = [];

  @override
  Future<List<OrderEntity>> getOrders({
    String? status,
    DateTime? startDate,
    DateTime? endDate,
    String? searchQuery,
    int? limit,
    int? offset,
  }) async {
    var results = _orders;

    if (status != null) {
      results = results.where((o) => o.status == status).toList();
    }

    if (startDate != null) {
      results = results.where((o) => o.createdAt.isAfter(startDate)).toList();
    }

    if (endDate != null) {
      results = results.where((o) => o.createdAt.isBefore(endDate)).toList();
    }

    if (searchQuery != null && searchQuery.isNotEmpty) {
      final q = searchQuery.toLowerCase();
      results = results
          .where((o) =>
              o.customerName.toLowerCase().contains(q) ||
              o.customerEmail.toLowerCase().contains(q) ||
              o.id.toLowerCase().contains(q))
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
  Future<OrderEntity?> getOrderById(String id) async {
    try {
      return _orders.firstWhere((o) => o.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<OrderEntity> createOrder(OrderEntity order) async {
    _orders.add(order);
    return order;
  }

  @override
  Future<OrderEntity> updateOrder(OrderEntity order) async {
    final index = _orders.indexWhere((o) => o.id == order.id);
    if (index != -1) {
      _orders[index] = order;
      return order;
    }
    throw Exception('Order not found');
  }

  @override
  Future<void> deleteOrder(String id) async {
    _orders.removeWhere((o) => o.id == id);
  }

  @override
  Future<void> updateOrderStatus({
    required String orderId,
    required String newStatus,
  }) async {
    final index = _orders.indexWhere((o) => o.id == orderId);
    if (index != -1) {
      final order = _orders[index];
      _orders[index] = order.copyWith(status: newStatus);
    } else {
      throw Exception('Order not found');
    }
  }

  @override
  Future<void> assignTrackingInfo({
    required String orderId,
    required String trackingNumber,
    required String shippingProvider,
  }) async {
    final index = _orders.indexWhere((o) => o.id == orderId);
    if (index != -1) {
      final order = _orders[index];
      _orders[index] = order.copyWith(
        trackingNumber: trackingNumber,
        shippingProvider: shippingProvider,
      );
    } else {
      throw Exception('Order not found');
    }
  }

  @override
  Future<List<OrderEntity>> getUrgentOrders() async {
    // For now, define "urgent" as orders with status 'delayed' or 'payment_issue'
    return _orders
        .where((o) => o.status == 'delayed' || o.status == 'payment_issue')
        .toList();
  }
}

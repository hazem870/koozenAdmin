import 'dart:async';
import 'dart:math';

import 'package:koozen_admin/core/entities/order_entity.dart';
import 'package:koozen_admin/core/repositories/order_repository.dart';
import 'package:koozen_admin/core/exceptions/network_exception.dart';

/// Mock API implementation of [OrderRepository].
/// Simulates network latency and responses for development/testing.
class OrderRepositoryMockApi implements OrderRepository {
  final List<OrderEntity> _orders = [];
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
  Future<List<OrderEntity>> getOrders({
    String? status,
    DateTime? startDate,
    DateTime? endDate,
    String? searchQuery,
    int? limit,
    int? offset,
  }) async {
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();

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
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();
    try {
      return _orders.firstWhere((o) => o.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<OrderEntity> createOrder(OrderEntity order) async {
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();
    _orders.add(order);
    return order;
  }

  @override
  Future<OrderEntity> updateOrder(OrderEntity order) async {
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();
    final index = _orders.indexWhere((o) => o.id == order.id);
    if (index != -1) {
      _orders[index] = order;
      return order;
    }
    throw NetworkException('Order not found', code: 'NOT_FOUND');
  }

  @override
  Future<void> deleteOrder(String id) async {
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();
    _orders.removeWhere((o) => o.id == id);
  }

  @override
  Future<void> updateOrderStatus({
    required String orderId,
    required String newStatus,
  }) async {
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();
    final index = _orders.indexWhere((o) => o.id == orderId);
    if (index != -1) {
      final order = _orders[index];
      _orders[index] = order.copyWith(status: newStatus);
    } else {
      throw NetworkException('Order not found', code: 'NOT_FOUND');
    }
  }

  @override
  Future<void> assignTrackingInfo({
    required String orderId,
    required String trackingNumber,
    required String shippingProvider,
  }) async {
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();
    final index = _orders.indexWhere((o) => o.id == orderId);
    if (index != -1) {
      final order = _orders[index];
      _orders[index] = order.copyWith(
        trackingNumber: trackingNumber,
        shippingProvider: shippingProvider,
      );
    } else {
      throw NetworkException('Order not found', code: 'NOT_FOUND');
    }
  }

  @override
  Future<List<OrderEntity>> getUrgentOrders() async {
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();
    return _orders
        .where((o) => o.status == 'delayed' || o.status == 'payment_issue')
        .toList();
  }
}

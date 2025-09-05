import 'package:koozen_admin/core/entities/order_entity.dart';
import 'package:koozen_admin/core/repositories/order_repository.dart';

/// Use case for automatically placing an order with the supplier.
/// Typically triggered when a customer order is confirmed.
class AutoOrderSupplierUseCase {
  const AutoOrderSupplierUseCase(this.repository);
  final OrderRepository repository;

  Future<bool> execute(OrderEntity order) async {
    // TODO: KOZ-9 — Integrate with supplier sync service or adapter.
    // For now, assume repository handles supplier forwarding.
    try {
      // This could internally trigger a sync or API call.
      final updatedOrder = await repository.updateOrder(order);
      return updatedOrder.status == 'processing' ||
          updatedOrder.status == 'forwarded';
    } catch (e) {
      // TODO: KOZ-10 — Add error handling, logging, and retry logic.
      return false;
    }
  }
}

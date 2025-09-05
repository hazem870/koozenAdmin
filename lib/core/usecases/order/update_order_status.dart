import 'package:koozen_admin/core/repositories/order_repository.dart';

/// Use case for updating the status of an order.
/// Typically used in order processing workflows.
class UpdateOrderStatusUseCase {
  const UpdateOrderStatusUseCase(this.repository);
  final OrderRepository repository;

  Future<void> execute({
    required String orderId,
    required String newStatus,
  }) async {
    // TODO: KOZ-8 — Add validation, permission checks, or event triggers.
    await repository.updateOrderStatus(
      orderId: orderId,
      newStatus: newStatus,
    );
  }
}

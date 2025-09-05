import 'package:koozen_admin/core/entities/order_entity.dart';
import 'package:koozen_admin/core/repositories/order_repository.dart';

/// Use case for retrieving orders from the system.
/// Supports optional filtering and pagination.
class GetOrdersUseCase {
  const GetOrdersUseCase(this.repository);
  final OrderRepository repository;

  Future<List<OrderEntity>> execute({
    String? status,
    DateTime? startDate,
    DateTime? endDate,
    String? searchQuery,
    int? limit,
    int? offset,
  }) {
    return repository.getOrders(
      status: status,
      startDate: startDate,
      endDate: endDate,
      searchQuery: searchQuery,
      limit: limit,
      offset: offset,
    );
  }
}

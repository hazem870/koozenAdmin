import 'package:koozen_admin/core/entities/product_entity.dart';
import 'package:koozen_admin/core/repositories/product_repository.dart';

/// Use case for retrieving products from the system.
/// Supports optional filtering and pagination.
class GetProductsUseCase {
  const GetProductsUseCase(this.repository);
  final ProductRepository repository;

  Future<List<ProductEntity>> execute({
    String? categoryId,
    String? searchQuery,
    int? limit,
    int? offset,
  }) {
    return repository.getProducts(
      categoryId: categoryId,
      searchQuery: searchQuery,
      limit: limit,
      offset: offset,
    );
  }
}

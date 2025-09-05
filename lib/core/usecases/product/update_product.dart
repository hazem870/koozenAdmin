import 'package:koozen_admin/core/entities/product_entity.dart';
import 'package:koozen_admin/core/repositories/product_repository.dart';

/// Use case for updating an existing product in the system.
/// Typically used in product editing workflows.
class UpdateProductUseCase {
  const UpdateProductUseCase(this.repository);
  final ProductRepository repository;

  Future<ProductEntity> execute(ProductEntity updatedProduct) async {
    // TODO: KOZ-6 — Add validation or audit logging if needed.
    return await repository.updateProduct(updatedProduct);
  }
}

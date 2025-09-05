import 'package:koozen_admin/core/repositories/product_repository.dart';

/// Use case for deleting a product from the system.
/// Typically used in admin workflows or inventory cleanup.
class DeleteProductUseCase {
  final ProductRepository repository;

  const DeleteProductUseCase(this.repository);

  Future<void> execute(String productId) async {
    // TODO: KOZ-7 — Add audit logging or soft-delete logic if needed.
    await repository.deleteProduct(productId);
  }
}

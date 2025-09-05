import 'package:koozen_admin/core/entities/product_entity.dart';
import 'package:koozen_admin/core/repositories/product_repository.dart';

/// Use case for importing a batch of products into the system.
/// Typically used for supplier sync or CSV/Excel bulk import.
class ImportProductsUseCase {
  const ImportProductsUseCase(this.repository);
  final ProductRepository repository;

  Future<List<ProductEntity>> execute(List<ProductEntity> products) async {
    // TODO: KOZ-5 — Add validation, deduplication, or transformation logic here.
    return await repository.importProducts(products);
  }
}

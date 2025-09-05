import 'package:koozen_admin/core/entities/product_entity.dart';

/// Repository contract for managing products in the Koozen Admin system.
/// This is a domain-level abstraction (port) that will be implemented
/// by infrastructure adapters (e.g., Firebase, REST API, CSV importer).
abstract class ProductRepository {
  /// Retrieves all products, optionally filtered by category or search term.
  Future<List<ProductEntity>> getProducts({
    String? categoryId,
    String? searchQuery,
    int? limit,
    int? offset,
  });

  /// Retrieves a single product by its unique [id].
  Future<ProductEntity?> getProductById(String id);

  /// Creates a new product in the system.
  Future<ProductEntity> createProduct(ProductEntity product);

  /// Updates an existing product.
  Future<ProductEntity> updateProduct(ProductEntity product);

  /// Deletes a product by its [id].
  Future<void> deleteProduct(String id);

  /// Imports products from an external source (e.g., supplier API, CSV).
  /// Returns the list of successfully imported products.
  Future<List<ProductEntity>> importProducts(List<ProductEntity> products);

  /// Updates the stock quantity for a given product.
  Future<void> updateStock({
    required String productId,
    required int newQuantity,
  });

  /// Retrieves products that are low in stock (below [threshold]).
  Future<List<ProductEntity>> getLowStockProducts({required int threshold});
}

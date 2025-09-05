import 'package:koozen_admin/core/entities/product_entity.dart';
import 'package:koozen_admin/core/repositories/product_repository.dart';

/// In-memory implementation of [ProductRepository] for development and testing.
/// Replace with a real data source (e.g., REST API, Firebase) in production.
class ProductRepositoryImpl implements ProductRepository {
  final List<ProductEntity> _products = [];

  @override
  Future<List<ProductEntity>> getProducts({
    String? categoryId,
    String? searchQuery,
    int? limit,
    int? offset,
  }) async {
    var results = _products;

    if (categoryId != null) {
      results =
          results.where((p) => p.categories.contains(categoryId)).toList();
    }

    if (searchQuery != null && searchQuery.isNotEmpty) {
      final q = searchQuery.toLowerCase();
      results = results
          .where((p) =>
              p.name.toLowerCase().contains(q) ||
              p.description.toLowerCase().contains(q))
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
  Future<ProductEntity?> getProductById(String id) async {
    return _products.firstWhere(
      (p) => p.id == id,
      orElse: () => null as ProductEntity,
    );
  }

  @override
  Future<ProductEntity> createProduct(ProductEntity product) async {
    _products.add(product);
    return product;
  }

  @override
  Future<ProductEntity> updateProduct(ProductEntity product) async {
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      _products[index] = product;
      return product;
    }
    throw Exception('Product not found');
  }

  @override
  Future<void> deleteProduct(String id) async {
    _products.removeWhere((p) => p.id == id);
  }

  @override
  Future<List<ProductEntity>> importProducts(
      List<ProductEntity> products) async {
    _products.addAll(products);
    return products;
  }

  @override
  Future<void> updateStock({
    required String productId,
    required int newQuantity,
  }) async {
    final index = _products.indexWhere((p) => p.id == productId);
    if (index != -1) {
      final product = _products[index];
      _products[index] = product.copyWith(stockQuantity: newQuantity);
    } else {
      throw Exception('Product not found');
    }
  }

  @override
  Future<List<ProductEntity>> getLowStockProducts(
      {required int threshold}) async {
    return _products.where((p) => p.stockQuantity < threshold).toList();
  }
}

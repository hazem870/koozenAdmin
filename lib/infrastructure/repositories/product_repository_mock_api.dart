import 'dart:async';
import 'dart:math';

import 'package:koozen_admin/core/entities/product_entity.dart';
import 'package:koozen_admin/core/repositories/product_repository.dart';
import 'package:koozen_admin/core/exceptions/network_exception.dart';

/// Mock API implementation of [ProductRepository].
/// Simulates network latency and responses for development/testing.
class ProductRepositoryMockApi implements ProductRepository {
  final List<ProductEntity> _products = [];
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
  Future<List<ProductEntity>> getProducts({
    String? categoryId,
    String? searchQuery,
    int? limit,
    int? offset,
  }) async {
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();

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
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<ProductEntity> createProduct(ProductEntity product) async {
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();
    _products.add(product);
    return product;
  }

  @override
  Future<ProductEntity> updateProduct(ProductEntity product) async {
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      _products[index] = product;
      return product;
    }
    throw NetworkException('Product not found', code: 'NOT_FOUND');
  }

  @override
  Future<void> deleteProduct(String id) async {
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();
    _products.removeWhere((p) => p.id == id);
  }

  @override
  Future<List<ProductEntity>> importProducts(
      List<ProductEntity> products) async {
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();
    _products.addAll(products);
    return products;
  }

  @override
  Future<void> updateStock({
    required String productId,
    required int newQuantity,
  }) async {
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();
    final index = _products.indexWhere((p) => p.id == productId);
    if (index != -1) {
      final product = _products[index];
      _products[index] = product.copyWith(stockQuantity: newQuantity);
    } else {
      throw NetworkException('Product not found', code: 'NOT_FOUND');
    }
  }

  @override
  Future<List<ProductEntity>> getLowStockProducts(
      {required int threshold}) async {
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();
    return _products.where((p) => p.stockQuantity < threshold).toList();
  }
}

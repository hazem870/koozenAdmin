import 'dart:async';
import 'dart:math';

import 'package:koozen_admin/core/entities/supplier_entity.dart';
import 'package:koozen_admin/core/entities/performance_metrics.dart';
import 'package:koozen_admin/core/repositories/supplier_repository.dart';
import 'package:koozen_admin/core/exceptions/network_exception.dart';

/// Mock API implementation of [SupplierRepository].
/// Simulates network latency and responses for development/testing.
class SupplierRepositoryMockApi implements SupplierRepository {
  final List<SupplierEntity> _suppliers = [];
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
  Future<List<SupplierEntity>> getSuppliers({String? searchQuery}) async {
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();

    var results = _suppliers;
    if (searchQuery != null && searchQuery.isNotEmpty) {
      final q = searchQuery.toLowerCase();
      results = results
          .where((s) =>
              s.name.toLowerCase().contains(q) ||
              s.website.toLowerCase().contains(q))
          .toList();
    }
    return results;
  }

  @override
  Future<SupplierEntity?> getSupplierById(String id) async {
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();
    try {
      return _suppliers.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<SupplierEntity> createSupplier(SupplierEntity supplier) async {
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();
    _suppliers.add(supplier);
    return supplier;
  }

  @override
  Future<SupplierEntity> updateSupplier(SupplierEntity supplier) async {
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();
    final index = _suppliers.indexWhere((s) => s.id == supplier.id);
    if (index != -1) {
      _suppliers[index] = supplier;
      return supplier;
    }
    throw NetworkException('Supplier not found', code: 'NOT_FOUND');
  }

  @override
  Future<void> deleteSupplier(String id) async {
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();
    _suppliers.removeWhere((s) => s.id == id);
  }

  @override
  Future<bool> testApiConnection(String supplierId) async {
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();
    return _suppliers.any((s) => s.id == supplierId);
  }

  @override
  Future<bool> syncSupplierData(String supplierId) async {
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();
    return _suppliers.any((s) => s.id == supplierId);
  }

  @override
  Future<PerformanceMetrics?> getPerformanceMetrics(String supplierId) async {
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();
    final supplier = _suppliers.firstWhere(
      (s) => s.id == supplierId,
      orElse: () => null as SupplierEntity,
    );
    return supplier?.performanceMetrics;
  }
}

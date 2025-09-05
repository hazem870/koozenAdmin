import 'package:koozen_admin/core/entities/supplier_entity.dart';
import 'package:koozen_admin/core/repositories/supplier_repository.dart';

/// In-memory implementation of [SupplierRepository] for development and testing.
/// Replace with a real data source (e.g., REST API, Firebase) in production.
class SupplierRepositoryImpl implements SupplierRepository {
  final List<SupplierEntity> _suppliers = [];

  @override
  Future<List<SupplierEntity>> getSuppliers({String? searchQuery}) async {
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
    try {
      return _suppliers.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<SupplierEntity> createSupplier(SupplierEntity supplier) async {
    _suppliers.add(supplier);
    return supplier;
  }

  @override
  Future<SupplierEntity> updateSupplier(SupplierEntity supplier) async {
    final index = _suppliers.indexWhere((s) => s.id == supplier.id);
    if (index != -1) {
      _suppliers[index] = supplier;
      return supplier;
    }
    throw Exception('Supplier not found');
  }

  @override
  Future<void> deleteSupplier(String id) async {
    _suppliers.removeWhere((s) => s.id == id);
  }

  @override
  Future<bool> testApiConnection(String supplierId) async {
    // Simulate a connection test — always returns true for now.
    return _suppliers.any((s) => s.id == supplierId);
  }

  @override
  Future<bool> syncSupplierData(String supplierId) async {
    // Simulate a sync — always returns true for now.
    return _suppliers.any((s) => s.id == supplierId);
  }

  @override
  Future<PerformanceMetrics?> getPerformanceMetrics(String supplierId) async {
    final supplier = _suppliers.firstWhere(
      (s) => s.id == supplierId,
      orElse: () => null as SupplierEntity,
    );
    return supplier?.performanceMetrics;
  }
}

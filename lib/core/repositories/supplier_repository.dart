import 'package:koozen_admin/core/entities/supplier_entity.dart';

/// Repository contract for managing suppliers in the Koozen Admin system.
/// This is a domain-level abstraction (port) that will be implemented
/// by infrastructure adapters (e.g., REST API, Firebase, direct supplier APIs).
abstract class SupplierRepository {
  /// Retrieves all suppliers, optionally filtered by search term.
  Future<List<SupplierEntity>> getSuppliers({String? searchQuery});

  /// Retrieves a single supplier by its unique [id].
  Future<SupplierEntity?> getSupplierById(String id);

  /// Creates a new supplier in the system.
  Future<SupplierEntity> createSupplier(SupplierEntity supplier);

  /// Updates an existing supplier.
  Future<SupplierEntity> updateSupplier(SupplierEntity supplier);

  /// Deletes a supplier by its [id].
  Future<void> deleteSupplier(String id);

  /// Tests the API connection for a given supplier.
  Future<bool> testApiConnection(String supplierId);

  /// Synchronizes inventory, prices, and orders with the supplier.
  /// Returns true if the sync was successful.
  Future<bool> syncSupplierData(String supplierId);

  /// Retrieves performance metrics for a given supplier.
  Future<PerformanceMetrics?> getPerformanceMetrics(String supplierId);
}

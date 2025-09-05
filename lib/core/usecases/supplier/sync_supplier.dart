import 'package:koozen_admin/core/repositories/supplier_repository.dart';

/// Use case for synchronizing supplier data such as inventory, prices, and orders.
/// Typically triggered manually by an admin or automatically via a scheduled task.
class SyncSupplierUseCase {
  const SyncSupplierUseCase(this.repository);
  final SupplierRepository repository;

  /// Executes a full supplier sync.
  /// Returns `true` if the sync was successful.
  Future<bool> execute(String supplierId) async {
    // TODO: KOZ-12 — Add logging, partial sync options, and retry logic.
    return await repository.syncSupplierData(supplierId);
  }
}

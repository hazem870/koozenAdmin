import 'package:koozen_admin/core/entities/supplier_entity.dart';
import 'package:koozen_admin/core/repositories/supplier_repository.dart';

/// Use case for adding a new supplier to the system.
/// Typically used in onboarding workflows or admin setup.
class AddSupplierUseCase {
  const AddSupplierUseCase(this.repository);
  final SupplierRepository repository;

  Future<SupplierEntity> execute(SupplierEntity supplier) async {
    // TODO: KOZ-11 — Add validation, duplicate checks, or API test trigger.
    return await repository.createSupplier(supplier);
  }
}

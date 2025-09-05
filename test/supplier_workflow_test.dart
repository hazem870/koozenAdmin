import 'package:flutter_test/flutter_test.dart';
import 'package:koozen_admin/di/service_locator.dart';
import 'package:koozen_admin/core/entities/supplier_entity.dart';
import 'package:koozen_admin/core/entities/performance_metrics.dart';
import 'package:koozen_admin/core/usecases/supplier/add_supplier.dart';
import 'package:koozen_admin/core/usecases/supplier/sync_supplier.dart';
import 'package:koozen_admin/core/repositories/supplier_repository.dart';

void main() {
  setUp(() {
    setupServiceLocator();
  });

  test('Supplier workflow: onboard → list → API test → sync → delete',
      () async {
    final addSupplier = sl<AddSupplierUseCase>();
    final syncSupplier = sl<SyncSupplierUseCase>();
    final supplierRepo = sl<SupplierRepository>();

    // Step 1: Onboard a supplier
    final supplier = SupplierEntity(
      id: 's1',
      name: 'Test Supplier',
      website: 'https://supplier.example.com',
      apiKey: 'dummy-key',
      performanceMetrics: PerformanceMetrics(
        averageDeliveryTimeDays: 3,
        fulfillmentRate: 0.98,
        returnRate: 0.02,
        deliveryRate: 49.98,
        productQuality: 49.98,
        competitivePricing: 49.98,
        availability: 49.98,
      ),
      contactEmail: '',
      contactPhone: '',
      createdAt: DateTime(2025, 9, 1),
      updatedAt: DateTime(2025, 9, 1),
    );

    await addSupplier.execute(supplier);

    // Step 2: List suppliers
    var suppliers = await supplierRepo.getSuppliers();
    expect(suppliers.length, 1);
    expect(suppliers.first.name, 'Test Supplier');

    // Step 3: Test API connection
    final apiOk = await supplierRepo.testApiConnection('s1');
    expect(apiOk, true);

    // Step 4: Sync supplier data
    final syncOk = await syncSupplier.execute('s1');
    expect(syncOk, true);

    // Step 5: Delete supplier
    await supplierRepo.deleteSupplier('s1');
    suppliers = await supplierRepo.getSuppliers();
    expect(suppliers.isEmpty, true);
  });
}

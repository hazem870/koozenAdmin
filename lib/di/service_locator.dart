import 'package:get_it/get_it.dart';
import 'package:koozen_admin/core/repositories/order_repository.dart';
// Core repositories
import 'package:koozen_admin/core/repositories/product_repository.dart';
import 'package:koozen_admin/core/repositories/review_repository.dart';
import 'package:koozen_admin/core/repositories/supplier_repository.dart';
import 'package:koozen_admin/core/repositories/user_repository.dart';
import 'package:koozen_admin/core/usecases/analytics/calculate_profit.dart';
import 'package:koozen_admin/core/usecases/analytics/generate_report.dart';
import 'package:koozen_admin/core/usecases/order/auto_order_supplier.dart';
import 'package:koozen_admin/core/usecases/order/get_orders.dart';
import 'package:koozen_admin/core/usecases/order/update_order_status.dart';
import 'package:koozen_admin/core/usecases/product/delete_product.dart';
// Use cases
import 'package:koozen_admin/core/usecases/product/get_products.dart';
import 'package:koozen_admin/core/usecases/product/import_products.dart';
import 'package:koozen_admin/core/usecases/product/update_product.dart';
import 'package:koozen_admin/core/usecases/supplier/add_supplier.dart';
import 'package:koozen_admin/core/usecases/supplier/sync_supplier.dart';
import 'package:koozen_admin/infrastructure/repositories/order_repository_impl.dart';
// Infrastructure implementations
import 'package:koozen_admin/infrastructure/repositories/product_repository_impl.dart';
import 'package:koozen_admin/infrastructure/repositories/review_repository_impl.dart';
import 'package:koozen_admin/infrastructure/repositories/supplier_repository_impl.dart';
import 'package:koozen_admin/infrastructure/repositories/user_repository_impl.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  // Register repositories
  sl.registerLazySingleton<ProductRepository>(ProductRepositoryImpl.new);
  sl.registerLazySingleton<OrderRepository>(OrderRepositoryImpl.new);
  sl.registerLazySingleton<SupplierRepository>(SupplierRepositoryImpl.new);
  sl.registerLazySingleton<UserRepository>(UserRepositoryImpl.new);
  sl.registerLazySingleton<ReviewRepository>(ReviewRepositoryImpl.new);

  // Register use cases
  sl.registerFactory(() => GetProductsUseCase(sl()));
  sl.registerFactory(() => ImportProductsUseCase(sl()));
  sl.registerFactory(() => UpdateProductUseCase(sl()));
  sl.registerFactory(() => DeleteProductUseCase(sl()));

  sl.registerFactory(() => GetOrdersUseCase(sl()));
  sl.registerFactory(() => UpdateOrderStatusUseCase(sl()));
  sl.registerFactory(() => AutoOrderSupplierUseCase(sl()));

  sl.registerFactory(() => AddSupplierUseCase(sl()));
  sl.registerFactory(() => SyncSupplierUseCase(sl()));

  sl.registerFactory(GenerateReportUseCase.new);
  sl.registerFactory(CalculateProfitUseCase.new);
}

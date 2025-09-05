import 'package:flutter/material.dart';
import 'di/service_locator.dart';
import 'core/entities/product_entity.dart';
import 'core/usecases/product/get_products.dart';
//import 'core/usecases/product/create_product.dart'; // We'll add this if needed
import 'core/usecases/product/import_products.dart';

void main() {
  // 1. Setup dependency injection
  setupServiceLocator();

  // 2. Run a quick smoke test before launching the app
  _runSmokeTest();

  // 3. Launch Flutter app (placeholder for now)
  runApp(const MyApp());
}

void _runSmokeTest() async {
  print('--- Running Smoke Test ---');

  // Resolve use cases from service locator
  final importProducts = sl<ImportProductsUseCase>();
  final getProducts = sl<GetProductsUseCase>();

  // Create some dummy products
  // Create some dummy products
  final products = [
    ProductEntity(
      id: 'prod_001',
      name: 'Eco-Friendly Reusable Water Bottle',
      description:
          'A durable, BPA-free water bottle made from recycled materials, perfect for staying hydrated on the go.',
      price: 24.99,
      stockQuantity: 150,
      categories: ['Hydration', 'Outdoor'],
      cost: 12.50,
      supplierId: 'supp_A123',
      imageUrls: [
        Uri.parse('https://example.com/images/bottle_blue.jpg'),
        Uri.parse('https://example.com/images/bottle_green.jpg'),
      ],
      attributes: {
        'color': 'Blue',
        'material': 'Recycled Plastic',
        'capacity_oz': 24,
      },
      createdAt: DateTime(2025, 1, 15),
      updatedAt: DateTime(2025, 9, 2),
    ),
    ProductEntity(
      id: 'prod_002',
      name: 'Wireless Noise-Cancelling Headphones',
      description:
          'Experience crystal-clear audio with these comfortable, over-ear headphones featuring active noise cancellation and a 30-hour battery life.',
      price: 199.99,
      stockQuantity: 75,
      categories: ['Electronics', 'Audio'],
      cost: 110.00,
      supplierId: 'supp_B456',
      imageUrls: [
        Uri.parse('https://example.com/images/headphones_black.jpg'),
        Uri.parse('https://example.com/images/headphones_white.jpg'),
      ],
      attributes: {
        'connectivity': 'Bluetooth 5.0',
        'battery_life_hours': 30,
        'feature': 'Active Noise Cancellation',
      },
      createdAt: DateTime(2025, 2, 20),
      updatedAt: DateTime(2025, 8, 10),
    ),
  ];

  // Import products
  await importProducts.execute(products);

  // Retrieve products
  final allProducts = await getProducts.execute();
  print('Products in system: ${allProducts.length}');
  for (var p in allProducts) {
    print(' - ${p.name} (\$${p.price})');
  }

  print('--- Smoke Test Complete ---');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Koozen Admin',
      home: Scaffold(
        appBar: AppBar(title: const Text('Koozen Admin')),
        body: const Center(child: Text('Koozen Admin is running...')),
      ),
    );
  }
}

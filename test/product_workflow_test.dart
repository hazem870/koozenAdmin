import 'package:flutter_test/flutter_test.dart';
import 'package:koozen_admin/di/service_locator.dart';
import 'package:koozen_admin/core/entities/product_entity.dart';
import 'package:koozen_admin/core/usecases/product/import_products.dart';
import 'package:koozen_admin/core/usecases/product/get_products.dart';
import 'package:koozen_admin/core/usecases/product/update_product.dart';
import 'package:koozen_admin/core/usecases/product/delete_product.dart';

void main() {
  setUp(() {
    setupServiceLocator();
  });

  test('Product workflow: import → list → update → delete', () async {
    final importProducts = sl<ImportProductsUseCase>();
    final getProducts = sl<GetProductsUseCase>();
    final updateProduct = sl<UpdateProductUseCase>();
    final deleteProduct = sl<DeleteProductUseCase>();

    // Step 1: Import products
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

    await importProducts.execute(products);

    // Step 2: List products
    var allProducts = await getProducts.execute();
    expect(allProducts.length, 2);

    // Step 3: Update a product
    final updated = allProducts.first.copyWith(price: 24.99);
    await updateProduct.execute(updated);

    allProducts = await getProducts.execute();
    expect(allProducts.first.price, 24.99);

    // Step 4: Delete a product
    await deleteProduct.execute('p1');

    allProducts = await getProducts.execute();
    expect(allProducts.length, 1);
    expect(allProducts.first.id, 'p2');
  });
}

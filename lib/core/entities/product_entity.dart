import 'package:equatable/equatable.dart';

/// Domain entity representing a product in the Koozen Admin system.
/// This is a pure business object with no framework dependencies.
/// It can be used across use cases, repositories, and presentation layers.
class ProductEntity extends Equatable {
  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.cost,
    required this.stockQuantity,
    required this.supplierId,
    required this.imageUrls,
    required this.categories,
    required this.attributes,
    required this.createdAt,
    required this.updatedAt,
  });
  final String id;
  final String name;
  final String description;
  final double price;
  final double cost;
  final int stockQuantity;
  final String supplierId;
  final List<Uri> imageUrls;
  final List<String> categories;
  final Map<String, dynamic> attributes; // e.g., color, size, options
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Creates a copy of this product with updated fields.
  ProductEntity copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    double? cost,
    int? stockQuantity,
    String? supplierId,
    List<Uri>? imageUrls,
    List<String>? categories,
    Map<String, dynamic>? attributes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      cost: cost ?? this.cost,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      supplierId: supplierId ?? this.supplierId,
      imageUrls: imageUrls ?? this.imageUrls,
      categories: categories ?? this.categories,
      attributes: attributes ?? this.attributes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        cost,
        stockQuantity,
        supplierId,
        imageUrls,
        categories,
        attributes,
        createdAt,
        updatedAt,
      ];
}

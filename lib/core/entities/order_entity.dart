import 'package:equatable/equatable.dart';

/// Domain entity representing an order in the Koozen Admin system.
/// Pure business object — no framework or persistence dependencies.
class OrderEntity extends Equatable {
  const OrderEntity({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.customerEmail,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.trackingNumber,
    this.shippingProvider,
    this.shippedAt,
    this.deliveredAt,
    this.notes,
  });
  final String id;
  final String customerId;
  final String customerName;
  final String customerEmail;
  final List<OrderItem> items;
  final double totalAmount;
  final String status; // e.g., pending, confirmed, shipped
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? trackingNumber;
  final String? shippingProvider;
  final DateTime? shippedAt;
  final DateTime? deliveredAt;
  final String? notes;

  OrderEntity copyWith({
    String? id,
    String? customerId,
    String? customerName,
    String? customerEmail,
    List<OrderItem>? items,
    double? totalAmount,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? trackingNumber,
    String? shippingProvider,
    DateTime? shippedAt,
    DateTime? deliveredAt,
    String? notes,
  }) {
    return OrderEntity(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      customerEmail: customerEmail ?? this.customerEmail,
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      trackingNumber: trackingNumber ?? this.trackingNumber,
      shippingProvider: shippingProvider ?? this.shippingProvider,
      shippedAt: shippedAt ?? this.shippedAt,
      deliveredAt: deliveredAt ?? this.deliveredAt,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props => [
        id,
        customerId,
        customerName,
        customerEmail,
        items,
        totalAmount,
        status,
        createdAt,
        updatedAt,
        trackingNumber,
        shippingProvider,
        shippedAt,
        deliveredAt,
        notes,
      ];
}

/// Represents a single item in an order.
class OrderItem extends Equatable {
  const OrderItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
  });
  final String productId;
  final String productName;
  final int quantity;
  final double unitPrice;

  double get totalPrice => quantity * unitPrice;

  @override
  List<Object?> get props => [productId, productName, quantity, unitPrice];
}

import 'package:equatable/equatable.dart';

/// Domain entity representing a supplier.
class SupplierEntity extends Equatable {
  const SupplierEntity({
    required this.id,
    required this.name,
    required this.website,
    required this.contactEmail,
    required this.contactPhone,
    this.apiConfig,
    this.performanceMetrics,
    required this.createdAt,
    required this.updatedAt,
    required this.apiKey,
  });

  final String id;
  final String name;
  final String website;
  final String contactEmail;
  final String contactPhone;
  final ApiConfig? apiConfig;
  final PerformanceMetrics? performanceMetrics;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String apiKey;

  SupplierEntity copyWith({
    String? id,
    String? name,
    String? website,
    String? contactEmail,
    String? contactPhone,
    ApiConfig? apiConfig,
    PerformanceMetrics? performanceMetrics,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? apiKey,
  }) {
    return SupplierEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      website: website ?? this.website,
      contactEmail: contactEmail ?? this.contactEmail,
      contactPhone: contactPhone ?? this.contactPhone,
      apiConfig: apiConfig ?? this.apiConfig,
      performanceMetrics: performanceMetrics ?? this.performanceMetrics,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      apiKey: apiKey ?? this.apiKey,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        website,
        contactEmail,
        contactPhone,
        apiConfig,
        performanceMetrics,
        createdAt,
        updatedAt,
        apiKey,
      ];
}

class ApiConfig extends Equatable {
  const ApiConfig({
    required this.apiKey,
    required this.apiSecret,
    required this.baseUrl,
    this.extraParams = const {},
  });

  final String apiKey;
  final String apiSecret;
  final String baseUrl;
  final Map<String, dynamic> extraParams;

  @override
  List<Object?> get props => [apiKey, apiSecret, baseUrl, extraParams];
}

class PerformanceMetrics extends Equatable {
  const PerformanceMetrics({
    required this.deliveryRate,
    required this.productQuality,
    required this.competitivePricing,
    required this.availability,
    required this.averageDeliveryTimeDays,
    required this.fulfillmentRate,
    required this.returnRate,
  });

  final double deliveryRate;
  final double productQuality;
  final double competitivePricing;
  final double availability;
  final int averageDeliveryTimeDays;
  final double fulfillmentRate;
  final double returnRate;

  @override
  List<Object?> get props => [
        deliveryRate,
        productQuality,
        competitivePricing,
        availability,
        averageDeliveryTimeDays,
        fulfillmentRate,
        returnRate,
      ];
}

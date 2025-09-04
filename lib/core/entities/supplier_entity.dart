import 'package:equatable/equatable.dart';

/// Domain entity representing a supplier in the Koozen Admin system.
/// Pure business object — no framework or persistence dependencies.
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
      ];
}

/// API configuration for supplier integrations.
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

/// Performance metrics for supplier evaluation.
class PerformanceMetrics extends Equatable {
  // percentage of products in stock

  const PerformanceMetrics({
    required this.deliveryRate,
    required this.productQuality,
    required this.competitivePricing,
    required this.availability,
  });
  final double deliveryRate; // percentage of orders delivered on time
  final double productQuality; // average rating
  final double competitivePricing; // relative score
  final double availability;

  @override
  List<Object?> get props =>
      [deliveryRate, productQuality, competitivePricing, availability];
}

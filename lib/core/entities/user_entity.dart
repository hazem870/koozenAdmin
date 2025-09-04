import 'package:equatable/equatable.dart';

/// Domain entity representing a system user in Koozen Admin.
/// Pure business object — no framework or persistence dependencies.
class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final String role; // e.g., admin, manager, editor, support
  final List<String> permissions; // granular permissions
  final String? profileImageUrl;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Preferences preferences;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    required this.role,
    this.permissions = const [],
    this.profileImageUrl,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.preferences,
  });

  UserEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? role,
    List<String>? permissions,
    String? profileImageUrl,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    Preferences? preferences,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      permissions: permissions ?? this.permissions,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      preferences: preferences ?? this.preferences,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phoneNumber,
        role,
        permissions,
        profileImageUrl,
        isActive,
        createdAt,
        updatedAt,
        preferences,
      ];
}

/// User preferences for personalization.
class Preferences extends Equatable {
  final String languageCode; // e.g., 'en', 'ar'
  final bool notificationsEnabled;
  final String themeMode; // e.g., 'light', 'dark', 'system'

  const Preferences({
    required this.languageCode,
    required this.notificationsEnabled,
    required this.themeMode,
  });

  Preferences copyWith({
    String? languageCode,
    bool? notificationsEnabled,
    String? themeMode,
  }) {
    return Preferences(
      languageCode: languageCode ?? this.languageCode,
      notificationsEnabled:
          notificationsEnabled ?? this.notificationsEnabled,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  List<Object?> get props => [languageCode, notificationsEnabled, themeMode];
}
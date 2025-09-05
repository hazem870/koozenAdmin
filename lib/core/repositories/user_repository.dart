import 'package:koozen_admin/core/entities/user_entity.dart';

/// Repository contract for managing users in the Koozen Admin system.
/// This is a domain-level abstraction (port) that will be implemented
/// by infrastructure adapters (e.g., Firebase Auth, REST API).
abstract class UserRepository {
  /// Retrieves all users, optionally filtered by role or search term.
  Future<List<UserEntity>> getUsers({
    String? role,
    String? searchQuery,
    int? limit,
    int? offset,
  });

  /// Retrieves a single user by their unique [id].
  Future<UserEntity?> getUserById(String id);

  /// Creates a new user account.
  Future<UserEntity> createUser(UserEntity user);

  /// Updates an existing user account.
  Future<UserEntity> updateUser(UserEntity user);

  /// Deletes a user by their [id].
  Future<void> deleteUser(String id);

  /// Authenticates a user with email and password.
  Future<UserEntity?> login({
    required String email,
    required String password,
  });

  /// Logs out the current user.
  Future<void> logout();

  /// Retrieves the currently authenticated user.
  Future<UserEntity?> getCurrentUser();

  /// Updates user permissions.
  Future<void> updatePermissions({
    required String userId,
    required List<String> newPermissions,
  });

  /// Updates user preferences (e.g., language, theme).
  Future<void> updatePreferences({
    required String userId,
    required Preferences preferences,
  });
}

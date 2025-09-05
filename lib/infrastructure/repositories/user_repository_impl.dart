import 'package:koozen_admin/core/entities/user_entity.dart';
import 'package:koozen_admin/core/repositories/user_repository.dart';

/// In-memory implementation of [UserRepository] for development and testing.
/// Replace with a real data source (e.g., Firebase Auth, REST API) in production.
class UserRepositoryImpl implements UserRepository {
  final List<UserEntity> _users = [];
  UserEntity? _currentUser;

  @override
  Future<List<UserEntity>> getUsers({
    String? role,
    String? searchQuery,
    int? limit,
    int? offset,
  }) async {
    var results = _users;

    if (role != null) {
      results = results.where((u) => u.role == role).toList();
    }

    if (searchQuery != null && searchQuery.isNotEmpty) {
      final q = searchQuery.toLowerCase();
      results = results
          .where((u) =>
              u.name.toLowerCase().contains(q) ||
              u.email.toLowerCase().contains(q))
          .toList();
    }

    if (offset != null && offset > 0) {
      results = results.skip(offset).toList();
    }

    if (limit != null && limit > 0 && limit < results.length) {
      results = results.take(limit).toList();
    }

    return results;
  }

  @override
  Future<UserEntity?> getUserById(String id) async {
    try {
      return _users.firstWhere((u) => u.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<UserEntity> createUser(UserEntity user) async {
    _users.add(user);
    return user;
  }

  @override
  Future<UserEntity> updateUser(UserEntity user) async {
    final index = _users.indexWhere((u) => u.id == user.id);
    if (index != -1) {
      _users[index] = user;
      return user;
    }
    throw Exception('User not found');
  }

  @override
  Future<void> deleteUser(String id) async {
    _users.removeWhere((u) => u.id == id);
  }

  @override
  Future<UserEntity?> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = _users.firstWhere(
        (u) => u.email == email && u.password == password,
      );
      _currentUser = user;
      return user;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> logout() async {
    _currentUser = null;
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    return _currentUser;
  }

  @override
  Future<void> updatePermissions({
    required String userId,
    required List<String> newPermissions,
  }) async {
    final index = _users.indexWhere((u) => u.id == userId);
    if (index != -1) {
      final user = _users[index];
      _users[index] = user.copyWith(permissions: newPermissions);
    } else {
      throw Exception('User not found');
    }
  }

  @override
  Future<void> updatePreferences({
    required String userId,
    required Preferences preferences,
  }) async {
    final index = _users.indexWhere((u) => u.id == userId);
    if (index != -1) {
      final user = _users[index];
      _users[index] = user.copyWith(preferences: preferences);
    } else {
      throw Exception('User not found');
    }
  }
}

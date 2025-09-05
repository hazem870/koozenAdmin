import 'dart:async';
import 'dart:math';

import 'package:koozen_admin/core/entities/user_entity.dart';
import 'package:koozen_admin/core/entities/preferences.dart';
import 'package:koozen_admin/core/repositories/user_repository.dart';
import 'package:koozen_admin/core/exceptions/network_exception.dart';

/// Mock API implementation of [UserRepository].
/// Simulates network latency and responses for development/testing.
class UserRepositoryMockApi implements UserRepository {
  final List<UserEntity> _users = [];
  UserEntity? _currentUser;
  final Random _random = Random();

  Future<void> _simulateNetworkDelay() async {
    await Future.delayed(Duration(milliseconds: 300 + _random.nextInt(700)));
  }

  void _maybeThrowNetworkError() {
    if (_random.nextDouble() < 0.05) {
      throw NetworkException('Simulated network failure');
    }
  }

  @override
  Future<List<UserEntity>> getUsers({
    String? role,
    String? searchQuery,
    int? limit,
    int? offset,
  }) async {
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();

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
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();
    try {
      return _users.firstWhere((u) => u.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<UserEntity> createUser(UserEntity user) async {
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();
    _users.add(user);
    return user;
  }

  @override
  Future<UserEntity> updateUser(UserEntity user) async {
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();
    final index = _users.indexWhere((u) => u.id == user.id);
    if (index != -1) {
      _users[index] = user;
      return user;
    }
    throw NetworkException('User not found', code: 'NOT_FOUND');
  }

  @override
  Future<void> deleteUser(String id) async {
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();
    _users.removeWhere((u) => u.id == id);
  }

  @override
  Future<UserEntity?> login({
    required String email,
    required String password,
  }) async {
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();
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
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();
    _currentUser = null;
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();
    return _currentUser;
  }

  @override
  Future<void> updatePermissions({
    required String userId,
    required List<String> newPermissions,
  }) async {
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();
    final index = _users.indexWhere((u) => u.id == userId);
    if (index != -1) {
      final user = _users[index];
      _users[index] = user.copyWith(permissions: newPermissions);
    } else {
      throw NetworkException('User not found', code: 'NOT_FOUND');
    }
  }

  @override
  Future<void> updatePreferences({
    required String userId,
    required Preferences preferences,
  }) async {
    await _simulateNetworkDelay();
    _maybeThrowNetworkError();
    final index = _users.indexWhere((u) => u.id == userId);
    if (index != -1) {
      final user = _users[index];
      _users[index] = user.copyWith(preferences: preferences);
    } else {
      throw NetworkException('User not found', code: 'NOT_FOUND');
    }
  }
}

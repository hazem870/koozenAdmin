import 'package:flutter_test/flutter_test.dart';
import 'package:koozen_admin/di/service_locator.dart';
import 'package:koozen_admin/core/entities/user_entity.dart';
import 'package:koozen_admin/core/entities/preferences.dart';
import 'package:koozen_admin/core/repositories/user_repository.dart';

void main() {
  setUp(() {
    setupServiceLocator();
  });

  test(
      'User workflow: register → list → login → update permissions → logout → delete',
      () async {
    final userRepo = sl<UserRepository>();

    // Step 1: Register a new user
    final user = UserEntity(
      id: 'u1',
      name: 'Hazem Admin',
      email: 'hazem@example.com',
      password: 'securePass123',
      role: 'admin',
      permissions: ['manage_products'],
      preferences: const Preferences(
          language: 'en',
          theme: 'light',
          languageCode: '',
          notificationsEnabled: null,
          themeMode: ''),
      isActive: null,
      createdAt: null,
      updatedAt: null,
    );

    await userRepo.createUser(user);

    // Step 2: List users
    var users = await userRepo.getUsers();
    expect(users.length, 1);
    expect(users.first.name, 'Hazem Admin');

    // Step 3: Login
    final loggedIn = await userRepo.login(
      email: 'hazem@example.com',
      password: 'securePass123',
    );
    expect(loggedIn, isNotNull);
    expect(loggedIn!.id, 'u1');

    // Step 4: Update permissions
    await userRepo.updatePermissions(
      userId: 'u1',
      newPermissions: ['manage_products', 'manage_orders'],
    );
    final updatedUser = await userRepo.getUserById('u1');
    expect(updatedUser!.permissions.contains('manage_orders'), true);

    // Step 5: Logout
    await userRepo.logout();
    final currentUser = await userRepo.getCurrentUser();
    expect(currentUser, isNull);

    // Step 6: Delete user
    await userRepo.deleteUser('u1');
    users = await userRepo.getUsers();
    expect(users.isEmpty, true);
  });
}

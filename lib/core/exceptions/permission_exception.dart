import 'package:koozen_admin/core/exceptions/app_exception.dart';

/// Exception thrown when a user attempts an action they are not authorized to perform.
/// Useful for enforcing role-based access control (RBAC) and permission checks.
class PermissionException extends AppException {
  const PermissionException(
    String message, {
    this.requiredPermission,
    String? code,
    Object? cause,
    StackTrace? stackTrace,
  }) : super(
          message,
          code: code ?? 'PERMISSION_DENIED',
          cause: cause,
          stackTrace: stackTrace,
        );

  /// The specific permission or role required for the attempted action.
  final String? requiredPermission;

  @override
  String toString() {
    final buffer = StringBuffer('PermissionException: $message');
    if (code != null) buffer.write(' [code: $code]');
    if (requiredPermission != null) {
      buffer.write(', requiredPermission: $requiredPermission');
    }
    if (cause != null) buffer.write(', cause: $cause');
    return buffer.toString();
  }
}

/// Base class for all application-level exceptions in Koozen Admin.
/// Extend this class to create specific exception types for different error domains.
class AppException implements Exception {
  const AppException(
    this.message, {
    this.code,
    this.cause,
    this.stackTrace,
  });

  /// A human-readable error message.
  final String message;

  /// An optional machine-readable error code (e.g., 'NETWORK_ERROR', 'DB_TIMEOUT').
  final String? code;

  /// An optional underlying cause (another exception or error).
  final Object? cause;

  /// Optional stack trace for debugging.
  final StackTrace? stackTrace;

  @override
  String toString() {
    final buffer = StringBuffer('AppException: $message');
    if (code != null) buffer.write(' (code: $code)');
    if (cause != null) buffer.write(', cause: $cause');
    return buffer.toString();
  }
}

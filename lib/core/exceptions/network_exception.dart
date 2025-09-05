import 'package:koozen_admin/core/exceptions/app_exception.dart';

/// Exception thrown when a network request fails.
/// Covers connectivity issues, timeouts, and invalid responses.
class NetworkException extends AppException {
  const NetworkException(
    String message, {
    String? code,
    Object? cause,
    StackTrace? stackTrace,
    this.statusCode,
  }) : super(
          message,
          code: code ?? 'NETWORK_ERROR',
          cause: cause,
          stackTrace: stackTrace,
        );

  /// Optional HTTP status code if available.
  final int? statusCode;

  @override
  String toString() {
    final buffer = StringBuffer('NetworkException: $message');
    if (statusCode != null) buffer.write(' (HTTP $statusCode)');
    if (code != null) buffer.write(' [code: $code]');
    if (cause != null) buffer.write(', cause: $cause');
    return buffer.toString();
  }
}

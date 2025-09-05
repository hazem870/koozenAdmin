import 'package:koozen_admin/core/exceptions/app_exception.dart';

/// Exception thrown when validation of input or business rules fails.
/// Can contain multiple field-level errors for detailed feedback.
class ValidationException extends AppException {
  const ValidationException(
    String message, {
    this.fieldErrors = const {},
    String? code,
    Object? cause,
    StackTrace? stackTrace,
  }) : super(
          message,
          code: code ?? 'VALIDATION_ERROR',
          cause: cause,
          stackTrace: stackTrace,
        );

  /// Map of field names to error messages.
  /// Example: { 'email': 'Invalid email format', 'password': 'Too short' }
  final Map<String, String> fieldErrors;

  bool get hasFieldErrors => fieldErrors.isNotEmpty;

  @override
  String toString() {
    final buffer = StringBuffer('ValidationException: $message');
    if (code != null) buffer.write(' [code: $code]');
    if (hasFieldErrors) buffer.write(', fieldErrors: $fieldErrors');
    if (cause != null) buffer.write(', cause: $cause');
    return buffer.toString();
  }
}

/// Base failure class for domain-level error handling
abstract class Failure {
  final String message;
  final int? code;

  const Failure({required this.message, this.code});

  @override
  String toString() => 'Failure($message, code: $code)';
}

/// Network failures (API, timeout, connection)
class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, super.code});
}

/// Server failures (500, 502, etc.)
class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.code});
}

/// Authentication failures (401, 403)
class AuthFailure extends Failure {
  const AuthFailure({required super.message, super.code});
}

/// Validation failures (400, client errors)
class ValidationFailure extends Failure {
  final Map<String, List<String>>? fieldErrors;

  const ValidationFailure({
    required super.message,
    super.code,
    this.fieldErrors,
  });
}

/// Cache / local storage failures
class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.code});
}

/// Not found failures (404)
class NotFoundFailure extends Failure {
  const NotFoundFailure({required super.message, super.code});
}

/// Unknown / unexpected failures
class UnexpectedFailure extends Failure {
  const UnexpectedFailure({super.message = 'Đã xảy ra lỗi không xác định', super.code});
}

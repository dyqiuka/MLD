/// Base exception class for data-layer exceptions
class AppException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  const AppException({required this.message, this.statusCode, this.data});

  @override
  String toString() => 'AppException($message, statusCode: $statusCode)';
}

/// Thrown when server returns an error response (4xx, 5xx)
class ServerException extends AppException {
  const ServerException({required super.message, super.statusCode, super.data});
}

/// Thrown when network is unreachable (no internet, DNS failure)
class NetworkException extends AppException {
  const NetworkException({
    super.message = 'Không có kết nối mạng. Vui lòng kiểm tra internet.',
    super.statusCode,
  });
}

/// Thrown when request times out
class TimeoutException extends AppException {
  const TimeoutException({
    super.message = 'Yêu cầu đã hết thời gian chờ. Vui lòng thử lại.',
    super.statusCode,
  });
}

/// Thrown when token is expired or invalid
class UnauthorizedException extends AppException {
  const UnauthorizedException({
    super.message = 'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.',
    super.statusCode,
  });
}

/// Thrown when local cache read/write fails
class CacheException extends AppException {
  const CacheException({
    super.message = 'Lỗi truy xuất dữ liệu cục bộ.',
    super.statusCode,
  });
}

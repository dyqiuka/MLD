import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'api_endpoints.dart';

/// Lightweight HTTP client wrapper (no Dio dependency needed for MVP)
/// Handles JSON requests/responses, auth tokens, and error mapping
class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  ApiClient._internal();

  final HttpClient _httpClient = HttpClient();
  String? _authToken;
  String? _refreshToken;

  static const Duration _timeout = Duration(seconds: 30);

  String? get refreshToken => _refreshToken;

  /// Set auth tokens after login
  void setTokens({required String accessToken, String? refreshToken}) {
    _authToken = accessToken;
    _refreshToken = refreshToken;
  }

  /// Clear auth tokens on logout
  void clearTokens() {
    _authToken = null;
    _refreshToken = null;
  }

  bool get isAuthenticated => _authToken != null;

  /// GET request
  Future<ApiResponse> get(String endpoint, {Map<String, String>? queryParams}) async {
    return _request('GET', endpoint, queryParams: queryParams);
  }

  /// POST request
  Future<ApiResponse> post(String endpoint, {Map<String, dynamic>? body}) async {
    return _request('POST', endpoint, body: body);
  }

  /// PUT request
  Future<ApiResponse> put(String endpoint, {Map<String, dynamic>? body}) async {
    return _request('PUT', endpoint, body: body);
  }

  /// PATCH request
  Future<ApiResponse> patch(String endpoint, {Map<String, dynamic>? body}) async {
    return _request('PATCH', endpoint, body: body);
  }

  /// DELETE request
  Future<ApiResponse> delete(String endpoint) async {
    return _request('DELETE', endpoint);
  }

  /// Core request handler with error mapping
  Future<ApiResponse> _request(
    String method,
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? queryParams,
  }) async {
    try {
      final uri = _buildUri(endpoint, queryParams);
      
      final request = await _createRequest(method, uri);
      _addHeaders(request);

      if (body != null && (method == 'POST' || method == 'PUT' || method == 'PATCH')) {
        request.headers.contentType = ContentType.json;
        request.write(jsonEncode(body));
      }

      final response = await request.close().timeout(_timeout);
      final responseBody = await response.transform(utf8.decoder).join();

      final statusCode = response.statusCode;
      final data = responseBody.isNotEmpty ? jsonDecode(responseBody) : null;

      if (statusCode >= 200 && statusCode < 300) {
        return ApiResponse(
          statusCode: statusCode,
          data: data,
          isSuccess: true,
        );
      }

      return ApiResponse(
        statusCode: statusCode,
        data: data,
        isSuccess: false,
        message: _extractErrorMessage(data, statusCode),
      );
    } on SocketException {
      return ApiResponse(
        statusCode: 0,
        isSuccess: false,
        message: 'Không có kết nối mạng. Vui lòng kiểm tra internet.',
      );
    } on TimeoutException {
      return ApiResponse(
        statusCode: 408,
        isSuccess: false,
        message: 'Yêu cầu đã hết thời gian chờ. Vui lòng thử lại.',
      );
    } catch (e) {
      debugPrint('ApiClient Error: $e');
      return ApiResponse(
        statusCode: -1,
        isSuccess: false,
        message: 'Đã xảy ra lỗi không xác định.',
      );
    }
  }

  Uri _buildUri(String endpoint, Map<String, String>? queryParams) {
    final uri = Uri.parse('${ApiEndpoints.baseUrl}$endpoint');
    if (queryParams != null && queryParams.isNotEmpty) {
      return uri.replace(queryParameters: queryParams);
    }
    return uri;
  }

  Future<HttpClientRequest> _createRequest(String method, Uri uri) {
    switch (method) {
      case 'GET':
        return _httpClient.getUrl(uri);
      case 'POST':
        return _httpClient.postUrl(uri);
      case 'PUT':
        return _httpClient.putUrl(uri);
      case 'PATCH':
        return _httpClient.patchUrl(uri);
      case 'DELETE':
        return _httpClient.deleteUrl(uri);
      default:
        return _httpClient.getUrl(uri);
    }
  }

  void _addHeaders(HttpClientRequest request) {
    request.headers.add('Accept', 'application/json');
    request.headers.add('X-Platform', Platform.isIOS ? 'ios' : 'android');
    if (_authToken != null) {
      request.headers.add('Authorization', 'Bearer $_authToken');
    }
  }

  String _extractErrorMessage(dynamic data, int statusCode) {
    if (data is Map<String, dynamic>) {
      return data['message'] as String? ??
          data['error'] as String? ??
          'Lỗi máy chủ ($statusCode)';
    }
    return 'Lỗi máy chủ ($statusCode)';
  }
}

/// Standardized API response wrapper
class ApiResponse {
  final int statusCode;
  final dynamic data;
  final bool isSuccess;
  final String? message;

  const ApiResponse({
    required this.statusCode,
    this.data,
    required this.isSuccess,
    this.message,
  });

  /// Extract data field from standard API response envelope
  T? extract<T>(T Function(Map<String, dynamic>) fromJson) {
    if (data is Map<String, dynamic>) {
      final payload = data['data'];
      if (payload is Map<String, dynamic>) {
        return fromJson(payload);
      }
    }
    return null;
  }

  /// Extract list from API response
  List<T> extractList<T>(T Function(Map<String, dynamic>) fromJson) {
    if (data is Map<String, dynamic>) {
      final payload = data['data'];
      if (payload is List) {
        return payload
            .whereType<Map<String, dynamic>>()
            .map((e) => fromJson(e))
            .toList();
      }
    }
    return [];
  }
}

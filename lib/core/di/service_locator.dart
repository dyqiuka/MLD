import '../network/api_client.dart';
import '../storage/local_storage.dart';

/// Simple Service Locator pattern for Dependency Injection
/// Avoids heavy packages like GetIt for this project's scope
class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();

  // ──────────────── Singletons ────────────────
  final ApiClient apiClient = ApiClient();
  final LocalStorage localStorage = LocalStorage();

  bool _initialized = false;

  /// Initialize all core services
  /// Call this in main.dart before runApp
  Future<void> init() async {
    if (_initialized) return;

    // Initialize local storage
    await localStorage.init();

    // Restore auth tokens from storage if available
    final savedToken = localStorage.accessToken;
    final savedRefresh = localStorage.refreshToken;
    if (savedToken != null) {
      apiClient.setTokens(
        accessToken: savedToken,
        refreshToken: savedRefresh,
      );
    }

    _initialized = true;
  }

  /// Reset all services (e.g., on logout)
  Future<void> reset() async {
    apiClient.clearTokens();
    await localStorage.clearAuth();
    await localStorage.clearCache();
  }
}

/// Global convenience accessor
final sl = ServiceLocator();

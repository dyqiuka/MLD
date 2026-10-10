import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Local storage abstraction using SharedPreferences
/// Handles auth tokens, user preferences, cached data, and onboarding state
class LocalStorage {
  static final LocalStorage _instance = LocalStorage._internal();
  factory LocalStorage() => _instance;
  LocalStorage._internal();

  SharedPreferences? _prefs;

  /// Initialize storage (call in main.dart before runApp)
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  SharedPreferences get _storage {
    if (_prefs == null) {
      throw StateError('LocalStorage not initialized. Call init() first.');
    }
    return _prefs!;
  }

  // ──────────────── Auth Tokens ────────────────
  static const String _keyAccessToken = 'auth_access_token';
  static const String _keyRefreshToken = 'auth_refresh_token';
  static const String _keyUserId = 'auth_user_id';

  Future<void> saveAuthTokens({
    required String accessToken,
    String? refreshToken,
    String? userId,
  }) async {
    await _storage.setString(_keyAccessToken, accessToken);
    if (refreshToken != null) await _storage.setString(_keyRefreshToken, refreshToken);
    if (userId != null) await _storage.setString(_keyUserId, userId);
  }

  String? get accessToken => _storage.getString(_keyAccessToken);
  String? get refreshToken => _storage.getString(_keyRefreshToken);
  String? get userId => _storage.getString(_keyUserId);

  Future<void> clearAuth() async {
    await _storage.remove(_keyAccessToken);
    await _storage.remove(_keyRefreshToken);
    await _storage.remove(_keyUserId);
  }

  bool get isLoggedIn => accessToken != null;

  // ──────────────── User Preferences ────────────────
  static const String _keyThemeMode = 'pref_theme_mode';
  static const String _keyLanguage = 'pref_language';
  static const String _keyNotificationsEnabled = 'pref_notifications';
  static const String _keyOnboardingComplete = 'pref_onboarding_done';

  Future<void> setThemeMode(String mode) async {
    await _storage.setString(_keyThemeMode, mode);
  }
  String get themeMode => _storage.getString(_keyThemeMode) ?? 'system';

  Future<void> setLanguage(String langCode) async {
    await _storage.setString(_keyLanguage, langCode);
  }
  String get language => _storage.getString(_keyLanguage) ?? 'vi';

  Future<void> setNotificationsEnabled(bool enabled) async {
    await _storage.setBool(_keyNotificationsEnabled, enabled);
  }
  bool get notificationsEnabled => _storage.getBool(_keyNotificationsEnabled) ?? true;

  Future<void> setOnboardingComplete(bool complete) async {
    await _storage.setBool(_keyOnboardingComplete, complete);
  }
  bool get onboardingComplete => _storage.getBool(_keyOnboardingComplete) ?? false;

  // ──────────────── Cached Data ────────────────
  
  /// Cache JSON data with a TTL
  Future<void> cacheData(String key, dynamic data, {Duration ttl = const Duration(hours: 1)}) async {
    final cacheEntry = {
      'data': data,
      'expiresAt': DateTime.now().add(ttl).millisecondsSinceEpoch,
    };
    await _storage.setString('cache_$key', jsonEncode(cacheEntry));
  }

  /// Retrieve cached data if not expired
  dynamic getCachedData(String key) {
    final raw = _storage.getString('cache_$key');
    if (raw == null) return null;
    
    try {
      final entry = jsonDecode(raw) as Map<String, dynamic>;
      final expiresAt = entry['expiresAt'] as int;
      if (DateTime.now().millisecondsSinceEpoch > expiresAt) {
        _storage.remove('cache_$key'); // Expired - clean up
        return null;
      }
      return entry['data'];
    } catch (_) {
      return null;
    }
  }

  /// Clear all cached data
  Future<void> clearCache() async {
    final keys = _storage.getKeys().where((k) => k.startsWith('cache_'));
    for (final key in keys) {
      await _storage.remove(key);
    }
  }

  // ──────────────── Recent Search ────────────────
  static const String _keyRecentSearches = 'recent_searches';
  static const int _maxRecentSearches = 10;

  Future<void> addRecentSearch(String query) async {
    final searches = recentSearches;
    searches.remove(query);
    searches.insert(0, query);
    if (searches.length > _maxRecentSearches) {
      searches.removeLast();
    }
    await _storage.setStringList(_keyRecentSearches, searches);
  }

  List<String> get recentSearches =>
      _storage.getStringList(_keyRecentSearches) ?? [];

  Future<void> clearRecentSearches() async {
    await _storage.remove(_keyRecentSearches);
  }

  // ──────────────── Full Reset ────────────────
  Future<void> clearAll() async {
    await _storage.clear();
  }
}

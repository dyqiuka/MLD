import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:prj/core/constants/app_constants.dart';
import 'package:prj/features/profile_membership/domain/models/membership_model.dart';

class ProfileController extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  String _currentLanguage = 'vi';
  List<VoucherModel> _vouchers = [];
  int _loyaltyPoints = 1850;
  String _tierName = 'Gold';

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  String get currentLanguage => _currentLanguage;
  List<VoucherModel> get vouchers => _vouchers;
  int get loyaltyPoints => _loyaltyPoints;
  String get tierName => _tierName;
  MembershipTierInfo get currentTierInfo => MembershipTierInfo.getByName(_tierName);

  ProfileController() {
    _initPreferences();
    _vouchers = List.from(AppConstants.sampleVouchers);
  }

  Future<void> _initPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('is_dark_mode') ?? false;
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    _currentLanguage = prefs.getString('language') ?? 'vi';
    notifyListeners();
  }

  Future<void> toggleDarkMode(bool enabled) async {
    _themeMode = enabled ? ThemeMode.dark : ThemeMode.light;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_dark_mode', enabled);
    notifyListeners();
  }

  void addPoints(int points) {
    _loyaltyPoints += points;
    if (_loyaltyPoints >= 7000) {
      _tierName = 'Diamond';
    } else if (_loyaltyPoints >= 3000) {
      _tierName = 'Platinum';
    } else if (_loyaltyPoints >= 1000) {
      _tierName = 'Gold';
    } else {
      _tierName = 'Silver';
    }
    notifyListeners();
  }
}

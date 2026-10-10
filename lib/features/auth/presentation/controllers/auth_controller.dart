import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:prj/core/constants/app_constants.dart';
import 'package:prj/features/auth/domain/models/user_model.dart';

class AuthController extends ChangeNotifier {
  UserModel? _currentUser;
  bool _isAuthenticated = true; // Auto logged-in for smooth experience
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  AuthController() {
    _initUser();
  }

  Future<void> _initUser() async {
    final prefs = await SharedPreferences.getInstance();
    final roleName = prefs.getString('user_role');
    if (roleName == UserRole.student.name) {
      _currentUser = AppConstants.defaultStudentUser;
    } else {
      _currentUser = AppConstants.defaultPatientUser;
    }
    _isAuthenticated = true;
    notifyListeners();
  }

  Future<bool> login({
    required String identifier, // Phone or Email
    required String passwordOrOtp,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 900));

    // Simulation logic
    if (identifier.isEmpty) {
      _errorMessage = 'Vui lòng nhập số điện thoại hoặc email';
      _isLoading = false;
      notifyListeners();
      return false;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', 'mld_token_jwt_${DateTime.now().millisecondsSinceEpoch}');

    _currentUser ??= AppConstants.defaultPatientUser;
    _isAuthenticated = true;
    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<bool> register({
    required String name,
    required String phone,
    required String email,
    required UserRole role,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 1000));

    final newUser = UserModel(
      id: 'usr_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: email,
      phone: phone,
      avatarUrl: role == UserRole.student
          ? 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150'
          : 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150',
      role: role,
      membershipTier: 'Silver',
      loyaltyPoints: 100,
      studentId: role == UserRole.student ? 'MLD-K24-${(100 + DateTime.now().second)}' : null,
      specialization: role == UserRole.student ? 'Kỹ thuật viên Y khoa Đa khoa' : null,
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_role', role.name);
    await prefs.setString('auth_token', 'mld_token_jwt_${DateTime.now().millisecondsSinceEpoch}');

    _currentUser = newUser;
    _isAuthenticated = true;
    _isLoading = false;
    notifyListeners();
    return true;
  }

  void switchRole(UserRole targetRole) async {
    if (targetRole == UserRole.student) {
      _currentUser = AppConstants.defaultStudentUser;
    } else {
      _currentUser = AppConstants.defaultPatientUser;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_role', targetRole.name);
    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    _isAuthenticated = false;
    _currentUser = null;
    notifyListeners();
  }
}

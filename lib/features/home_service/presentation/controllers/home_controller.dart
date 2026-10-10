import 'package:flutter/material.dart';
import 'package:prj/core/constants/app_constants.dart';
import 'package:prj/features/home_service/domain/models/doctor_model.dart';
import 'package:prj/features/home_service/domain/models/service_model.dart';

class HomeController extends ChangeNotifier {
  List<ServiceModel> _services = [];
  List<DoctorModel> _doctors = [];
  String _selectedCategory = 'Tất cả';
  String _searchQuery = '';
  final bool _isLoading = false;

  List<ServiceModel> get services => _services;
  List<DoctorModel> get doctors => _doctors;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;
  bool get isLoading => _isLoading;

  final List<String> categories = [
    'Tất cả',
    'Khám Tổng Quát',
    'Tim Mạch',
    'Da Liễu',
    'Nha Khoa',
    'Nhi Khoa',
  ];

  HomeController() {
    _loadData();
  }

  void _loadData() {
    _services = List.from(AppConstants.sampleServices);
    _doctors = List.from(AppConstants.sampleDoctors);
    notifyListeners();
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  List<ServiceModel> get filteredServices {
    return _services.where((s) {
      final matchesCategory = _selectedCategory == 'Tất cả' || s.category == _selectedCategory;
      final matchesQuery = _searchQuery.isEmpty ||
          s.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          s.category.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesQuery;
    }).toList();
  }

  DoctorModel? getDoctorById(String id) {
    try {
      return _doctors.firstWhere((d) => d.id == id);
    } catch (_) {
      return null;
    }
  }

  ServiceModel? getServiceById(String id) {
    try {
      return _services.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }
}

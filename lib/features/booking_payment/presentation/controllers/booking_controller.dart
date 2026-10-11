import 'package:flutter/material.dart';
import 'package:prj/core/constants/app_constants.dart';
import 'package:prj/features/home_service/domain/models/doctor_model.dart';
import 'package:prj/features/home_service/domain/models/service_model.dart';
import 'package:prj/features/booking_payment/domain/models/booking_model.dart';

class BookingController extends ChangeNotifier {
  ServiceModel? _selectedService;
  DoctorModel? _selectedDoctor;
  String _selectedBranch = 'Chi nhánh mẫu 01 — Quận 3';
  String _branchAddress = '123 Đường Mẫu, Phường Mẫu, TP. Hồ Chí Minh';
  String _selectedSpecialist = 'Trần Minh Phương';
  String _specialistTitle = 'Kỹ thuật viên massage';
  bool _autoAssignSpecialist = false;
  
  DateTime _selectedDate = DateTime(2026, 10, 12);
  String _selectedTimeSlot = '14:00–15:00';
  
  String _customerName = 'Nguyễn Minh Anh';
  String _customerPhone = '0912 345 678';
  String _customerEmail = 'minh.anh@example.com';
  bool _isBookingForSelf = true;
  
  String _paymentChoice = 'deposit'; // 'deposit' or 'full'
  PaymentMethod _paymentMethod = PaymentMethod.vnpay;
  
  bool _isProcessingPayment = false;
  String? _paymentError;
  BookingModel? _lastConfirmedBooking;
  final List<BookingModel> _bookingHistory = [];

  // Getters
  ServiceModel? get selectedService => _selectedService ?? AppConstants.sampleServices.first;
  DoctorModel? get selectedDoctor => _selectedDoctor;
  String get selectedBranch => _selectedBranch;
  String get branchAddress => _branchAddress;
  String get selectedSpecialist => _selectedSpecialist;
  String get specialistTitle => _specialistTitle;
  bool get autoAssignSpecialist => _autoAssignSpecialist;
  DateTime get selectedDate => _selectedDate;
  String get selectedTimeSlot => _selectedTimeSlot;
  String get customerName => _customerName;
  String get customerPhone => _customerPhone;
  String get customerEmail => _customerEmail;
  bool get isBookingForSelf => _isBookingForSelf;
  String get paymentChoice => _paymentChoice;
  PaymentMethod get paymentMethod => _paymentMethod;
  bool get isProcessingPayment => _isProcessingPayment;
  String? get paymentError => _paymentError;
  BookingModel? get lastConfirmedBooking => _lastConfirmedBooking;
  List<BookingModel> get bookingHistory => _bookingHistory;

  num get totalAmount => selectedService?.price ?? 450000;
  num get depositAmount => 150000;
  num get currentPayAmount => _paymentChoice == 'deposit' ? depositAmount : totalAmount;

  BookingController() {
    _selectedService = AppConstants.sampleServices.first;
    // Seed initial completed appointment matching Frame C09 and C10 of Figma Group C
    _bookingHistory.add(
      BookingModel(
        id: 'bk_demo_01',
        ticketCode: 'SPA-DEMO-000128',
        serviceId: 'srv_01',
        serviceName: 'Massage thư giãn toàn thân',
        doctorId: 'doc_01',
        doctorName: 'Trần Minh Phương',
        doctorTitle: 'Kỹ thuật viên massage',
        hospital: 'Chi nhánh mẫu 01 — Quận 3',
        appointmentDate: DateTime(2026, 10, 12),
        timeSlot: '14:00–15:00',
        patientName: 'Nguyễn Minh Anh',
        patientPhone: '0912 345 678',
        symptoms: 'Thư giãn cơ thể, xua tan căng thẳng',
        amount: 450000,
        paymentMethod: PaymentMethod.vnpay,
        paymentStatus: PaymentStatus.paid,
        bookingStatus: BookingStatus.confirmed,
        createdAt: DateTime(2026, 10, 8),
        qrPayload: 'SPA-DEMO-000128',
      ),
    );
  }

  void startBooking({ServiceModel? service, DoctorModel? doctor}) {
    if (service != null) {
      _selectedService = service;
    }
    if (doctor != null) {
      _selectedDoctor = doctor;
      _selectedSpecialist = doctor.name;
      _specialistTitle = doctor.title;
    }
    _paymentError = null;
    notifyListeners();
  }

  void selectService(ServiceModel service) {
    _selectedService = service;
    notifyListeners();
  }

  void selectBranch(String branch, String address) {
    _selectedBranch = branch;
    _branchAddress = address;
    notifyListeners();
  }

  void selectSpecialist({required String name, required String title, bool isAuto = false}) {
    _selectedSpecialist = name;
    _specialistTitle = title;
    _autoAssignSpecialist = isAuto;
    notifyListeners();
  }

  void selectDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void selectTimeSlot(String slot) {
    _selectedTimeSlot = slot;
    notifyListeners();
  }

  void setCustomerInfo({
    required String name,
    required String phone,
    required String email,
    required bool isSelf,
  }) {
    _customerName = name;
    _customerPhone = phone;
    _customerEmail = email;
    _isBookingForSelf = isSelf;
    notifyListeners();
  }

  void setPaymentChoice(String choice) {
    _paymentChoice = choice;
    notifyListeners();
  }

  void setPaymentMethod(PaymentMethod method) {
    _paymentMethod = method;
    notifyListeners();
  }

  double _discount = 0.0;
  double get discount => _discount;
  double get finalAmount => (totalAmount - _discount).clamp(0.0, double.infinity);

  bool applyPromoCode(String code) {
    if (code.trim().toUpperCase() == 'MEDIVIP200') {
      _discount = 200000;
      notifyListeners();
      return true;
    }
    _discount = 0;
    notifyListeners();
    return false;
  }

  Future<bool> processPayment() async {
    _isProcessingPayment = true;
    _paymentError = null;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 1200));

    final ticketCode = 'SPA-DEMO-${(100000 + DateTime.now().millisecond * 100).toString().substring(0, 6)}';
    final booking = BookingModel(
      id: 'bk_${DateTime.now().millisecondsSinceEpoch}',
      ticketCode: ticketCode,
      serviceId: selectedService?.id ?? 'srv_01',
      serviceName: selectedService?.name ?? 'Massage thư giãn toàn thân',
      doctorId: 'doc_01',
      doctorName: _selectedSpecialist,
      doctorTitle: _specialistTitle,
      hospital: _selectedBranch,
      appointmentDate: _selectedDate,
      timeSlot: _selectedTimeSlot,
      patientName: _customerName,
      patientPhone: _customerPhone,
      symptoms: 'Thư giãn trị liệu',
      amount: totalAmount,
      paymentMethod: _paymentMethod,
      paymentStatus: PaymentStatus.paid,
      bookingStatus: BookingStatus.confirmed,
      createdAt: DateTime.now(),
      qrPayload: ticketCode,
    );

    _lastConfirmedBooking = booking;
    _bookingHistory.insert(0, booking);
    _isProcessingPayment = false;
    notifyListeners();
    return true;
  }
}

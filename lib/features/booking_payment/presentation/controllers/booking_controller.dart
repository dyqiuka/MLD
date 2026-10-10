import 'package:flutter/material.dart';
import 'package:prj/core/constants/app_constants.dart';
import 'package:prj/features/home_service/domain/models/doctor_model.dart';
import 'package:prj/features/home_service/domain/models/service_model.dart';
import 'package:prj/features/booking_payment/domain/models/booking_model.dart';

enum BookingStep { selectDoctor, selectDateTime, intakeInfo, payment }

class BookingController extends ChangeNotifier {
  ServiceModel? _selectedService;
  DoctorModel? _selectedDoctor;
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  String? _selectedTimeSlot;
  PaymentMethod _paymentMethod = PaymentMethod.vnpay;
  String _symptoms = '';
  String _patientName = 'Nguyễn Thanh Tùng';
  String _patientPhone = '0988 123 456';
  num _discount = 0;
  String? _appliedPromoCode;

  // Booked slots simulation for locking
  final Set<String> _lockedSlots = {'08:30 - 09:00', '14:00 - 14:30'};

  bool _isProcessingPayment = false;
  String? _paymentError;
  BookingModel? _lastConfirmedBooking;
  final List<BookingModel> _bookingHistory = [];

  // Getters
  ServiceModel? get selectedService => _selectedService;
  DoctorModel? get selectedDoctor => _selectedDoctor;
  DateTime get selectedDate => _selectedDate;
  String? get selectedTimeSlot => _selectedTimeSlot;
  PaymentMethod get paymentMethod => _paymentMethod;
  String get symptoms => _symptoms;
  String get patientName => _patientName;
  String get patientPhone => _patientPhone;
  num get discount => _discount;
  String? get appliedPromoCode => _appliedPromoCode;
  bool get isProcessingPayment => _isProcessingPayment;
  String? get paymentError => _paymentError;
  BookingModel? get lastConfirmedBooking => _lastConfirmedBooking;
  List<BookingModel> get bookingHistory => _bookingHistory;

  BookingController() {
    // Seed initial completed booking
    _bookingHistory.add(
      BookingModel(
        id: 'bk_seed_01',
        ticketCode: 'MED-2026-9812',
        serviceId: 'srv_01',
        serviceName: 'Gói Khám Tổng Quát Toàn Diện VIP',
        doctorId: 'doc_01',
        doctorName: 'PGS. TS. BS. Nguyễn Văn Hùng',
        doctorTitle: 'Trưởng khoa Tim Mạch & Nội Khoa',
        hospital: 'Bệnh viện Đa khoa Quốc tế MLD Central',
        appointmentDate: DateTime.now().add(const Duration(days: 2)),
        timeSlot: '09:00 - 09:30',
        patientName: 'Nguyễn Thanh Tùng',
        patientPhone: '0988 123 456',
        symptoms: 'Kiểm tra sức khỏe định kỳ hàng năm',
        amount: 2850000,
        paymentMethod: PaymentMethod.vnpay,
        paymentStatus: PaymentStatus.paid,
        bookingStatus: BookingStatus.confirmed,
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
        qrPayload: 'MLD-TICKET-MED-2026-9812-PATIENT-01',
      ),
    );
  }

  void startBooking({
    required ServiceModel service,
    DoctorModel? doctor,
  }) {
    _selectedService = service;
    _selectedDoctor = doctor ?? AppConstants.sampleDoctors.first;
    _selectedTimeSlot = null;
    _symptoms = '';
    _discount = 0;
    _appliedPromoCode = null;
    _paymentError = null;
    notifyListeners();
  }

  void setDoctor(DoctorModel doctor) {
    _selectedDoctor = doctor;
    _selectedTimeSlot = null;
    notifyListeners();
  }

  void setDate(DateTime date) {
    _selectedDate = date;
    _selectedTimeSlot = null;
    notifyListeners();
  }

  void selectTimeSlot(String slot) {
    if (_lockedSlots.contains(slot)) return; // Locked slot cannot be selected
    _selectedTimeSlot = slot;
    notifyListeners();
  }

  bool isSlotLocked(String slot) {
    return _lockedSlots.contains(slot);
  }

  void setIntakeInfo({
    required String name,
    required String phone,
    required String symptoms,
  }) {
    _patientName = name;
    _patientPhone = phone;
    _symptoms = symptoms;
    notifyListeners();
  }

  void setPaymentMethod(PaymentMethod method) {
    _paymentMethod = method;
    notifyListeners();
  }

  bool applyPromoCode(String code) {
    if (code.trim().toUpperCase() == 'MEDIVIP200') {
      _discount = 200000;
      _appliedPromoCode = 'MEDIVIP200';
      notifyListeners();
      return true;
    }
    return false;
  }

  num get finalAmount {
    final base = _selectedService?.price ?? _selectedDoctor?.consultationFee ?? 500000;
    final total = base - _discount;
    return total > 0 ? total : 0;
  }

  Future<bool> processPayment() async {
    _isProcessingPayment = true;
    _paymentError = null;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 1600));

    // Create confirmed booking
    final ticketCode = 'MED-2026-${(1000 + DateTime.now().millisecond * 9)}';
    final booking = BookingModel(
      id: 'bk_${DateTime.now().millisecondsSinceEpoch}',
      ticketCode: ticketCode,
      serviceId: _selectedService?.id ?? 'srv_custom',
      serviceName: _selectedService?.name ?? 'Khám Chuyên Khoa Theo Yêu Cầu',
      doctorId: _selectedDoctor?.id ?? 'doc_01',
      doctorName: _selectedDoctor?.name ?? 'Bác sĩ chuyên khoa',
      doctorTitle: _selectedDoctor?.title ?? 'Bác sĩ',
      hospital: _selectedDoctor?.hospital ?? 'Bệnh viện Đa khoa MLD Central',
      appointmentDate: _selectedDate,
      timeSlot: _selectedTimeSlot ?? '08:00 - 08:30',
      patientName: _patientName,
      patientPhone: _patientPhone,
      symptoms: _symptoms.isEmpty ? 'Khám kiểm tra định kỳ' : _symptoms,
      amount: finalAmount,
      paymentMethod: _paymentMethod,
      paymentStatus: PaymentStatus.paid,
      bookingStatus: BookingStatus.confirmed,
      createdAt: DateTime.now(),
      qrPayload: 'MLD-TICKET-$ticketCode',
    );

    _lastConfirmedBooking = booking;
    _bookingHistory.insert(0, booking);
    _isProcessingPayment = false;
    notifyListeners();
    return true;
  }
}

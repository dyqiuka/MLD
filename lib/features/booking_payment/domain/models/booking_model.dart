enum BookingStatus {
  confirmed,
  inProgress,
  completed,
  cancelled,
}

enum PaymentMethod {
  vnpay,
  momo,
  zalopay,
  creditCard,
  cashAtClinic,
}

enum PaymentStatus {
  unpaid,
  paid,
  refunded,
  failed,
}

extension PaymentMethodExtension on PaymentMethod {
  String get displayName {
    switch (this) {
      case PaymentMethod.vnpay:
        return 'Cổng VNPay (QR & Thẻ ATM)';
      case PaymentMethod.momo:
        return 'Ví điện tử MoMo';
      case PaymentMethod.zalopay:
        return 'Ví ZaloPay';
      case PaymentMethod.creditCard:
        return 'Thẻ Quốc Tế Visa / Mastercard';
      case PaymentMethod.cashAtClinic:
        return 'Thanh toán trực tiếp tại viện';
    }
  }

  String get shortName {
    switch (this) {
      case PaymentMethod.vnpay:
        return 'VNPay';
      case PaymentMethod.momo:
        return 'MoMo';
      case PaymentMethod.zalopay:
        return 'ZaloPay';
      case PaymentMethod.creditCard:
        return 'Visa/Master';
      case PaymentMethod.cashAtClinic:
        return 'Tiền mặt';
    }
  }
}

class BookingModel {
  final String id;
  final String ticketCode; // e.g. MED-2026-9812
  final String serviceId;
  final String serviceName;
  final String doctorId;
  final String doctorName;
  final String doctorTitle;
  final String hospital;
  final DateTime appointmentDate;
  final String timeSlot;
  final String patientName;
  final String patientPhone;
  final String symptoms;
  final num amount;
  final PaymentMethod paymentMethod;
  final PaymentStatus paymentStatus;
  final BookingStatus bookingStatus;
  final DateTime createdAt;
  final String qrPayload;

  const BookingModel({
    required this.id,
    required this.ticketCode,
    required this.serviceId,
    required this.serviceName,
    required this.doctorId,
    required this.doctorName,
    required this.doctorTitle,
    required this.hospital,
    required this.appointmentDate,
    required this.timeSlot,
    required this.patientName,
    required this.patientPhone,
    required this.symptoms,
    required this.amount,
    required this.paymentMethod,
    this.paymentStatus = PaymentStatus.paid,
    this.bookingStatus = BookingStatus.confirmed,
    required this.createdAt,
    required this.qrPayload,
  });
}

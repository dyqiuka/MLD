import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'package:prj/core/utils/formatters.dart';
import 'package:prj/core/widgets/custom_button.dart';
import 'package:prj/features/booking_payment/presentation/controllers/booking_controller.dart';
import 'package:prj/features/booking_payment/domain/models/booking_model.dart';
import 'booking_success_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _voucherController = TextEditingController(text: 'MEDIVIP200');
  String? _voucherMessage;

  @override
  void dispose() {
    _voucherController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookingCtrl = context.watch<BookingController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final service = bookingCtrl.selectedService;
    final doctor = bookingCtrl.selectedDoctor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh Toán Lịch Khám'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Summary Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Thông tin lịch hẹn',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.medical_services_outlined, size: 18, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          service?.name ?? 'Khám chuyên khoa',
                          style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.person_outline, size: 18, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${doctor?.title} ${doctor?.name}',
                          style: TextStyle(
                            fontSize: 13,
                            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.calendar_month_outlined, size: 18, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Text(
                        '${bookingCtrl.selectedTimeSlot} • ${Formatters.formatDate(bookingCtrl.selectedDate)}',
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Voucher Promo Code Input
            Text(
              'Mã ưu đãi / Voucher',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _voucherController,
                    decoration: InputDecoration(
                      hintText: 'Nhập mã giảm giá...',
                      prefixIcon: const Icon(Icons.confirmation_number_outlined, size: 20),
                      fillColor: isDark ? AppColors.surfaceDark : const Color(0xFFF1F5F9),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                CustomButton(
                  text: 'Áp dụng',
                  height: 48,
                  onPressed: () {
                    final ok = bookingCtrl.applyPromoCode(_voucherController.text);
                    setState(() {
                      _voucherMessage = ok
                          ? 'Đã áp dụng mã MEDIVIP200 (-200.000₫)'
                          : 'Mã ưu đãi không hợp lệ';
                    });
                  },
                ),
              ],
            ),
            if (_voucherMessage != null) ...[
              const SizedBox(height: 6),
              Text(
                _voucherMessage!,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: bookingCtrl.discount > 0 ? AppColors.success : AppColors.error,
                ),
              ),
            ],
            const SizedBox(height: 24),

            // Payment Methods
            Text(
              'Chọn phương thức thanh toán',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 12),
            _PaymentMethodOption(
              method: PaymentMethod.vnpay,
              title: 'Cổng VNPay',
              subtitle: 'Thanh toán quét mã QR & thẻ ATM nội địa',
              icon: Icons.qr_code_scanner,
              iconColor: const Color(0xFF005BAA),
              isSelected: bookingCtrl.paymentMethod == PaymentMethod.vnpay,
              onTap: () => bookingCtrl.setPaymentMethod(PaymentMethod.vnpay),
            ),
            _PaymentMethodOption(
              method: PaymentMethod.momo,
              title: 'Ví MoMo',
              subtitle: 'Thanh toán siêu tốc qua ứng dụng MoMo',
              icon: Icons.account_balance_wallet_outlined,
              iconColor: const Color(0xFFA50064),
              isSelected: bookingCtrl.paymentMethod == PaymentMethod.momo,
              onTap: () => bookingCtrl.setPaymentMethod(PaymentMethod.momo),
            ),
            _PaymentMethodOption(
              method: PaymentMethod.zalopay,
              title: 'Ví ZaloPay',
              subtitle: 'Thanh toán an toàn bảo mật qua ZaloPay',
              icon: Icons.wallet,
              iconColor: const Color(0xFF0068FF),
              isSelected: bookingCtrl.paymentMethod == PaymentMethod.zalopay,
              onTap: () => bookingCtrl.setPaymentMethod(PaymentMethod.zalopay),
            ),
            _PaymentMethodOption(
              method: PaymentMethod.creditCard,
              title: 'Thẻ Quốc Tế Visa / Mastercard',
              subtitle: 'Thanh toán bằng thẻ tín dụng & ghi nợ quốc tế',
              icon: Icons.credit_card,
              iconColor: const Color(0xFF1A1F71),
              isSelected: bookingCtrl.paymentMethod == PaymentMethod.creditCard,
              onTap: () => bookingCtrl.setPaymentMethod(PaymentMethod.creditCard),
            ),
            _PaymentMethodOption(
              method: PaymentMethod.cashAtClinic,
              title: 'Thanh toán tại viện',
              subtitle: 'Đóng tiền tại quầy tiếp nhận trước giờ khám',
              icon: Icons.local_atm,
              iconColor: AppColors.secondary,
              isSelected: bookingCtrl.paymentMethod == PaymentMethod.cashAtClinic,
              onTap: () => bookingCtrl.setPaymentMethod(PaymentMethod.cashAtClinic),
            ),
            const SizedBox(height: 24),

            // Price Breakdown
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF131F37) : const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Chi phí dịch vụ:'),
                      Text(Formatters.formatCurrency(service?.price ?? 500000)),
                    ],
                  ),
                  if (bookingCtrl.discount > 0) ...[
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Giảm giá ưu đãi:', style: TextStyle(color: AppColors.success)),
                        Text(
                          '-${Formatters.formatCurrency(bookingCtrl.discount)}',
                          style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.success),
                        ),
                      ],
                    ),
                  ],
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tổng thanh toán:',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        Formatters.formatCurrency(bookingCtrl.finalAmount),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Pay Button
            CustomButton(
              text: 'Xác Nhận & Thanh Toán',
              width: double.infinity,
              isLoading: bookingCtrl.isProcessingPayment,
              onPressed: () async {
                final navigator = Navigator.of(context);
                final success = await bookingCtrl.processPayment();
                if (success && mounted && bookingCtrl.lastConfirmedBooking != null) {
                  navigator.pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => BookingSuccessScreen(booking: bookingCtrl.lastConfirmedBooking!),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _PaymentMethodOption extends StatelessWidget {
  final PaymentMethod method;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentMethodOption({
    required this.method,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isSelected ? AppColors.primary : (isDark ? AppColors.borderDark : AppColors.borderLight),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 11.5,
            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
          ),
        ),
        trailing: Icon(
          isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
          color: isSelected ? AppColors.primary : Colors.grey,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'package:prj/core/widgets/custom_button.dart';
import 'package:prj/features/booking_payment/presentation/controllers/booking_controller.dart';
import 'package:prj/features/booking_payment/domain/models/booking_model.dart';
import 'booking_flow_screen.dart';
import 'package:prj/features/treatment_care/presentation/screens/my_treatment_packages_screen.dart';
import 'package:prj/features/treatment_care/presentation/screens/pre_service_intake_screen.dart';

/// Frame C10 in Group C: Chi tiết lịch hẹn
class AppointmentDetailScreen extends StatelessWidget {
  final BookingModel? booking;

  const AppointmentDetailScreen({super.key, this.booking});

  @override
  Widget build(BuildContext context) {
    final bookingCtrl = context.watch<BookingController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final item = booking ?? (bookingCtrl.bookingHistory.isNotEmpty ? bookingCtrl.bookingHistory.first : null);

    final serviceName = item?.serviceName ?? 'Massage thư giãn toàn thân';
    final branchName = item?.hospital ?? 'Chi nhánh mẫu 01 — Quận 3';
    final specialistName = item?.doctorName ?? 'Trần Minh Phương';
    final customerName = item?.patientName ?? 'Nguyễn Minh Anh';
    final ticketCode = item?.ticketCode ?? 'SPA-DEMO-000128';
    final timeSlot = item?.timeSlot ?? '14:00–15:00';

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.surfaceDark : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isDark ? AppColors.borderDark : const Color(0xFFE5DDD5),
                        ),
                      ),
                      child: const Icon(Icons.arrow_back, color: AppColors.textPrimary, size: 20),
                    ),
                  ),
                  const Text(
                    'ĐẶT LỊCH · MINH HỌA',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF8B5E34),
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                children: [
                  // Title
                  Text(
                    'Chi tiết lịch hẹn',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Badge
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Đã xác nhận (mô phỏng)',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Code Note
                  Text(
                    '$ticketCode · Tình huống minh họa, không phải giao dịch thực',
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? AppColors.textMutedDark : AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Ticket Card
                  Container(
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.surfaceDark : Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: isDark ? AppColors.borderDark : const Color(0xFFE5DDD5),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                          child: Image.network(
                            'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?w=600',
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                serviceName,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 12),

                              _DetailRow(
                                label: 'Thời lượng chăm sóc',
                                value: '60 phút',
                                isDark: isDark,
                              ),
                              const SizedBox(height: 10),

                              _DetailRow(
                                label: branchName,
                                value: '',
                                isBold: true,
                                isDark: isDark,
                              ),
                              Text(
                                '123 Đường Mẫu, Phường Mẫu, TP. Hồ Chí Minh · Địa chỉ minh họa',
                                style: TextStyle(
                                  fontSize: 12.5,
                                  color: isDark ? AppColors.textMutedDark : AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 12),

                              _DetailRow(
                                label: 'Ngày hẹn',
                                value: '12/10/2026',
                                isDark: isDark,
                              ),
                              const SizedBox(height: 10),

                              _DetailRow(
                                label: 'Giờ chăm sóc',
                                value: timeSlot,
                                isDark: isDark,
                              ),
                              const SizedBox(height: 10),

                              Text(
                                'Chuẩn bị / vệ sinh sau buổi: 15 phút. Chiếm dụng nguồn lực 14:00–15:15, không tính vào 60 phút chăm sóc.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDark ? AppColors.textMutedDark : AppColors.textSecondary,
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 12),

                              _DetailRow(
                                label: 'Chuyên viên: $specialistName',
                                value: '',
                                isDark: isDark,
                              ),
                              const SizedBox(height: 6),

                              _DetailRow(
                                label: 'Khách hàng: $customerName',
                                value: '',
                                isDark: isDark,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Group D Actions: Phiếu thông tin trước dịch vụ & Gói liệu trình
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PreServiceIntakeScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.assignment_outlined, size: 18, color: Color(0xFF8B5E34)),
                    label: const Text(
                      'Phiếu thông tin trước dịch vụ (Group D)',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF8B5E34)),
                    ),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      side: const BorderSide(color: Color(0xFF8B5E34)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MyTreatmentPackagesScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.spa_outlined, size: 18, color: Color(0xFF8B5E34)),
                    label: const Text(
                      'Xem gói liệu trình của tôi (Group D)',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF8B5E34)),
                    ),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      side: const BorderSide(color: Color(0xFF8B5E34)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),

            // Bottom Sticky Bar: Đổi lịch
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                border: Border(
                  top: BorderSide(
                    color: isDark ? AppColors.borderDark : const Color(0xFFE5DDD5),
                  ),
                ),
              ),
              child: CustomButton(
                text: 'Đổi lịch',
                width: double.infinity,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BookingFlowScreen(initialStep: 3), // Go to select datetime
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final bool isDark;

  const _DetailRow({
    required this.label,
    required this.value,
    this.isBold = false,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
            ),
          ),
        ),
        if (value.isNotEmpty)
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
            ),
          ),
      ],
    );
  }
}

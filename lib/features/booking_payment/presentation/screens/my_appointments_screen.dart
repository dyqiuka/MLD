import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'package:prj/core/utils/formatters.dart';
import 'package:prj/core/widgets/empty_state.dart';
import 'package:prj/core/widgets/status_badge.dart';
import 'package:prj/features/booking_payment/presentation/controllers/booking_controller.dart';
import 'package:prj/features/booking_payment/domain/models/booking_model.dart';

class MyAppointmentsScreen extends StatefulWidget {
  const MyAppointmentsScreen({super.key});

  @override
  State<MyAppointmentsScreen> createState() => _MyAppointmentsScreenState();
}

class _MyAppointmentsScreenState extends State<MyAppointmentsScreen> {
  int _selectedFilterIndex = 0; // 0: Sắp tới, 1: Đã hoàn thành, 2: Đã hủy
  final List<String> _filters = ['Sắp tới', 'Đã hoàn thành', 'Đã hủy'];

  @override
  Widget build(BuildContext context) {
    final booking = context.watch<BookingController>();
    
    // Logic Lọc (Mocking)
    List<BookingModel> displayList = [];
    if (_selectedFilterIndex == 0) {
      displayList = booking.bookingHistory.where((e) => e.bookingStatus == BookingStatus.confirmed).toList();
    } else if (_selectedFilterIndex == 1) {
      displayList = booking.bookingHistory.where((e) => e.bookingStatus == BookingStatus.completed).toList();
    } else {
      displayList = booking.bookingHistory.where((e) => e.bookingStatus == BookingStatus.cancelled).toList();
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('ĐẶT LỊCH · MINH HỌA', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.primary, letterSpacing: 1.0)),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text('Lịch hẹn của tôi', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
            child: Text('Quản lý các buổi chăm sóc đã đặt.', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
          ),
          const SizedBox(height: 16),
          
          // Filter Tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: List.generate(_filters.length, (index) {
                final isSelected = _selectedFilterIndex == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedFilterIndex = index),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: isSelected ? AppColors.primary : AppColors.borderLight),
                    ),
                    child: Text(
                      _filters[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : AppColors.textPrimary,
                        fontSize: 13,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 16),
          
          // Date Range & Filter Dropdowns
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Khoảng ngày', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('12/10/2026 - 31/10/2026', style: TextStyle(fontSize: 13, color: AppColors.textPrimary, fontWeight: FontWeight.w500)),
                      Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.textSecondary),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Text('Chi nhánh / Dịch vụ / Trạng thái', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tất cả · Tất cả · Đã xác nhận', style: TextStyle(fontSize: 13, color: AppColors.textPrimary, fontWeight: FontWeight.w500)),
                      Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.textSecondary),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ListView
          Expanded(
            child: displayList.isEmpty
                ? const EmptyState(
                    icon: Icons.event_busy,
                    title: 'Chưa có lịch hẹn',
                    message: 'Bạn chưa có lịch hẹn nào trong danh sách này.',
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    itemCount: displayList.length,
                    itemBuilder: (context, index) {
                      final item = displayList[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.borderLight),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                              child: Image.network(
                                'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?w=400', // Massage img mock
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  StatusBadge(
                                    label: 'Đã xác nhận (mô phỏng)',
                                    status: BadgeStatus.success,
                                    fontSize: 10,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    item.serviceName,
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Ngày hẹn', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                                      Text(Formatters.formatDate(item.appointmentDate), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Giờ hẹn', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                                      Text(item.timeSlot, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                                    ],
                                  ),
                                  const Divider(height: 24, color: AppColors.borderLight),
                                  Text('Chi nhánh: ${item.hospital}', style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                                  const SizedBox(height: 4),
                                  Text('Chuyên viên: ${item.doctorName}', style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                                  const SizedBox(height: 4),
                                  Text('Khách hàng: ${item.patientName}', style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

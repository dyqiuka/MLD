import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prj/core/constants/app_constants.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'package:prj/core/utils/formatters.dart';
import 'package:prj/core/widgets/custom_button.dart';
import 'package:prj/core/widgets/custom_text_field.dart';
import 'package:prj/features/booking_payment/presentation/controllers/booking_controller.dart';
import 'payment_screen.dart';

class BookingFlowScreen extends StatefulWidget {
  const BookingFlowScreen({super.key});

  @override
  State<BookingFlowScreen> createState() => _BookingFlowScreenState();
}

class _BookingFlowScreenState extends State<BookingFlowScreen> {
  final _nameController = TextEditingController(text: 'Nguyễn Thanh Tùng');
  final _phoneController = TextEditingController(text: '0988 123 456');
  final _symptomsController = TextEditingController(text: 'Tái khám định kỳ và kiểm tra huyết áp');

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _symptomsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookingCtrl = context.watch<BookingController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final doctors = AppConstants.sampleDoctors;
    final selectedDoctor = bookingCtrl.selectedDoctor ?? doctors.first;

    // Generate next 7 days
    final now = DateTime.now();
    final daysList = List.generate(7, (i) => now.add(Duration(days: i + 1)));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đặt Lịch Khám'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // STEP 1: Select Doctor
            Text(
              '1. Chọn Bác sĩ / Chuyên gia',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 130,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  final doc = doctors[index];
                  final isSelected = selectedDoctor.id == doc.id;

                  return InkWell(
                    onTap: () => bookingCtrl.setDoctor(doc),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: 140,
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? (isDark ? const Color(0xFF0C244C) : AppColors.primaryLight)
                            : Theme.of(context).cardTheme.color,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : (isDark ? AppColors.borderDark : AppColors.borderLight),
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundImage: NetworkImage(doc.avatarUrl),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            doc.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: isSelected ? AppColors.primary : (isDark ? Colors.white : AppColors.textPrimaryLight),
                            ),
                          ),
                          Text(
                            doc.specialty,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 10,
                              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // STEP 2: Select Date
            Text(
              '2. Chọn Ngày khám',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 78,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: daysList.length,
                itemBuilder: (context, index) {
                  final day = daysList[index];
                  final isSelected = bookingCtrl.selectedDate.year == day.year &&
                      bookingCtrl.selectedDate.month == day.month &&
                      bookingCtrl.selectedDate.day == day.day;

                  return InkWell(
                    onTap: () => bookingCtrl.setDate(day),
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      width: 68,
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : (isDark ? AppColors.cardDark : Colors.white),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : (isDark ? AppColors.borderDark : AppColors.borderLight),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            Formatters.formatDayOfWeek(day).substring(0, 5),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white70 : (isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${day.day}/${day.month}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: isSelected ? Colors.white : (isDark ? Colors.white : AppColors.textPrimaryLight),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // STEP 3: Select Time Slot (with Locked Slots)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '3. Chọn Khung giờ khám',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                  ),
                ),
                Text(
                  '(Khóa slot đã kín)',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: selectedDoctor.availableSlots.map((slot) {
                final isLocked = bookingCtrl.isSlotLocked(slot);
                final isSelected = bookingCtrl.selectedTimeSlot == slot;

                if (isLocked) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF162035) : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isDark ? const Color(0xFF22304C) : const Color(0xFFE2E8F0),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.lock_outline, size: 14, color: isDark ? Colors.white30 : Colors.black38),
                        const SizedBox(width: 6),
                        Text(
                          slot,
                          style: TextStyle(
                            fontSize: 12.5,
                            color: isDark ? Colors.white30 : Colors.black38,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return InkWell(
                  onTap: () => bookingCtrl.selectTimeSlot(slot),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : (isDark ? AppColors.cardDark : Colors.white),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? AppColors.primary : (isDark ? AppColors.borderDark : AppColors.borderLight),
                        width: isSelected ? 1.5 : 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 14,
                          color: isSelected ? Colors.white : AppColors.primary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          slot,
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                            color: isSelected ? Colors.white : (isDark ? Colors.white : AppColors.textPrimaryLight),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 28),

            // STEP 4: Patient Intake
            Text(
              '4. Thông tin Bệnh nhân & Triệu chứng',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 12),
            CustomTextField(
              label: 'Họ và tên người khám',
              controller: _nameController,
              prefixIcon: Icons.person_outline,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              label: 'Số điện thoại liên hệ',
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              prefixIcon: Icons.phone_outlined,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              label: 'Triệu chứng / Lý do khám',
              controller: _symptomsController,
              maxLines: 3,
              prefixIcon: Icons.notes_outlined,
            ),
            const SizedBox(height: 32),

            // Continue CTA
            CustomButton(
              text: 'Tiếp Tục Thanh Toán',
              width: double.infinity,
              onPressed: () {
                if (bookingCtrl.selectedTimeSlot == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Vui lòng chọn khung giờ khám còn trống!'),
                      backgroundColor: AppColors.error,
                    ),
                  );
                  return;
                }

                bookingCtrl.setIntakeInfo(
                  name: _nameController.text,
                  phone: _phoneController.text,
                  symptoms: _symptomsController.text,
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PaymentScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

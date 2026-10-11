import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'package:prj/features/treatment_care/presentation/controllers/treatment_controller.dart';

/// Frame D04 in Group D: Phiếu thông tin trước dịch vụ
class PreServiceIntakeScreen extends StatefulWidget {
  const PreServiceIntakeScreen({super.key});

  @override
  State<PreServiceIntakeScreen> createState() => _PreServiceIntakeScreenState();
}

class _PreServiceIntakeScreenState extends State<PreServiceIntakeScreen> {
  final List<String> _availableGoals = [
    'Thư giãn cơ thể.',
    'Giảm cảm giác căng thẳng.',
    'Chăm sóc làn da.',
    'Cải thiện chất lượng giấc ngủ.',
    'Giảm nhức mỏi cơ khớp.',
  ];

  @override
  Widget build(BuildContext context) {
    final treatmentCtrl = context.watch<TreatmentController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : const Color(0xFFFBF8F5),
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
                      child: const Icon(Icons.arrow_back, color: Color(0xFF2C241E), size: 20),
                    ),
                  ),
                  const Text(
                    'CHĂM SÓC · MINH HỌA',
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
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Phiếu thông tin trước dịch vụ',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2C241E),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Cung cấp một số thông tin để chuyên viên chuẩn bị trải nghiệm phù hợp.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF7A6E65),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Customer appointment card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.surfaceDark : const Color(0xFFF5ECE3),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isDark ? AppColors.borderDark : const Color(0xFFEADBCE),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.person_outline, color: Color(0xFF8B5E34), size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Nguyễn Minh Anh',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF2C241E),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '28 tuổi · 0912 345 678',
                            style: TextStyle(fontSize: 12.5, color: Color(0xFF5A4D41)),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Massage thư giãn toàn thân · 60 phút',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF2C241E)),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '15/10/2026 · 09:00–10:00',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Color(0xFF8B5E34)),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Buổi 05 · Lịch hẹn minh họa',
                            style: TextStyle(fontSize: 11.5, color: Color(0xFF8A7D73)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Section: Mong muốn cải thiện
                    const Text(
                      'Bạn mong muốn cải thiện trải nghiệm nào?',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2C241E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Bạn có thể chọn nhiều mong muốn.',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Color(0xFF7A6E65),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Checkbox option list
                    ..._availableGoals.map((goal) {
                      final isSelected = treatmentCtrl.selectedIntakeGoals.contains(goal);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: () {
                            treatmentCtrl.toggleIntakeGoal(goal);
                          },
                          borderRadius: BorderRadius.circular(14),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFF7F1EB)
                                  : (isDark ? AppColors.surfaceDark : Colors.white),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF8B5E34)
                                    : (isDark ? AppColors.borderDark : const Color(0xFFE5DDD5)),
                                width: isSelected ? 1.5 : 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    goal,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                      color: const Color(0xFF2C241E),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 22,
                                  height: 22,
                                  decoration: BoxDecoration(
                                    color: isSelected ? const Color(0xFF8B5E34) : Colors.transparent,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected ? const Color(0xFF8B5E34) : const Color(0xFFC7BDB5),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: isSelected
                                      ? const Icon(Icons.check, size: 14, color: Colors.white)
                                      : null,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // Bottom Sticky Bar: Lưu thông tin
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                border: Border(
                  top: BorderSide(
                    color: isDark ? AppColors.borderDark : const Color(0xFFE5DDD5),
                  ),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Đã lưu thông tin trước dịch vụ thành công!'),
                        backgroundColor: Color(0xFF8B5E34),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B5E34),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Lưu thông tin',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

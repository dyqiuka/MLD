import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'package:prj/features/treatment_care/presentation/controllers/treatment_controller.dart';
import 'package:prj/features/treatment_care/presentation/screens/home_care_guide_screen.dart';
import 'package:prj/features/treatment_care/presentation/screens/feedback_rating_screen.dart';
import 'package:prj/features/treatment_care/presentation/screens/pre_service_intake_screen.dart';

/// Frame D03 in Group D: Nhật ký chăm sóc
class CareJournalScreen extends StatelessWidget {
  const CareJournalScreen({super.key});

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
                    // Header
                    const Text(
                      'Nhật ký chăm sóc',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2C241E),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Theo dõi hành trình chăm sóc sức khỏe của bạn.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF7A6E65),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Profile Summary Card (Clickable -> Phiếu thông tin trước dịch vụ D04)
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const PreServiceIntakeScreen(),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
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
                                children: [
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: const Color(0xFFDFCEBE)),
                                    ),
                                    child: const Icon(Icons.person_outline, color: Color(0xFF8B5E34), size: 24),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'Nguyễn Minh Anh',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF2C241E),
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          'Gói Massage Thư Giãn 10 Buổi',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF8B5E34),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: const Color(0xFFDFCEBE)),
                                    ),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Phiếu thông tin',
                                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF8B5E34)),
                                        ),
                                        SizedBox(width: 2),
                                        Icon(Icons.chevron_right, size: 14, color: Color(0xFF8B5E34)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                '4 buổi hoàn thành  ·  Gần nhất 08/10/2026',
                                style: TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF3B2E24),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Expanded(
                                    child: Text(
                                      'Hồ sơ và liệu trình minh họa',
                                      style: TextStyle(
                                        fontSize: 11.5,
                                        color: Color(0xFF8A7D73),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Bấm để xem phiếu TT ›',
                                    style: TextStyle(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF8B5E34),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Quick Action 1: Phiếu thông tin trước dịch vụ (Direct button)
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const PreServiceIntakeScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.assignment_outlined, size: 18, color: Colors.white),
                        label: const Text(
                          'Phiếu thông tin trước dịch vụ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8B5E34),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Quick Action 2: Xem hướng dẫn chăm sóc
                    SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HomeCareGuideScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.spa_outlined, size: 18, color: Color(0xFF8B5E34)),
                        label: const Text(
                          'Xem hướng dẫn chăm sóc',
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF8B5E34),
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF8B5E34)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    const Text(
                      'Nhật ký minh họa · Ghi chú chăm sóc chung, không đánh giá kết quả y khoa.',
                      style: TextStyle(
                        fontSize: 11.5,
                        color: Color(0xFF9E9187),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Journal Items Timeline
                    ...treatmentCtrl.journalEntries.map((entry) => _buildJournalItem(context, entry, isDark)),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJournalItem(BuildContext context, dynamic entry, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.borderDark : const Color(0xFFEADBCE),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.check_circle, color: Color(0xFF8B5E34), size: 20),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F1EB),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  entry.date,
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF8B5E34),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          Text(
            entry.sessionTitle,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2C241E),
            ),
          ),
          const SizedBox(height: 4),

          Text(
            'Chuyên viên: ${entry.specialist}',
            style: const TextStyle(
              fontSize: 12.5,
              color: Color(0xFF5A4D41),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            entry.branch,
            style: const TextStyle(
              fontSize: 12.5,
              color: Color(0xFF7A6E65),
            ),
          ),
          const SizedBox(height: 8),

          Text(
            entry.note,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF3B2E24),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),

          // Suggestion box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFBF8F5),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE5DDD5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Gợi ý sau buổi · Minh họa',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF8B5E34),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  entry.tip,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF5A4D41),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Button to review / rating
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FeedbackRatingScreen()),
                );
              },
              icon: const Icon(Icons.star_outline, size: 16, color: Color(0xFF8B5E34)),
              label: const Text(
                'Đánh giá trải nghiệm',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF8B5E34)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

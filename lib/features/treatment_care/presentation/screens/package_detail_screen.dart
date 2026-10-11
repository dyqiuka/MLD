import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'package:prj/features/treatment_care/presentation/controllers/treatment_controller.dart';
import 'package:prj/features/treatment_care/domain/models/treatment_models.dart';
import 'package:prj/features/booking_payment/presentation/screens/booking_flow_screen.dart';
import 'package:prj/features/treatment_care/presentation/screens/pre_service_intake_screen.dart';
import 'package:prj/features/treatment_care/presentation/screens/care_journal_screen.dart';

/// Frame D02 in Group D: Chi tiết gói liệu trình
class PackageDetailScreen extends StatelessWidget {
  final TreatmentPackageModel? package;

  const PackageDetailScreen({super.key, this.package});

  @override
  Widget build(BuildContext context) {
    final treatmentCtrl = context.watch<TreatmentController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final pkg = package ?? treatmentCtrl.packages.first;

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
                      'Chi tiết gói liệu trình',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2C241E),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Hero Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        pkg.imageUrl,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 200,
                          color: const Color(0xFFE8DCCF),
                          child: const Icon(Icons.spa_outlined, size: 54, color: Color(0xFF8B5E34)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Status Badge
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFF10B981),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${pkg.status} · Gói minh họa',
                          style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF8B5E34),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Title
                    Text(
                      pkg.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2C241E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Ngày mua: ${pkg.startDate} · Hạn: ${pkg.expiryDate}',
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: Color(0xFF7A6E65),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      pkg.branch,
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: Color(0xFF7A6E65),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Box: Hành trình chăm sóc của bạn
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.surfaceDark : Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: isDark ? AppColors.borderDark : const Color(0xFFEADBCE),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hành trình chăm sóc của bạn',
                            style: TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2C241E),
                            ),
                          ),
                          const SizedBox(height: 16),

                          Row(
                            children: [
                              _buildStatCol('${pkg.totalSessions}', 'Tổng buổi'),
                              Container(width: 1, height: 28, color: const Color(0xFFE5DDD5)),
                              _buildStatCol('${pkg.usedSessions}', 'Đã dùng'),
                              Container(width: 1, height: 28, color: const Color(0xFFE5DDD5)),
                              _buildStatCol('${pkg.remainingSessions}', 'Còn lại'),
                            ],
                          ),
                          const SizedBox(height: 16),

                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: LinearProgressIndicator(
                              value: pkg.progressPercentage,
                              minHeight: 6,
                              backgroundColor: const Color(0xFFF1EAE4),
                              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF8B5E34)),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Đã hoàn thành ${(pkg.progressPercentage * 100).toInt()}% liệu trình',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF8B5E34),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Quick link to intake form (D04)
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PreServiceIntakeScreen(),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F3EE),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFEADBCE)),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.assignment_outlined, color: Color(0xFF8B5E34), size: 22),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Phiếu thông tin trước dịch vụ',
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF2C241E)),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Điền mong muốn cho buổi 05 sắp tới',
                                    style: TextStyle(fontSize: 11.5, color: Color(0xFF7A6E65)),
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.chevron_right, color: Color(0xFF8B5E34)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Quick link to journal (D03)
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CareJournalScreen(),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.surfaceDark : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: isDark ? AppColors.borderDark : const Color(0xFFEADBCE)),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.history_edu_outlined, color: Color(0xFF8B5E34), size: 22),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Lịch sử 4 buổi đã hoàn thành',
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF2C241E)),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Xem nhật ký và ghi chú sau buổi massage',
                                    style: TextStyle(fontSize: 11.5, color: Color(0xFF7A6E65)),
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.chevron_right, color: Color(0xFF8B5E34)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // Bottom Sticky Bar: Đặt lịch buổi tiếp theo (leads to Group C Booking Flow!)
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BookingFlowScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B5E34),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Đặt lịch buổi tiếp theo',
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

  Widget _buildStatCol(String val, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(
            val,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF2C241E),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11.5,
              color: Color(0xFF7A6E65),
            ),
          ),
        ],
      ),
    );
  }
}

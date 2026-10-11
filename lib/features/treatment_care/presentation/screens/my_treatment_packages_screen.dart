import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'package:prj/features/treatment_care/presentation/controllers/treatment_controller.dart';
import 'package:prj/features/treatment_care/domain/models/treatment_models.dart';
import 'care_journal_screen.dart';
import 'package:prj/features/treatment_care/presentation/screens/package_detail_screen.dart';

/// Frame D01 in Group D: Gói liệu trình của tôi
class MyTreatmentPackagesScreen extends StatefulWidget {
  const MyTreatmentPackagesScreen({super.key});

  @override
  State<MyTreatmentPackagesScreen> createState() => _MyTreatmentPackagesScreenState();
}

class _MyTreatmentPackagesScreenState extends State<MyTreatmentPackagesScreen> {
  int _selectedFilter = 0; // 0: Đang sử dụng, 1: Đã hoàn thành, 2: Hết hạn
  final List<String> _filters = ['Đang sử dụng', 'Đã hoàn thành', 'Hết hạn'];

  @override
  Widget build(BuildContext context) {
    final treatmentCtrl = context.watch<TreatmentController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final filteredPackages = treatmentCtrl.packages.where((pkg) {
      if (_selectedFilter == 0) return pkg.status == 'Đang sử dụng';
      if (_selectedFilter == 1) return pkg.status == 'Đã hoàn thành';
      return pkg.status == 'Hết hạn';
    }).toList();

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : const Color(0xFFFBF8F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Screen Header
              const Text(
                'Gói liệu trình của tôi',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2C241E),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Quản lý các gói chăm sóc sức khỏe và liệu trình đã đăng ký.',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF7A6E65),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 18),

              // Profile Card
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
                                'Hội viên Vàng · Ví dụ',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF8B5E34),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.workspace_premium_outlined, color: Color(0xFFC98A4B), size: 24),
                      ],
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      '2 gói đang dùng  ·  11 buổi còn lại  ·  7 đã dùng',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF3B2E24),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Hồ sơ và liệu trình minh họa',
                      style: TextStyle(
                        fontSize: 11.5,
                        color: Color(0xFF8A7D73),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Filter Tabs
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(_filters.length, (index) {
                    final isSelected = _selectedFilter == index;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: InkWell(
                        onTap: () => setState(() => _selectedFilter = index),
                        borderRadius: BorderRadius.circular(20),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF8B5E34)
                                : (isDark ? AppColors.surfaceDark : Colors.white),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF8B5E34)
                                  : (isDark ? AppColors.borderDark : const Color(0xFFE5DDD5)),
                            ),
                          ),
                          child: Text(
                            _filters[index],
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                              color: isSelected
                                  ? Colors.white
                                  : (isDark ? AppColors.textPrimaryDark : const Color(0xFF5A4D41)),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20),

              // Packages List
              if (filteredPackages.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.surfaceDark : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      'Không có gói liệu trình nào trong mục này.',
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                      ),
                    ),
                  ),
                )
              else
                ...filteredPackages.map((pkg) => _buildPackageCard(context, pkg, isDark)),

              const SizedBox(height: 16),
              // Action button to view Journal (D03)
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CareJournalScreen()),
                  );
                },
                icon: const Icon(Icons.history_edu_outlined, color: Color(0xFF8B5E34)),
                label: const Text(
                  'Xem nhật ký chăm sóc sức khỏe',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF8B5E34)),
                ),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  side: const BorderSide(color: Color(0xFF8B5E34)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPackageCard(BuildContext context, TreatmentPackageModel pkg, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColors.borderDark : const Color(0xFFEADBCE),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PackageDetailScreen(package: pkg),
              ),
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Header
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.network(
                  pkg.imageUrl,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 160,
                    color: const Color(0xFFE8DCCF),
                    child: const Icon(Icons.spa_outlined, size: 48, color: Color(0xFF8B5E34)),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pkg.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2C241E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      pkg.branch,
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: Color(0xFF7A6E65),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 3 Stats Column
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

                    // Progress bar
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
                    const SizedBox(height: 12),

                    Text(
                      'Hạn sử dụng: ${pkg.expiryDate} · Minh họa',
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: Color(0xFF9E9187),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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

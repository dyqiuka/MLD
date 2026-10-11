import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'package:prj/features/vocational_training/presentation/controllers/course_controller.dart';
import 'class_detail_screen.dart';
import 'class_schedule_screen.dart';

/// Frame E07 in Group E: Khóa học của tôi
class MyCoursesScreen extends StatefulWidget {
  const MyCoursesScreen({super.key});

  @override
  State<MyCoursesScreen> createState() => _MyCoursesScreenState();
}

class _MyCoursesScreenState extends State<MyCoursesScreen> {
  int _selectedFilter = 0; // 0: Đang học, 1: Sắp học, 2: Đã hoàn thành
  final List<String> _filters = ['Đang học', 'Sắp học', 'Đã hoàn thành'];

  @override
  Widget build(BuildContext context) {
    final courseCtrl = context.watch<CourseController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final enrolledCourse = courseCtrl.courses.first;

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
                    'Dữ liệu minh họa',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF9E9187),
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
                      'HỌC VIỆN ĐÀO TẠO',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF8B5E34),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Khóa học của tôi',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2C241E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Theo dõi quá trình học tập và phát triển kỹ năng.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF7A6E65),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // 3 Stats Box
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
                              _buildStatCol('3', 'đã ghi danh'),
                              Container(width: 1, height: 28, color: const Color(0xFFDFCEBE)),
                              _buildStatCol('1', 'đang học'),
                              Container(width: 1, height: 28, color: const Color(0xFFDFCEBE)),
                              _buildStatCol('1', 'hoàn thành'),
                            ],
                          ),
                          const SizedBox(height: 14),
                          const Text(
                            '120 giờ học  ·  1 khóa sắp học',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF3B2E24),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '96 giờ khóa cơ bản · 24 giờ khóa đang học. Số liệu minh họa.',
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
                        children: List.generate(_filters.length, (idx) {
                          final isSelected = _selectedFilter == idx;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: InkWell(
                              onTap: () => setState(() => _selectedFilter = idx),
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
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
                                  _filters[idx],
                                  style: TextStyle(
                                    fontSize: 12.5,
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

                    // Active Course Card
                    if (_selectedFilter == 0)
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
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF7F1EB),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'Đang học · MCN-0926',
                                style: TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF8B5E34),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),

                            Text(
                              enrolledCourse.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF2C241E),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${enrolledCourse.instructorName} · Khai giảng 18/09/2026',
                              style: const TextStyle(fontSize: 12.5, color: Color(0xFF7A6E65)),
                            ),
                            const SizedBox(height: 14),

                            // Progress
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  '4 / 20 bài học đã hoàn thành',
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF5A4D41)),
                                ),
                                Text(
                                  '20%',
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF8B5E34)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: const LinearProgressIndicator(
                                value: 0.20,
                                minHeight: 6,
                                backgroundColor: Color(0xFFF1EAE4),
                                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF8B5E34)),
                              ),
                            ),
                            const SizedBox(height: 14),

                            const Text(
                              'Bài tiếp theo: Bài 05 — Kỹ thuật Massage cơ bản',
                              style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: Color(0xFF2C241E)),
                            ),
                            const SizedBox(height: 16),

                            // Button: Tiếp tục học (leads to E08)
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ClassDetailScreen(course: enrolledCourse),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF8B5E34),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'Tiếp tục học',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.all(32),
                        alignment: Alignment.center,
                        child: Text(
                          _selectedFilter == 1
                              ? 'Chưa có khóa học nào sắp khai giảng.'
                              : 'Khóa học Kỹ thuật Massage Cơ Bản đã hoàn thành (100%).',
                          style: const TextStyle(color: Color(0xFF7A6E65)),
                        ),
                      ),

                    const SizedBox(height: 20),

                    // Shortcut to Class Schedule
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ClassScheduleScreen()),
                        );
                      },
                      icon: const Icon(Icons.calendar_month_outlined, color: Color(0xFF8B5E34)),
                      label: const Text(
                        'Xem lịch học & điểm danh (Frame E11)',
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
              fontSize: 18,
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

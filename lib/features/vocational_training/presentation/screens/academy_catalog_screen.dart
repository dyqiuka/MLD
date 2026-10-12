import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'package:prj/features/vocational_training/presentation/controllers/course_controller.dart';
import 'package:prj/features/vocational_training/domain/models/course_model.dart';
import 'course_discovery_screen.dart';
import 'course_detail_screen.dart';
import 'my_courses_screen.dart';
import 'class_schedule_screen.dart';
import 'learning_result_screen.dart';
import 'package:prj/features/notifications/presentation/screens/notifications_screen.dart';

/// Frame E01 in Group E: Học viện đào tạo (Catalog Home)
class AcademyCatalogScreen extends StatefulWidget {
  const AcademyCatalogScreen({super.key});

  @override
  State<AcademyCatalogScreen> createState() => _AcademyCatalogScreenState();
}

class _AcademyCatalogScreenState extends State<AcademyCatalogScreen> {
  String _selectedBranch = 'Chi nhánh mẫu 01 — Quận 3';

  @override
  Widget build(BuildContext context) {
    final courseCtrl = context.watch<CourseController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : const Color(0xFFFBF8F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Label
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'HỌC VIỆN ĐÀO TẠO',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF8B5E34),
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    'Dữ liệu minh họa',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF9E9187),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Title & Subtitle
              const Text(
                'Học viện đào tạo',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2C241E),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Kiến tạo kỹ năng – Phát triển nghề nghiệp',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF7A6E65),
                ),
              ),
              const SizedBox(height: 16),

              // User Greeting Pill with Avatar & Notification Icon
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark ? AppColors.borderDark : const Color(0xFFEADBCE),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5ECE3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'MA',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF8B5E34),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Xin chào, Minh Anh!',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2C241E),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Sẵn sàng nâng cao kỹ năng hôm nay?',
                            style: TextStyle(
                              fontSize: 11.5,
                              color: Color(0xFF7A6E65),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications_none_rounded, color: Color(0xFF8B5E34)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const NotificationsScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Branch Dropdown Selector
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark ? AppColors.borderDark : const Color(0xFFE5DDD5),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedBranch,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF8B5E34)),
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2C241E),
                    ),
                    items: [
                      'Chi nhánh mẫu 01 — Quận 3',
                      'Chi nhánh mẫu 02 — Bình Thạnh',
                      'Chi nhánh mẫu 03 — Cầu Giấy',
                    ].map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),
                    onChanged: (v) {
                      if (v != null) setState(() => _selectedBranch = v);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Hero Banner Card: Khởi đầu sự nghiệp cùng nghề Spa
              Container(
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : const Color(0xFFF7F1EB),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isDark ? AppColors.borderDark : const Color(0xFFEADBCE),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?w=800',
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 180,
                          color: const Color(0xFFE8DCCF),
                          child: const Icon(Icons.school_outlined, size: 48, color: Color(0xFF8B5E34)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'HỌC VIỆN ĐÀO TẠO NGHỀ',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF8B5E34),
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Khởi đầu sự nghiệp cùng nghề Spa',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF2C241E),
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Đào tạo thực hành, phát triển kỹ năng và nâng cao năng lực nghề nghiệp.',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF7A6E65),
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Button: Khám phá khóa học (leads to E02)
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const CourseDiscoveryScreen(),
                                  ),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Color(0xFF8B5E34)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Khám phá khóa học',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF8B5E34),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Quick Access Hub for Students: Khóa học của tôi | Lịch học | Kết quả
              Row(
                children: [
                  Expanded(
                    child: _buildHubItem(
                      icon: Icons.book_outlined,
                      label: 'Khóa học của tôi',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const MyCoursesScreen()),
                        );
                      },
                      isDark: isDark,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildHubItem(
                      icon: Icons.calendar_month_outlined,
                      label: 'Lịch học',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ClassScheduleScreen()),
                        );
                      },
                      isDark: isDark,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildHubItem(
                      icon: Icons.military_tech_outlined,
                      label: 'Kết quả',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const LearningResultScreen()),
                        );
                      },
                      isDark: isDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Featured Courses Preview
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'Chương trình đào tạo tiêu biểu',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2C241E),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CourseDiscoveryScreen()),
                      );
                    },
                    child: const Text(
                      'Xem tất cả',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF8B5E34)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              ...courseCtrl.courses.take(3).map((course) => _buildCourseCard(context, course, isDark)),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHubItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isDark ? AppColors.borderDark : const Color(0xFFEADBCE),
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF8B5E34), size: 22),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2C241E),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseCard(BuildContext context, CourseModel course, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.borderDark : const Color(0xFFEADBCE),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            context.read<CourseController>().selectCourse(course);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CourseDetailScreen(course: course)),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    course.thumbnailUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 80,
                      height: 80,
                      color: const Color(0xFFE8DCCF),
                      child: const Icon(Icons.school_outlined, color: Color(0xFF8B5E34)),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7F1EB),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          course.category,
                          style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: Color(0xFF8B5E34)),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        course.title,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF2C241E)),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'GV: ${course.instructorName}',
                        style: const TextStyle(fontSize: 12, color: Color(0xFF7A6E65)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${course.totalHours} giờ học · ${(course.tuitionFee / 1000000).toStringAsFixed(1)} triệu đồng',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF8B5E34)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

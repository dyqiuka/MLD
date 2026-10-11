import 'package:flutter/material.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'package:prj/features/vocational_training/domain/models/course_model.dart';
import 'instructor_detail_screen.dart';
import 'course_registration_screen.dart';

/// Frame E03 in Group E: Chi tiết khóa học
class CourseDetailScreen extends StatelessWidget {
  final CourseModel course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
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
                    // Course Title
                    Text(
                      course.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2C241E),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Hero Image with Share & Bookmark
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            course.thumbnailUrl,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              height: 200,
                              color: const Color(0xFFE8DCCF),
                              child: const Icon(Icons.school_outlined, size: 54, color: Color(0xFF8B5E34)),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Row(
                            children: [
                              _buildActionCircle(Icons.share_outlined, () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Đã sao chép liên kết khóa học!')),
                                );
                              }),
                              const SizedBox(width: 8),
                              _buildActionCircle(Icons.bookmark_border_rounded, () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Đã lưu khóa học vào danh sách quan tâm!')),
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Practical Highlights Box
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.surfaceDark : const Color(0xFFF7F1EB),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: isDark ? AppColors.borderDark : const Color(0xFFEADBCE),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Thực hành chuyên nghiệp · Minh họa',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF8B5E34),
                            ),
                          ),
                          const SizedBox(height: 14),

                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      '12',
                                      style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.w900,
                                        color: Color(0xFF8B5E34),
                                      ),
                                    ),
                                    Text(
                                      'tuần học',
                                      style: TextStyle(fontSize: 12, color: Color(0xFF7A6E65)),
                                    ),
                                  ],
                                ),
                              ),
                              Container(width: 1, height: 40, color: const Color(0xFFE5DDD5)),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${course.totalHours}',
                                      style: const TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.w900,
                                        color: Color(0xFF8B5E34),
                                      ),
                                    ),
                                    const Text(
                                      'giờ đào tạo',
                                      style: TextStyle(fontSize: 12, color: Color(0xFF7A6E65)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),

                          const Text(
                            '48 giờ lý thuyết · 96 giờ thực hành',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF3B2E24),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Học trực tiếp · Học phí ${(course.tuitionFee / 1000000).toStringAsFixed(1)} triệu đồng',
                            style: const TextStyle(
                              fontSize: 12.5,
                              color: Color(0xFF7A6E65),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),

                    // Section: Giới thiệu khóa học
                    const Text(
                      'Giới thiệu khóa học',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2C241E),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      course.description.isNotEmpty
                          ? course.description
                          : 'Chương trình đào tạo thực hành chuyên nghiệp chuẩn quốc tế 12 tuần với 144 giờ đào tạo. Khởi đầu sự nghiệp cùng nghề Spa tại Chi nhánh mẫu 01 — Quận 3.',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF5A4D41),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Instructor Preview Card (leads to E04)
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => InstructorDetailScreen(
                              instructorName: course.instructorName,
                              instructorTitle: course.instructorTitle,
                              avatarUrl: course.instructorAvatar,
                            ),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.surfaceDark : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isDark ? AppColors.borderDark : const Color(0xFFEADBCE),
                          ),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: Image.network(
                                course.instructorAvatar,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  width: 50,
                                  height: 50,
                                  color: const Color(0xFFE8DCCF),
                                  child: const Icon(Icons.person, color: Color(0xFF8B5E34)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    course.instructorName,
                                    style: const TextStyle(
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF2C241E),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    course.instructorTitle,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF7A6E65),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.chevron_right, color: Color(0xFF8B5E34)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // Bottom Sticky Bar: Đăng ký khóa học (leads to E05)
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
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Học phí minh họa',
                          style: TextStyle(fontSize: 11, color: Color(0xFF7A6E65)),
                        ),
                        Text(
                          '${(course.tuitionFee / 1000000).toStringAsFixed(0)}.000.000đ',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF8B5E34),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CourseRegistrationScreen(course: course),
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
                          'Đăng ký khóa học',
                          style: TextStyle(
                            fontSize: 14.5,
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
          ],
        ),
      ),
    );
  }

  Widget _buildActionCircle(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.45),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}

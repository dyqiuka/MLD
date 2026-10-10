import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'package:prj/core/utils/formatters.dart';
import 'package:prj/core/widgets/custom_button.dart';
import 'package:prj/core/widgets/status_badge.dart';
import 'package:prj/features/vocational_training/domain/models/course_model.dart';
import '../controllers/course_controller.dart';
import 'lesson_player_screen.dart';

class CourseDetailScreen extends StatelessWidget {
  final CourseModel course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final courseCtrl = context.watch<CourseController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final activeCourse = courseCtrl.courses.firstWhere(
      (c) => c.id == course.id,
      orElse: () => course,
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Sliver Hero Header
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.45),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    activeCourse.thumbnailUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(color: AppColors.primary),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.2),
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.8),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 20,
                    right: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StatusBadge(label: activeCourse.category, status: BadgeStatus.gold),
                        Row(
                          children: [
                            const Icon(Icons.star, color: AppColors.gold, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              '${activeCourse.rating} (${activeCourse.studentsCount} học viên)',
                              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activeCourse.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Metadata Row
                  Row(
                    children: [
                      _MetaItem(icon: Icons.schedule, text: '${activeCourse.totalHours} giờ học', isDark: isDark),
                      const SizedBox(width: 10),
                      _MetaItem(icon: Icons.play_lesson, text: '${activeCourse.totalLessons} bài giảng', isDark: isDark),
                      const SizedBox(width: 10),
                      _MetaItem(icon: Icons.workspace_premium, text: 'Chứng nhận Viện', isDark: isDark),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Instructor Profile
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardTheme.color,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark ? AppColors.borderDark : AppColors.borderLight,
                      ),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundImage: NetworkImage(activeCourse.instructorAvatar),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                activeCourse.instructorName,
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                activeCourse.instructorTitle,
                                style: TextStyle(
                                  fontSize: 11.5,
                                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Description
                  Text(
                    'Giới thiệu chương trình học',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    activeCourse.description,
                    style: TextStyle(
                      fontSize: 13.5,
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Certificate Accreditation Box
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E2818) : const Color(0xFFECFDF5),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isDark ? const Color(0xFF065F46) : const Color(0xFFA7F3D0),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.verified, color: AppColors.success, size: 22),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Chuẩn Chứng Chỉ Cấp Phát:',
                                style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppColors.success),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                activeCourse.certificateTitle,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDark ? AppColors.textSecondaryDark : const Color(0xFF065F46),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Syllabus Modules
                  Text(
                    'Giáo trình bài giảng chi tiết',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...activeCourse.modules.map(
                    (module) => Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardTheme.color,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isDark ? AppColors.borderDark : AppColors.borderLight,
                        ),
                      ),
                      child: ExpansionTile(
                        initiallyExpanded: true,
                        title: Text(
                          module.title,
                          style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700),
                        ),
                        children: module.lessons.map(
                          (les) => ListTile(
                            leading: Icon(
                              les.isCompleted ? Icons.check_circle : Icons.play_circle_outline,
                              color: les.isCompleted ? AppColors.success : AppColors.primary,
                              size: 20,
                            ),
                            title: Text(
                              les.title,
                              style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w500),
                            ),
                            trailing: Text(
                              '${les.durationMinutes}p',
                              style: TextStyle(
                                fontSize: 11,
                                color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                              ),
                            ),
                            onTap: () {
                              courseCtrl.selectCourse(activeCourse);
                              courseCtrl.selectLesson(les);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => LessonPlayerScreen(course: activeCourse, lesson: les),
                                ),
                              );
                            },
                          ),
                        ).toList(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          border: Border(
            top: BorderSide(
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activeCourse.isEnrolled ? 'Tiến độ học tập' : 'Học phí khóa',
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                  Text(
                    activeCourse.isEnrolled
                        ? '${(activeCourse.progress * 100).toInt()}% hoàn thành'
                        : Formatters.formatCurrency(activeCourse.tuitionFee),
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: activeCourse.isEnrolled ? AppColors.secondary : AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: CustomButton(
                  text: activeCourse.isEnrolled ? 'Vào Học Ngay' : 'Đăng Ký Học Nghề',
                  onPressed: () {
                    final firstLesson = activeCourse.modules.isNotEmpty && activeCourse.modules.first.lessons.isNotEmpty
                        ? activeCourse.modules.first.lessons.first
                        : null;
                    if (firstLesson != null) {
                      courseCtrl.selectCourse(activeCourse);
                      courseCtrl.selectLesson(firstLesson);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LessonPlayerScreen(course: activeCourse, lesson: firstLesson),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetaItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isDark;

  const _MetaItem({
    required this.icon,
    required this.text,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.primary),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
            ),
          ),
        ],
      ),
    );
  }
}

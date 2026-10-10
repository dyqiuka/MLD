import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'package:prj/core/widgets/course_card.dart';
import 'package:prj/features/vocational_training/domain/models/course_model.dart';
import '../controllers/course_controller.dart';
import 'course_detail_screen.dart';
import 'quiz_assessment_screen.dart';

class AcademyCatalogScreen extends StatefulWidget {
  const AcademyCatalogScreen({super.key});

  @override
  State<AcademyCatalogScreen> createState() => _AcademyCatalogScreenState();
}

class _AcademyCatalogScreenState extends State<AcademyCatalogScreen> {
  String _selectedCategory = 'Tất cả';
  final List<String> _categories = [
    'Tất cả',
    'Điều dưỡng',
    'Chăm sóc cao tuổi',
    'Thẩm mỹ y khoa',
  ];

  @override
  Widget build(BuildContext context) {
    final courseCtrl = context.watch<CourseController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final filtered = courseCtrl.courses.where((CourseModel c) {
      if (_selectedCategory == 'Tất cả') return true;
      return c.category == _selectedCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Học Viện Nghề Y Dược'),
        actions: [
          IconButton(
            icon: const Icon(Icons.assignment_turned_in_outlined, color: AppColors.primary),
            tooltip: 'Làm bài thi đánh giá',
            onPressed: () {
              courseCtrl.resetQuiz();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const QuizAssessmentScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Academy Banner
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1E3A8A), Color(0xFF0284C7)],
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.gold,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'CHUẨN QUỐC TẾ',
                          style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Đào Tạo Nghề Y Dược Thực Chiến',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Học lý thuyết tương tác & Thực hành lâm sàng tại chuỗi bệnh viện MLD',
                        style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.9)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.school, size: 36, color: Colors.white),
                ),
              ],
            ),
          ),

          // Categories Filter Tabs
          SizedBox(
            height: 44,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final cat = _categories[index];
                final isSelected = _selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(
                      cat,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected ? Colors.white : (isDark ? Colors.white70 : AppColors.textPrimaryLight),
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (_) => setState(() => _selectedCategory = cat),
                    backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
                    selectedColor: AppColors.primary,
                    showCheckmark: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected ? AppColors.primary : (isDark ? AppColors.borderDark : AppColors.borderLight),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),

          // Course List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final course = filtered[index];
                return CourseCard(
                  course: course,
                  onTap: () {
                    courseCtrl.selectCourse(course);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CourseDetailScreen(course: course),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

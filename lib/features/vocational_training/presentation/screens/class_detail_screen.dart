import 'package:flutter/material.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'package:prj/features/vocational_training/domain/models/course_model.dart';
import 'lesson_player_screen.dart';
import 'class_schedule_screen.dart';

/// Frame E08 in Group E: Chi tiết lớp học
class ClassDetailScreen extends StatefulWidget {
  final CourseModel course;

  const ClassDetailScreen({super.key, required this.course});

  @override
  State<ClassDetailScreen> createState() => _ClassDetailScreenState();
}

class _ClassDetailScreenState extends State<ClassDetailScreen> {
  int _selectedTab = 0; // 0: Nội dung học, 1: Lịch học, 2: Tài liệu
  final List<String> _tabs = ['Nội dung học', 'Lịch học', 'Tài liệu'];

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
                    const Text(
                      'Chi tiết lớp học',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2C241E),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Class Card Summary
                    Container(
                      padding: const EdgeInsets.all(16),
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
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'Đang học · MCN-0926',
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF8B5E34)),
                            ),
                          ),
                          const SizedBox(height: 8),

                          Text(
                            widget.course.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF2C241E),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Giảng viên ${widget.course.instructorName}',
                            style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: Color(0xFF8B5E34)),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Chi nhánh mẫu 01 — Quận 3',
                            style: TextStyle(fontSize: 12, color: Color(0xFF7A6E65)),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Thứ 6–7–Chủ nhật · 13:00–17:00',
                            style: TextStyle(fontSize: 12, color: Color(0xFF7A6E65)),
                          ),
                          const SizedBox(height: 12),

                          // Progress bar
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                '4 / 20 bài học đã hoàn thành',
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF5A4D41)),
                              ),
                              Text(
                                '20%',
                                style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800, color: Color(0xFF8B5E34)),
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
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Tabs: [ Nội dung học ] [ Lịch học ] [ Tài liệu ]
                    Row(
                      children: List.generate(_tabs.length, (idx) {
                        final isSelected = _selectedTab == idx;
                        return Expanded(
                          child: InkWell(
                            onTap: () {
                              if (idx == 1) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const ClassScheduleScreen()),
                                );
                              } else {
                                setState(() => _selectedTab = idx);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: isSelected ? const Color(0xFF8B5E34) : Colors.transparent,
                                    width: 2.5,
                                  ),
                                ),
                              ),
                              child: Text(
                                _tabs[idx],
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                  color: isSelected ? const Color(0xFF8B5E34) : const Color(0xFF7A6E65),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 16),

                    // Curriculum Accordions
                    _buildModuleAccordion(
                      chapter: 'Chương 1: Giới thiệu nghề Spa',
                      subtitle: '3 bài học · Đã hoàn thành',
                      isCompleted: true,
                      lessons: [
                        {'title': 'Bài 1: Tổng quan ngành Spa', 'duration': 'Video · 12 phút', 'done': true},
                        {'title': 'Bài 2: Vệ sinh an toàn & tác phong', 'duration': 'Video · 15 phút', 'done': true},
                        {'title': 'Bài 3: Cấu trúc cơ và huyệt đạo', 'duration': 'Video · 20 phút', 'done': true},
                      ],
                      isDark: isDark,
                    ),
                    const SizedBox(height: 12),

                    _buildModuleAccordion(
                      chapter: 'Chương 2: Kỹ thuật Massage cơ bản',
                      subtitle: '2 bài học · Đang học',
                      isCompleted: false,
                      lessons: [
                        {'title': 'Bài 4: Kỹ thuật xoa bóp vùng lưng', 'duration': 'Video · 16 phút', 'done': true},
                        {'title': 'Bài 5: Kỹ thuật Massage cơ bản', 'duration': 'Video · 18 phút', 'done': false, 'current': true},
                      ],
                      isDark: isDark,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom Sticky Bar: Tiếp tục bài học (leads to E09)
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Bài 05 · Kỹ thuật Massage cơ bản',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF7A6E65)),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        final lesson = widget.course.modules.length > 1
                            ? widget.course.modules[1].lessons.last
                            : widget.course.modules.first.lessons.first;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LessonPlayerScreen(
                              course: widget.course,
                              lesson: lesson,
                            ),
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
                        'Tiếp tục bài học',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
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

  Widget _buildModuleAccordion({
    required String chapter,
    required String subtitle,
    required bool isCompleted,
    required List<Map<String, dynamic>> lessons,
    required bool isDark,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.borderDark : const Color(0xFFEADBCE),
        ),
      ),
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Text(
          chapter,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF2C241E)),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 11.5, color: Color(0xFF7A6E65)),
        ),
        children: lessons.map((l) {
          final isDone = l['done'] as bool;
          final isCurrent = l['current'] == true;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFF1EAE4))),
            ),
            child: Row(
              children: [
                Icon(
                  isCurrent ? Icons.play_circle_filled : (isDone ? Icons.check_circle : Icons.circle_outlined),
                  color: isCurrent ? const Color(0xFFD97706) : (isDone ? const Color(0xFF8B5E34) : const Color(0xFFC7BDB5)),
                  size: 22,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l['title'] as String,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                          color: isCurrent ? const Color(0xFF8B5E34) : const Color(0xFF2C241E),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l['duration'] as String,
                        style: const TextStyle(fontSize: 11.5, color: Color(0xFF7A6E65)),
                      ),
                    ],
                  ),
                ),
                if (isDone)
                  const Icon(Icons.check, size: 16, color: Color(0xFF8B5E34)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

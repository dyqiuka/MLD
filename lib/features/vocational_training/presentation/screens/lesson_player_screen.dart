import 'package:flutter/material.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'package:prj/features/vocational_training/domain/models/course_model.dart';
import 'quiz_assessment_screen.dart';

/// Frame E09 in Group E: Bài học (Lesson Player & Study Notes)
class LessonPlayerScreen extends StatefulWidget {
  final CourseModel course;
  final LessonModel lesson;

  const LessonPlayerScreen({
    super.key,
    required this.course,
    required this.lesson,
  });

  @override
  State<LessonPlayerScreen> createState() => _LessonPlayerScreenState();
}

class _LessonPlayerScreenState extends State<LessonPlayerScreen> {
  int _selectedTab = 0; // 0: Nội dung, 1: Tài liệu, 2: Ghi chú
  final List<String> _tabs = ['Nội dung', 'Tài liệu', 'Ghi chú'];
  bool _isPlaying = false;
  double _sliderValue = 3.33; // 3m20s of 18m

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
                    'Video minh họa',
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
                      'Bài học',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2C241E),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Video Mockup Player
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?w=800',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                color: Colors.black87,
                                child: const Icon(Icons.videocam, color: Colors.white, size: 48),
                              ),
                            ),
                            Container(
                              color: Colors.black.withValues(alpha: 0.35),
                            ),
                            // Center Play Button
                            Center(
                              child: InkWell(
                                onTap: () => setState(() => _isPlaying = !_isPlaying),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.5),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                                    color: Colors.white,
                                    size: 36,
                                  ),
                                ),
                              ),
                            ),
                            // Bottom Control Strip
                            Positioned(
                              bottom: 8,
                              left: 12,
                              right: 12,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        '03:20 / 18:00',
                                        style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        '1x · Full HD',
                                        style: TextStyle(color: Colors.white70, fontSize: 11),
                                      ),
                                    ],
                                  ),
                                  SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5),
                                      trackHeight: 3,
                                      activeTrackColor: const Color(0xFFD97706),
                                      inactiveTrackColor: Colors.white30,
                                      thumbColor: Colors.white,
                                    ),
                                    child: Slider(
                                      value: _sliderValue,
                                      max: 18.0,
                                      onChanged: (v) => setState(() => _sliderValue = v),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Lesson Meta
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F1EB),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Chương 2 · Video 18 phút',
                        style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: Color(0xFF8B5E34)),
                      ),
                    ),
                    const SizedBox(height: 8),

                    Text(
                      widget.lesson.title.isNotEmpty ? widget.lesson.title : 'Bài 05: Kỹ thuật Massage cơ bản',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2C241E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.course.title,
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF7A6E65)),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Giảng viên ${widget.course.instructorName}',
                      style: const TextStyle(fontSize: 12.5, color: Color(0xFF8B5E34), fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Ảnh và điều khiển video là minh họa tĩnh, không phát nội dung thực tế.',
                      style: TextStyle(fontSize: 11, color: Color(0xFF9E9187), fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 16),

                    // Tabs: [ Nội dung ] [ Tài liệu ] [ Ghi chú ]
                    Row(
                      children: List.generate(_tabs.length, (idx) {
                        final isSelected = _selectedTab == idx;
                        return Expanded(
                          child: InkWell(
                            onTap: () => setState(() => _selectedTab = idx),
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

                    // Section: Sau bài học này, bạn có thể
                    const Text(
                      'Sau bài học này, bạn có thể',
                      style: TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2C241E),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• Nắm vững tư thế đứng và điều chỉnh trọng tâm khi thao tác.\n'
                      '• Thực hiện thành thạo các động tác vuốt, miết, day và ấn huyệt cơ bản.\n'
                      '• Cảm nhận và điều chỉnh lực tiếp xúc phù hợp với phản hồi của khách hàng.',
                      style: TextStyle(fontSize: 12.5, color: Color(0xFF5A4D41), height: 1.5),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // Bottom Buttons: Hoàn thành bài học (leads to E10) & Bài tiếp theo
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
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const QuizAssessmentScreen(),
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
                        'Hoàn thành bài học',
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Đang chuyển sang bài tiếp theo...')),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFE5DDD5)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Bài tiếp theo',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF5A4D41),
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
}

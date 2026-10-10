import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'package:prj/core/widgets/custom_button.dart';
import 'package:prj/features/vocational_training/domain/models/course_model.dart';
import '../controllers/course_controller.dart';
import 'quiz_assessment_screen.dart';

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

class _LessonPlayerScreenState extends State<LessonPlayerScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final courseCtrl = context.watch<CourseController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final activeLesson = courseCtrl.currentLesson ?? widget.lesson;
    final speeds = [0.75, 1.0, 1.25, 1.5, 2.0];

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : Colors.white,
      appBar: AppBar(
        title: Text(
          widget.course.title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          // Simulated Cinematic Video Player
          Container(
            height: 220,
            width: double.infinity,
            color: Colors.black,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Video thumbnail background
                Opacity(
                  opacity: 0.45,
                  child: Image.network(
                    widget.course.thumbnailUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) => Container(color: Colors.black),
                  ),
                ),
                // Play / Pause Action Center
                IconButton(
                  iconSize: 56,
                  icon: Icon(
                    courseCtrl.isPlaying ? Icons.pause_circle_filled_rounded : Icons.play_circle_fill_rounded,
                    color: Colors.white,
                  ),
                  onPressed: courseCtrl.togglePlayPause,
                ),
                // Bottom Player Controls (Timeline, Timer, Fullscreen)
                Positioned(
                  bottom: 8,
                  left: 12,
                  right: 12,
                  child: Column(
                    children: [
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 3,
                          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                          overlayShape: const RoundSliderOverlayShape(overlayRadius: 10),
                          activeTrackColor: AppColors.primary,
                          inactiveTrackColor: Colors.white30,
                          thumbColor: AppColors.primary,
                        ),
                        child: Slider(
                          value: courseCtrl.currentPositionSeconds,
                          min: 0.0,
                          max: courseCtrl.totalDurationSeconds,
                          onChanged: courseCtrl.seekTo,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${(courseCtrl.currentPositionSeconds ~/ 60).toString().padLeft(2, '0')}:${(courseCtrl.currentPositionSeconds.toInt() % 60).toString().padLeft(2, '0')} / ${activeLesson.durationMinutes}:00',
                              style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.hd_outlined, color: Colors.white70, size: 18),
                                const SizedBox(width: 10),
                                const Icon(Icons.fullscreen_rounded, color: Colors.white, size: 20),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Speed Selector Row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : const Color(0xFFF8FAFC),
              border: Border(
                bottom: BorderSide(
                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                ),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.speed, size: 16, color: AppColors.primary),
                const SizedBox(width: 8),
                const Text('Tốc độ phát:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                const Spacer(),
                ...speeds.map((s) {
                  final isSelected = courseCtrl.playbackSpeed == s;
                  return Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: InkWell(
                      onTap: () => courseCtrl.setPlaybackSpeed(s),
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '${s}x',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: isSelected ? Colors.white : (isDark ? Colors.white70 : Colors.black87),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),

          // Lesson Title and Mark Completed Button
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activeLesson.title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        icon: Icon(
                          activeLesson.isCompleted ? Icons.check_circle : Icons.check_circle_outline,
                          color: activeLesson.isCompleted ? AppColors.success : AppColors.primary,
                          size: 18,
                        ),
                        label: Text(
                          activeLesson.isCompleted ? 'Đã hoàn thành bài học' : 'Đánh dấu đã học xong',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: activeLesson.isCompleted ? AppColors.success : AppColors.primary,
                          ),
                        ),
                        onPressed: () => courseCtrl.markLessonCompleted(activeLesson.id),
                      ),
                    ),
                    const SizedBox(width: 10),
                    CustomButton(
                      text: 'Làm Quiz',
                      height: 40,
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
              ],
            ),
          ),

          // Tabs: Syllabus & Notes
          TabBar(
            controller: _tabController,
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primary,
            unselectedLabelColor: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
            tabs: const [
              Tab(text: 'Danh sách bài học'),
              Tab(text: 'Tóm tắt bài giảng'),
            ],
          ),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // TAB 1: Lessons in Course
                ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: widget.course.modules.length,
                  itemBuilder: (context, modIdx) {
                    final module = widget.course.modules[modIdx];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          module.title,
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primary),
                        ),
                        const SizedBox(height: 8),
                        ...module.lessons.map((les) {
                          final isCurrent = les.id == activeLesson.id;
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              color: isCurrent
                                  ? (isDark ? const Color(0xFF0C244C) : AppColors.primaryLight)
                                  : Theme.of(context).cardTheme.color,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isCurrent ? AppColors.primary : (isDark ? AppColors.borderDark : AppColors.borderLight),
                              ),
                            ),
                            child: ListTile(
                              dense: true,
                              leading: Icon(
                                les.isCompleted ? Icons.check_circle : Icons.play_circle_outline,
                                color: les.isCompleted ? AppColors.success : AppColors.primary,
                              ),
                              title: Text(
                                les.title,
                                style: TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                                ),
                              ),
                              subtitle: Text('${les.durationMinutes} phút'),
                              onTap: () => courseCtrl.selectLesson(les),
                            ),
                          );
                        }),
                        const SizedBox(height: 12),
                      ],
                    );
                  },
                ),

                // TAB 2: Lesson Notes
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Mục tiêu học tập & Kỹ năng đạt được:',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        activeLesson.summary.isNotEmpty
                            ? activeLesson.summary
                            : 'Nắm vững các thao tác kỹ thuật y tế chuẩn thực hành lâm sàng, đảm bảo tiêu chuẩn an toàn cho bệnh nhân.',
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.5,
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.cardDark : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(widget.course.instructorAvatar),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.course.instructorName,
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    widget.course.instructorTitle,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

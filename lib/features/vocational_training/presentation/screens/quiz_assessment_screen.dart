import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prj/core/constants/app_constants.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'package:prj/core/widgets/custom_button.dart';
import 'package:prj/features/auth/presentation/controllers/auth_controller.dart';
import '../controllers/course_controller.dart';

class QuizAssessmentScreen extends StatelessWidget {
  const QuizAssessmentScreen({super.key});

  void _showCertificateDialog(BuildContext context, String studentName, int score) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFFFEF3C7),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.workspace_premium_rounded, size: 56, color: AppColors.gold),
            ),
            const SizedBox(height: 16),
            const Text(
              'CHỨNG CHỈ TỐT NGHIỆP XUẤT SẮC',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: AppColors.gold,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              studentName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Đã hoàn thành xuất sắc Khóa Huấn luyện & Đạt bài Đánh giá Thực hành Lâm sàng Y tế',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey, height: 1.4),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text('Điểm số', style: TextStyle(fontSize: 11, color: Colors.grey)),
                      Text(
                        '$score/100',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.success),
                      ),
                    ],
                  ),
                  Column(
                    children: const [
                      Text('Xếp loại', style: TextStyle(fontSize: 11, color: Colors.grey)),
                      Text(
                        'XUẤT SẮC',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.primary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Tải Chứng Chỉ Số (PDF)',
              width: double.infinity,
              icon: Icons.download_rounded,
              onPressed: () {
                Navigator.pop(dialogCtx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Đã lưu chứng chỉ số vào bộ nhớ máy!')),
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final courseCtrl = context.watch<CourseController>();
    final auth = context.watch<AuthController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final questions = AppConstants.sampleQuizQuestions;
    final currentQ = questions[courseCtrl.currentQuizQuestionIndex];
    final selectedOption = courseCtrl.userSelectedAnswers[courseCtrl.currentQuizQuestionIndex];

    final studentName = auth.currentUser?.name ?? 'Lê Hoàng Yến Nhi';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đánh Giá Năng Lực Sau Bài Học'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: courseCtrl.resetQuiz,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Câu hỏi ${courseCtrl.currentQuizQuestionIndex + 1} / ${questions.length}',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primary),
                ),
                Text(
                  'Đạt tối thiểu 70% để cấp chứng chỉ',
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: (courseCtrl.currentQuizQuestionIndex + 1) / questions.length,
                minHeight: 8,
                backgroundColor: isDark ? const Color(0xFF1E2D4A) : const Color(0xFFE2E8F0),
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
            const SizedBox(height: 24),

            // Question Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                ),
              ),
              child: Text(
                currentQ.question,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                  height: 1.45,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Options List
            Expanded(
              child: ListView.builder(
                itemCount: currentQ.options.length,
                itemBuilder: (context, optIdx) {
                  final isSelected = selectedOption == optIdx;
                  final optionText = currentQ.options[optIdx];

                  return InkWell(
                    onTap: () {
                      courseCtrl.selectQuizAnswer(courseCtrl.currentQuizQuestionIndex, optIdx);
                    },
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? (isDark ? const Color(0xFF0C244C) : AppColors.primaryLight)
                            : Theme.of(context).cardTheme.color,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : (isDark ? AppColors.borderDark : AppColors.borderLight),
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 26,
                            height: 26,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected ? AppColors.primary : Colors.transparent,
                              border: Border.all(
                                color: isSelected ? AppColors.primary : Colors.grey,
                                width: 1.5,
                              ),
                            ),
                            child: Text(
                              String.fromCharCode(65 + optIdx), // A, B, C, D
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: isSelected ? Colors.white : Colors.grey,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              optionText,
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                color: isSelected
                                    ? AppColors.primary
                                    : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Navigation Buttons
            Row(
              children: [
                if (courseCtrl.currentQuizQuestionIndex > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: courseCtrl.previousQuizQuestion,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Câu trước'),
                    ),
                  ),
                if (courseCtrl.currentQuizQuestionIndex > 0) const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: CustomButton(
                    text: courseCtrl.currentQuizQuestionIndex == questions.length - 1 ? 'Nộp bài kiểm tra' : 'Câu tiếp theo',
                    onPressed: () {
                      if (courseCtrl.currentQuizQuestionIndex < questions.length - 1) {
                        courseCtrl.nextQuizQuestion();
                      } else {
                        courseCtrl.submitQuiz();
                        _showCertificateDialog(context, studentName, courseCtrl.quizScore);
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

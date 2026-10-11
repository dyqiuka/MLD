import 'package:flutter/material.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'learning_result_screen.dart';

/// Frame E10 in Group E: Kiểm tra kiến thức
class QuizAssessmentScreen extends StatefulWidget {
  const QuizAssessmentScreen({super.key});

  @override
  State<QuizAssessmentScreen> createState() => _QuizAssessmentScreenState();
}

class _QuizAssessmentScreenState extends State<QuizAssessmentScreen> {
  int _selectedOption = 0; // Option A selected by default
  final List<String> _options = [
    'A. Kiểm tra thông tin và nhu cầu khách hàng.',
    'B. Chuẩn bị chương trình ưu đãi.',
    'C. Giới thiệu thêm sản phẩm.',
    'D. Bắt đầu ngay không cần tư vấn.',
  ];

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
                    'Bài kiểm tra minh họa',
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
                      'Kiểm tra kiến thức',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2C241E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Kỹ thuật Massage Chuyên Nghiệp',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF7A6E65),
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Bài kiểm tra: Kiến thức Spa cơ bản',
                      style: TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF8B5E34),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Counter & Timer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Câu 3 / 20',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2C241E),
                          ),
                        ),
                        Text(
                          '⏱ 18:45',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFD97706),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Thời gian tĩnh · Không đếm ngược',
                      style: TextStyle(fontSize: 11, color: Color(0xFF9E9187), fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 18),

                    // Question Card
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
                        children: const [
                          Text(
                            'Chọn một đáp án phù hợp nhất',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF8B5E34),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Yếu tố nào cần được ưu tiên trước khi thực hiện dịch vụ chăm sóc khách hàng?',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF2C241E),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // 4 Radio Option Cards
                    ...List.generate(_options.length, (idx) {
                      final isSelected = _selectedOption == idx;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: () => setState(() => _selectedOption = idx),
                          borderRadius: BorderRadius.circular(14),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFF5ECE3)
                                  : (isDark ? AppColors.surfaceDark : Colors.white),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF8B5E34)
                                    : (isDark ? AppColors.borderDark : const Color(0xFFE5DDD5)),
                                width: isSelected ? 1.5 : 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 22,
                                  height: 22,
                                  decoration: BoxDecoration(
                                    color: isSelected ? const Color(0xFF8B5E34) : Colors.transparent,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected ? const Color(0xFF8B5E34) : const Color(0xFFC7BDB5),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: isSelected
                                      ? const Icon(Icons.circle, size: 10, color: Colors.white)
                                      : null,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    _options[idx],
                                    style: TextStyle(
                                      fontSize: 13.5,
                                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                      color: const Color(0xFF2C241E),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 8),

                    const Text(
                      'Bài làm hiện tại · Chưa nộp, chưa chấm điểm',
                      style: TextStyle(fontSize: 11, color: Color(0xFF9E9187), fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // Bottom Sticky Bar: Nộp bài (leads to E12)
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
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Đã nộp bài kiểm tra thành công!'),
                        backgroundColor: Color(0xFF8B5E34),
                      ),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LearningResultScreen(),
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
                    'Nộp bài',
                    style: TextStyle(
                      fontSize: 15,
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
    );
  }
}

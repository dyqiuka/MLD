import 'package:flutter/material.dart';
import 'package:prj/core/theme/app_colors.dart';

/// Frame E12 in Group E: Kết quả học tập
class LearningResultScreen extends StatelessWidget {
  const LearningResultScreen({super.key});

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
                      'Kết quả học tập',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2C241E),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Ghi nhận hành trình học tập và phát triển kỹ năng của bạn.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF7A6E65),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Student Profile Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.surfaceDark : const Color(0xFFF5ECE3),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isDark ? AppColors.borderDark : const Color(0xFFEADBCE),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFFDFCEBE)),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'MA',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF8B5E34),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Nguyễn Minh Anh',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF2C241E),
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'MCB-0726 · Nguyễn Thanh Hương',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF7A6E65),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Completed Course Card
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
                          Text(
                            'Kỹ thuật Massage Cơ Bản',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF2C241E),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFECFDF5),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'Hoàn thành — minh họa',
                              style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: Color(0xFF059669)),
                            ),
                          ),
                          const SizedBox(height: 14),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                '20 / 20 bài học đã hoàn thành',
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF5A4D41)),
                              ),
                              Text(
                                '100%',
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF059669)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: const LinearProgressIndicator(
                              value: 1.0,
                              minHeight: 6,
                              backgroundColor: Color(0xFFF1EAE4),
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF059669)),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Ngày hoàn thành 28/08/2026',
                            style: TextStyle(fontSize: 11.5, color: Color(0xFF9E9187)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // 2 Score Statistics Box
                    Row(
                      children: [
                        Expanded(
                          child: _buildScoreBox('8.5/10', 'Lý thuyết', isDark),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildScoreBox('9.0/10', 'Thực hành', isDark),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Evaluation Summary Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F1EB),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFEADBCE)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Xếp loại: Giỏi (88%) · Đạt chuẩn tay nghề',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF8B5E34),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Học viên đủ điều kiện nhận chứng chỉ hành nghề và được ưu tiên giới thiệu việc làm tại hệ thống spa.',
                            style: TextStyle(fontSize: 12, color: Color(0xFF5A4D41), height: 1.4),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // Bottom Sticky Buttons: Xem chứng nhận & Tải chứng nhận
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
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Chứng chỉ nghề Spa', style: TextStyle(fontWeight: FontWeight.w800)),
                            content: const Text(
                              'Học viện MLD chứng nhận:\n\nHọc viên: NGUYỄN MINH ANH\nKhóa học: Kỹ thuật Massage Cơ Bản\nXếp loại: Giỏi\nSố hiệu: SPA-CERT-2026-0828',
                              style: TextStyle(height: 1.5),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: const Text('Đóng', style: TextStyle(color: Color(0xFF8B5E34))),
                              ),
                            ],
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
                        'Xem chứng nhận',
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
                          const SnackBar(
                            content: Text('Đang tải chứng nhận PDF (mô phỏng)...'),
                            backgroundColor: Color(0xFF8B5E34),
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
                        'Tải chứng nhận',
                        style: TextStyle(
                          fontSize: 13.5,
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
    );
  }

  Widget _buildScoreBox(String score, String label, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.borderDark : const Color(0xFFEADBCE),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            score,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Color(0xFF8B5E34),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2C241E),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Đánh giá minh họa',
            style: TextStyle(fontSize: 11, color: Color(0xFF9E9187)),
          ),
        ],
      ),
    );
  }
}

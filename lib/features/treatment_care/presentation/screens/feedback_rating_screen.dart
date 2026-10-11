import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'package:prj/features/treatment_care/presentation/controllers/treatment_controller.dart';

/// Frame D05 in Group D: Đánh giá trải nghiệm
class FeedbackRatingScreen extends StatefulWidget {
  const FeedbackRatingScreen({super.key});

  @override
  State<FeedbackRatingScreen> createState() => _FeedbackRatingScreenState();
}

class _FeedbackRatingScreenState extends State<FeedbackRatingScreen> {
  int _overall = 5;
  int _quality = 5;
  int _attitude = 5;
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final treatmentCtrl = context.watch<TreatmentController>();
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
                    'CHĂM SÓC · MINH HỌA',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF8B5E34),
                      letterSpacing: 0.5,
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
                      'Đánh giá trải nghiệm',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2C241E),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Ý kiến của bạn giúp chúng tôi nâng cao chất lượng dịch vụ.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF7A6E65),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Service item card
                    Container(
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
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?w=400',
                              width: 68,
                              height: 68,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                width: 68,
                                height: 68,
                                color: const Color(0xFFE8DCCF),
                                child: const Icon(Icons.spa_outlined, color: Color(0xFF8B5E34)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Massage thư giãn toàn thân',
                                  style: TextStyle(
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF2C241E),
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Chi nhánh mẫu 01 — Quận 3',
                                  style: TextStyle(fontSize: 12, color: Color(0xFF7A6E65)),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Trần Minh Phương',
                                  style: TextStyle(fontSize: 12, color: Color(0xFF8B5E34), fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Buổi 04 · Hoàn thành 08/10/2026 · Minh họa',
                                  style: TextStyle(fontSize: 11, color: Color(0xFF9E9187)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Card: Bạn hài lòng với trải nghiệm hôm nay chứ?
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.surfaceDark : const Color(0xFFFBF8F5),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: isDark ? AppColors.borderDark : const Color(0xFFEADBCE),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Bạn hài lòng với trải nghiệm hôm nay chứ?',
                            style: TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2C241E),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Stars
                          Row(
                            children: List.generate(5, (index) {
                              final starVal = index + 1;
                              final isSelected = starVal <= _overall;
                              return IconButton(
                                onPressed: () => setState(() => _overall = starVal),
                                icon: Icon(
                                  isSelected ? Icons.star : Icons.star_border,
                                  color: const Color(0xFFD97706),
                                  size: 32,
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 2),
                                constraints: const BoxConstraints(),
                              );
                            }),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '$_overall/5 · ${_getRatingLabel(_overall)} · Bản nháp chưa gửi',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF8B5E34),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Section: Chất lượng dịch vụ
                    const Text(
                      'Chất lượng dịch vụ.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2C241E),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildSubRatingRow(_quality, (v) => setState(() => _quality = v)),
                    const SizedBox(height: 18),

                    // Section: Thái độ chuyên viên
                    const Text(
                      'Thái độ chuyên viên.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2C241E),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildSubRatingRow(_attitude, (v) => setState(() => _attitude = v)),
                    const SizedBox(height: 20),

                    // Comment box
                    TextField(
                      controller: _commentController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Góp ý thêm về trải nghiệm (không bắt buộc)...',
                        hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF9E9187)),
                        filled: true,
                        fillColor: isDark ? AppColors.surfaceDark : Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: Color(0xFFE5DDD5)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: Color(0xFFE5DDD5)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // Bottom Sticky Bar: Gửi đánh giá
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
                    treatmentCtrl.setRatings(
                      overall: _overall,
                      quality: _quality,
                      attitude: _attitude,
                    );
                    treatmentCtrl.submitRating();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Cảm ơn bạn đã gửi đánh giá trải nghiệm!'),
                        backgroundColor: Color(0xFF8B5E34),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B5E34),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Gửi đánh giá',
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

  Widget _buildSubRatingRow(int current, ValueChanged<int> onChanged) {
    return Row(
      children: [
        ...List.generate(5, (index) {
          final star = index + 1;
          final isSelected = star <= current;
          return IconButton(
            onPressed: () => onChanged(star),
            icon: Icon(
              isSelected ? Icons.star : Icons.star_border,
              color: const Color(0xFFD97706),
              size: 26,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 2),
            constraints: const BoxConstraints(),
          );
        }),
        const SizedBox(width: 8),
        Text(
          '$current/5',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Color(0xFF5A4D41),
          ),
        ),
      ],
    );
  }

  String _getRatingLabel(int rating) {
    switch (rating) {
      case 5:
        return 'Rất hài lòng';
      case 4:
        return 'Hài lòng';
      case 3:
        return 'Bình thường';
      case 2:
        return 'Chưa hài lòng';
      default:
        return 'Rất không hài lòng';
    }
  }
}

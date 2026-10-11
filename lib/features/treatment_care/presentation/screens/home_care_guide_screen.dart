import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'package:prj/features/treatment_care/presentation/controllers/treatment_controller.dart';

/// Frame D06 in Group D: Hướng dẫn chăm sóc tại nhà
class HomeCareGuideScreen extends StatelessWidget {
  const HomeCareGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final treatmentCtrl = context.watch<TreatmentController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final article = treatmentCtrl.featuredArticle;

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
                      'Hướng dẫn chăm sóc tại nhà',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2C241E),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Những hướng dẫn hữu ích giúp duy trì thói quen chăm sóc bản thân.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF7A6E65),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Article Card
                    Container(
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.surfaceDark : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isDark ? AppColors.borderDark : const Color(0xFFEADBCE),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                            child: Image.network(
                              article?.imageUrl ?? 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?w=800',
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                height: 180,
                                color: const Color(0xFFE8DCCF),
                                child: const Icon(Icons.spa_outlined, size: 54, color: Color(0xFF8B5E34)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF7F1EB),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        '${article?.category ?? 'CHĂM SÓC CƠ THỂ'} · Bài viết · ${article?.readTime ?? '4 phút'}',
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF8B5E34),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  article?.title ?? 'Chăm sóc cơ thể sau buổi massage',
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF2C241E),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  article?.subtitle ?? 'Nghỉ ngơi thoải mái, vận động nhẹ và giữ nhịp sinh hoạt phù hợp.',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF5A4D41),
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                const Text(
                                  'Bạn nội dung · Gợi ý minh họa',
                                  style: TextStyle(
                                    fontSize: 11.5,
                                    color: Color(0xFF9E9187),
                                  ),
                                ),
                                const Divider(height: 24),

                                const Text(
                                  'Các lưu ý quan trọng:',
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF2C241E),
                                  ),
                                ),
                                const SizedBox(height: 8),

                                if (article?.keyPoints != null)
                                  ...article!.keyPoints.map((point) => Padding(
                                        padding: const EdgeInsets.only(bottom: 8),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text('•  ', style: TextStyle(color: Color(0xFF8B5E34), fontWeight: FontWeight.bold)),
                                            Expanded(
                                              child: Text(
                                                point,
                                                style: const TextStyle(fontSize: 12.5, color: Color(0xFF5A4D41), height: 1.4),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),

                                const SizedBox(height: 12),
                                const Text(
                                  'Hướng dẫn chăm sóc chung, không phải chẩn đoán hoặc lời khuyên điều trị.',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF9E9187),
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // Bottom Sticky Bar: Xem hướng dẫn
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
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      builder: (ctx) => Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Cẩm nang chăm sóc sau liệu trình',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF2C241E)),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              '1. Uống nhiều nước: Sau massage, các cơ được thả lỏng và tuần hoàn bạch huyết được kích thích. Nước giúp đào thải độc tố tự nhiên.\n\n'
                              '2. Không tắm nước lạnh ngay: Cơ thể đang ở nhiệt độ ấm, các lỗ chân lông giãn nở. Hãy đợi ít nhất 1-2 giờ trước khi tắm bằng nước ấm.\n\n'
                              '3. Tránh tập thể dục nặng: Hãy để cơ bắp nghỉ ngơi để đạt hiệu quả phục hồi tốt nhất.',
                              style: TextStyle(fontSize: 13, height: 1.5, color: Color(0xFF5A4D41)),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () => Navigator.pop(ctx),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF8B5E34),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                child: const Text('Đã hiểu', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                              ),
                            ),
                          ],
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
                    'Xem hướng dẫn',
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

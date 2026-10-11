import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prj/core/theme/app_colors.dart';

class ReferralScreen extends StatelessWidget {
  const ReferralScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Dữ liệu minh họa', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Giới thiệu bạn bè', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
            const SizedBox(height: 4),
            const Text('Chia sẻ trải nghiệm tốt đẹp và nhận thêm quyền lợi.', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
            const SizedBox(height: 24),

            // Hero Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?w=400',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 180,
                  color: AppColors.primaryLight,
                  child: const Icon(Icons.group, size: 48, color: AppColors.primary),
                ),
              ),
            ),
            const SizedBox(height: 24),

            const Text('Mời bạn cùng trải nghiệm', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 8),
            const Text(
              'Chia sẻ ứng dụng với bạn bè để cùng tận hưởng những quyền lợi dành cho hội viên.',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.5),
            ),
            const SizedBox(height: 24),

            // Referral Code
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Column(
                children: [
                  const Text('Mã giới thiệu của bạn', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                  const SizedBox(height: 8),
                  const Text('MINHANH128', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.primary, letterSpacing: 2)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            HapticFeedback.lightImpact();
                            Clipboard.setData(const ClipboardData(text: 'MINHANH128'));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Đã sao chép mã giới thiệu!'), backgroundColor: AppColors.success),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.primary),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text('Sao chép mã', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            HapticFeedback.lightImpact();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Đang mở chia sẻ... (minh họa)'), backgroundColor: AppColors.primary),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text('Chia sẻ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text('Dữ liệu minh họa · Mã không có giá trị giới thiệu thực', style: TextStyle(fontSize: 11, color: AppColors.textSecondary, fontStyle: FontStyle.italic)),
            const SizedBox(height: 24),

            // Benefits
            const Text('Quyền lợi giới thiệu', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 12),
            _buildBenefitItem(Icons.card_giftcard, 'Bạn nhận 100 điểm tích lũy cho mỗi lần giới thiệu thành công'),
            _buildBenefitItem(Icons.person_add, 'Bạn bè nhận voucher giảm 10% dịch vụ đầu tiên'),
            _buildBenefitItem(Icons.trending_up, 'Giới thiệu 5 bạn để nâng hạng hội viên nhanh hơn'),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  HapticFeedback.lightImpact();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Đang mở chia sẻ... (minh họa)'), backgroundColor: AppColors.primary),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Chia sẻ ngay', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14, color: AppColors.textPrimary, height: 1.4))),
        ],
      ),
    );
  }
}

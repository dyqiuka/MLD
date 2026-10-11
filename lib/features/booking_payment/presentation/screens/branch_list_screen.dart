import 'package:flutter/material.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'package:prj/core/widgets/custom_button.dart';

class BranchListScreen extends StatelessWidget {
  const BranchListScreen({super.key});

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
        title: const Text(
          'Hệ thống chi nhánh',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tìm cơ sở phù hợp với bạn.',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),

            // Search Field
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Tìm chi nhánh, địa chỉ...',
                  hintStyle: TextStyle(fontSize: 14, color: AppColors.textSecondaryLight),
                  prefixIcon: Icon(Icons.search, color: AppColors.primary, size: 20),
                  prefixIconConstraints: BoxConstraints(minWidth: 32),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Province Dropdown
            const Text('Tỉnh / thành phố', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tất cả tỉnh / thành phố', style: TextStyle(fontSize: 14, color: AppColors.textPrimary)),
                  Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Quick Filters
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.primary),
                    ),
                    alignment: Alignment.center,
                    child: const Text('Gần tôi', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: const Text('Danh sách', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    alignment: Alignment.center,
                    child: const Text('Bản đồ', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Services Dropdown
            const Text('Dịch vụ tại cơ sở', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tất cả dịch vụ', style: TextStyle(fontSize: 14, color: AppColors.textPrimary)),
                  Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Warning Banner
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Dữ liệu minh họa • 2 cơ sở hư cấu. Không sử dụng vị trí hoặc khoảng cách thực tế.',
                style: TextStyle(fontSize: 12, color: AppColors.textPrimary, height: 1.4),
              ),
            ),
            const SizedBox(height: 24),

            // Branch List
            _buildBranchCard(
              'Chi nhánh mẫu 01 – Quận 3',
              '123 Đường Mẫu, Phường Mẫu, TP. Hồ Chí Minh',
              '09:00 - 20:00 • Cả tuần (minh họa)',
              'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=600',
            ),
            const SizedBox(height: 24),
            _buildBranchCard(
              'Chi nhánh mẫu 02 – Cầu Giấy',
              '45 Đường Minh Họa, Phường Mẫu, Hà Nội',
              '09:00 - 20:00 • Cả tuần (minh họa)',
              'https://images.unsplash.com/photo-1540555700478-4be289fbecef?w=600',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBranchCard(String title, String address, String time, String imageUrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            imageUrl,
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              height: 180,
              color: AppColors.borderLight,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        const SizedBox(height: 8),
        Text(address, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        const SizedBox(height: 4),
        Text(time, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        const SizedBox(height: 16),
        CustomButton(
          text: 'Đặt lịch tại chi nhánh',
          width: double.infinity,
          onPressed: () {},
        ),
      ],
    );
  }
}

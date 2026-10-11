import 'package:flutter/material.dart';
import 'package:prj/core/theme/app_colors.dart';

class ProfessionalListScreen extends StatelessWidget {
  const ProfessionalListScreen({super.key});

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
          'Đội ngũ chuyên viên',
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
              'Đồng hành cùng bạn trong hành trình chăm sóc sức khỏe.',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.4),
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
                  hintText: 'Tìm tên hoặc chuyên môn...',
                  hintStyle: TextStyle(fontSize: 14, color: AppColors.textSecondaryLight),
                  prefixIcon: Icon(Icons.search, color: AppColors.primary, size: 20),
                  prefixIconConstraints: BoxConstraints(minWidth: 32),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Dropdowns
            Row(
              children: [
                Expanded(child: _buildDropdown('Chi nhánh', 'Tất cả')),
                const SizedBox(width: 16),
                Expanded(child: _buildDropdown('Chuyên môn', 'Tất cả')),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildDropdown('Dịch vụ', 'Tất cả')),
                const SizedBox(width: 16),
                Expanded(child: _buildDropdown('Giá minh họa', 'Tất cả')),
              ],
            ),
            const SizedBox(height: 24),

            // Sort By
            _buildDropdown('Sắp xếp', 'Theo tên chuyên viên', fullWidth: true),
            const SizedBox(height: 24),

            // Warning Banner
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                '3 hồ sơ minh họa • Không phải nhân sự hoặc lịch trống thực tế.',
                style: TextStyle(fontSize: 12, color: AppColors.textPrimary, height: 1.4),
              ),
            ),
            const SizedBox(height: 24),

            // Professionals List
            _buildProfessionalCard(
              'Trần Minh Phương',
              'Kỹ thuật viên massage',
              'Hồ sơ minh họa',
              'https://images.unsplash.com/photo-1594824436998-32fbb4716965?w=600',
            ),
            const SizedBox(height: 16),
            _buildProfessionalCard(
              'Nguyễn Thu Hà',
              'Chuyên viên chăm sóc da',
              'Hồ sơ minh họa',
              'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=600',
            ),
            const SizedBox(height: 16),
            _buildProfessionalCard(
              'Lê Hoài An',
              'Chuyên viên chăm sóc cơ thể',
              'Hồ sơ minh họa',
              'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=600',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, String value, {bool fullWidth = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        const SizedBox(height: 8),
        Container(
          width: fullWidth ? double.infinity : null,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary, size: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfessionalCard(String name, String title, String subtitle, String imageUrl) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(width: 80, height: 80, color: AppColors.borderLight),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.primary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

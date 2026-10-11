import 'package:flutter/material.dart';
import 'package:prj/core/theme/app_colors.dart';

/// Frame E04 in Group E: Thông tin giảng viên
class InstructorDetailScreen extends StatelessWidget {
  final String instructorName;
  final String instructorTitle;
  final String avatarUrl;

  const InstructorDetailScreen({
    super.key,
    this.instructorName = 'Nguyễn Thanh Hương',
    this.instructorTitle = 'Giảng viên kỹ thuật Spa',
    this.avatarUrl = 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=500',
  });

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
                      'Thông tin giảng viên',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2C241E),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Instructor Portrait Photo
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        avatarUrl,
                        height: 240,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 240,
                          color: const Color(0xFFE8DCCF),
                          child: const Icon(Icons.person, size: 64, color: Color(0xFF8B5E34)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Name & Title
                    Text(
                      instructorName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2C241E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      instructorTitle,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF8B5E34),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Massage · Chăm sóc cơ thể · Quy trình dịch vụ',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Color(0xFF7A6E65),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Badge: Thông tin minh họa
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F1EB),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Thông tin minh họa',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF8B5E34),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Giới thiệu
                    const Text(
                      'Giới thiệu',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2C241E),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Cô Hương đồng hành cùng học viên từ thao tác nền tảng đến thực hành quy trình hoàn chỉnh. Phương pháp hướng dẫn chú trọng vệ sinh, giao tiếp và điều chỉnh thao tác theo phản hồi của khách hàng.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF5A4D41),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Hơn 8 năm kinh nghiệm giảng dạy và quản lý vận hành dịch vụ spa trị liệu tại các hệ thống uy tín. Hướng dẫn trực tiếp hơn 400 học viên tốt nghiệp đạt chứng chỉ tay nghề chuẩn quốc tế.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF5A4D41),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // Bottom Sticky Bar: Xem khóa học của giảng viên
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
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B5E34),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Xem khóa học của giảng viên',
                    style: TextStyle(
                      fontSize: 14.5,
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

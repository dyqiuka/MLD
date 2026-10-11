import 'package:flutter/material.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'package:prj/features/vocational_training/domain/models/course_model.dart';
import 'my_courses_screen.dart';

/// Frame E06 in Group E: Thanh toán học phí
class CoursePaymentScreen extends StatelessWidget {
  final CourseModel course;
  final String studentName;
  final String studentPhone;

  const CoursePaymentScreen({
    super.key,
    required this.course,
    this.studentName = 'Nguyễn Minh Anh',
    this.studentPhone = '0912 345 678',
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
                      'Thanh toán học phí',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2C241E),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Kiểm tra học phí và lựa chọn phương thức thanh toán.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF7A6E65),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Status Banner with Clock Icon
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFBF4ED),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFEADBCE)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.access_time_filled_rounded, color: Color(0xFFD97706), size: 24),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Chờ thanh toán — minh họa',
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF8B5E34),
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Chưa ghi danh · Không thực hiện thanh toán bằng mẫu này.',
                                  style: TextStyle(fontSize: 11.5, color: Color(0xFF7A6E65)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Class Summary Card
                    Container(
                      padding: const EdgeInsets.all(16),
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
                            course.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF2C241E),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$studentName · MCN-1026',
                            style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: Color(0xFF8B5E34)),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Khai giảng 23/10/2026 · Học trực tiếp',
                            style: TextStyle(fontSize: 12.5, color: Color(0xFF5A4D41)),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Chi nhánh mẫu 01 — Quận 3',
                            style: TextStyle(fontSize: 12.5, color: Color(0xFF5A4D41)),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Thứ 6–7–Chủ nhật · 13:00–17:00',
                            style: TextStyle(fontSize: 12.5, color: Color(0xFF7A6E65)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Fee Breakdown Card
                    Container(
                      padding: const EdgeInsets.all(16),
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
                          const Text(
                            'Học phí minh họa',
                            style: TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF2C241E),
                            ),
                          ),
                          const SizedBox(height: 14),

                          _buildFeeRow('Học phí', '${(course.tuitionFee / 1000000).toStringAsFixed(0)}.000.000đ'),
                          const SizedBox(height: 8),
                          _buildFeeRow('Giảm giá', '0đ'),
                          const SizedBox(height: 8),
                          _buildFeeRow('Phí đăng ký', '0đ'),
                          const Divider(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Tổng cộng',
                                style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w800, color: Color(0xFF2C241E)),
                              ),
                              Text(
                                '${(course.tuitionFee / 1000000).toStringAsFixed(0)}.000.000đ',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF8B5E34)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // Bottom Sticky Bar: Xác nhận thanh toán (leads to E07)
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
                  const Text(
                    'Chờ thanh toán · Trả ngay 2.000.000đ (minh họa)',
                    style: TextStyle(fontSize: 11.5, color: Color(0xFF7A6E65)),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Đã xác nhận thanh toán học phí thành công!'),
                            backgroundColor: Color(0xFF8B5E34),
                          ),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MyCoursesScreen(),
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
                        'Xác nhận thanh toán',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
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

  Widget _buildFeeRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, color: Color(0xFF7A6E65))),
        Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF2C241E))),
      ],
    );
  }
}

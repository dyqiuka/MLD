import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'package:prj/features/vocational_training/presentation/controllers/course_controller.dart';
import 'package:prj/features/vocational_training/domain/models/course_model.dart';
import 'course_detail_screen.dart';

/// Frame E02 in Group E: Khám phá khóa học
class CourseDiscoveryScreen extends StatefulWidget {
  const CourseDiscoveryScreen({super.key});

  @override
  State<CourseDiscoveryScreen> createState() => _CourseDiscoveryScreenState();
}

class _CourseDiscoveryScreenState extends State<CourseDiscoveryScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedCatIndex = 0;
  final List<String> _categories = ['Tất cả', 'Massage', 'Chăm sóc da', 'Kỹ thuật viên', 'Điều dưỡng'];

  String _level = 'Tất cả';
  String _duration = '6–12 tuần';
  String _priceRange = '4–9 triệu đồng';
  String _format = 'Tất cả';
  String _branch = 'Chi nhánh mẫu 01 — Quận 3';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final courseCtrl = context.watch<CourseController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final query = _searchController.text.toLowerCase();
    final selectedCat = _categories[_selectedCatIndex];

    final filtered = courseCtrl.courses.where((c) {
      final matchCat = selectedCat == 'Tất cả' || c.category.toLowerCase().contains(selectedCat.toLowerCase());
      final matchQuery = query.isEmpty ||
          c.title.toLowerCase().contains(query) ||
          c.instructorName.toLowerCase().contains(query);
      return matchCat && matchQuery;
    }).toList();

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
                      'Khám phá khóa học',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2C241E),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Chọn chương trình đào tạo phù hợp với mục tiêu nghề nghiệp của bạn.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF7A6E65),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Search Bar
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.surfaceDark : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isDark ? AppColors.borderDark : const Color(0xFFE5DDD5),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Color(0xFF8B5E34), size: 20),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              onChanged: (_) => setState(() {}),
                              decoration: const InputDecoration(
                                hintText: 'Tìm khóa học, kỹ năng hoặc chuyên ngành...',
                                hintStyle: TextStyle(fontSize: 13, color: Color(0xFF9E9187)),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          if (_searchController.text.isNotEmpty)
                            IconButton(
                              icon: const Icon(Icons.close, size: 16),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {});
                              },
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Category Chips
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(_categories.length, (idx) {
                          final isSelected = _selectedCatIndex == idx;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: InkWell(
                              onTap: () => setState(() => _selectedCatIndex = idx),
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF8B5E34)
                                      : (isDark ? AppColors.surfaceDark : Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: isSelected
                                        ? const Color(0xFF8B5E34)
                                        : (isDark ? AppColors.borderDark : const Color(0xFFE5DDD5)),
                                  ),
                                ),
                                child: Text(
                                  _categories[idx],
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                    color: isSelected
                                        ? Colors.white
                                        : (isDark ? AppColors.textPrimaryDark : const Color(0xFF5A4D41)),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Filter Box: Tùy chỉnh chương trình
                    Container(
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
                          const Text(
                            'Tùy chỉnh chương trình',
                            style: TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2C241E),
                            ),
                          ),
                          const SizedBox(height: 12),

                          Row(
                            children: [
                              Expanded(
                                child: _buildFilterField(
                                  label: 'Trình độ',
                                  value: _level,
                                  options: ['Tất cả', 'Cơ bản', 'Chuyên sâu'],
                                  onChanged: (v) => setState(() => _level = v),
                                  isDark: isDark,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _buildFilterField(
                                  label: 'Thời lượng',
                                  value: _duration,
                                  options: ['Tất cả', '6–12 tuần', '3–6 tháng'],
                                  onChanged: (v) => setState(() => _duration = v),
                                  isDark: isDark,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          Row(
                            children: [
                              Expanded(
                                child: _buildFilterField(
                                  label: 'Học phí',
                                  value: _priceRange,
                                  options: ['Tất cả', '4–9 triệu đồng', 'Trên 9 triệu'],
                                  onChanged: (v) => setState(() => _priceRange = v),
                                  isDark: isDark,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _buildFilterField(
                                  label: 'Hình thức',
                                  value: _format,
                                  options: ['Tất cả', 'Trực tiếp', 'Trực tuyến'],
                                  onChanged: (v) => setState(() => _format = v),
                                  isDark: isDark,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          _buildFilterField(
                            label: 'Chi nhánh minh họa',
                            value: _branch,
                            options: [
                              'Chi nhánh mẫu 01 — Quận 3',
                              'Chi nhánh mẫu 02 — Bình Thạnh',
                              'Chi nhánh mẫu 03 — Cầu Giấy',
                            ],
                            onChanged: (v) => setState(() => _branch = v),
                            isDark: isDark,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Section Results Counter
                    Text(
                      '${filtered.length} chương trình đào tạo',
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2C241E),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Courses list
                    if (filtered.isEmpty)
                      Container(
                        padding: const EdgeInsets.all(32),
                        alignment: Alignment.center,
                        child: const Text('Không tìm thấy chương trình đào tạo phù hợp.'),
                      )
                    else
                      ...filtered.map((course) => _buildCourseItem(context, course, isDark)),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterField({
    required String label,
    required String value,
    required List<String> options,
    required ValueChanged<String> onChanged,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF7A6E65))),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: BoxDecoration(
            color: isDark ? AppColors.backgroundDark : const Color(0xFFFBF8F5),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE5DDD5)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: options.contains(value) ? value : options.first,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down, size: 18, color: Color(0xFF8B5E34)),
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF2C241E)),
              items: options.map((o) => DropdownMenuItem(value: o, child: Text(o))).toList(),
              onChanged: (v) {
                if (v != null) onChanged(v);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCourseItem(BuildContext context, CourseModel course, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.borderDark : const Color(0xFFEADBCE),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            context.read<CourseController>().selectCourse(course);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CourseDetailScreen(course: course)),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    course.thumbnailUrl,
                    width: 84,
                    height: 84,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 84,
                      height: 84,
                      color: const Color(0xFFE8DCCF),
                      child: const Icon(Icons.school_outlined, color: Color(0xFF8B5E34)),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7F1EB),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          course.category,
                          style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: Color(0xFF8B5E34)),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        course.title,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF2C241E)),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'GV: ${course.instructorName}',
                        style: const TextStyle(fontSize: 12, color: Color(0xFF7A6E65)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${course.totalHours} giờ học · ${(course.tuitionFee / 1000000).toStringAsFixed(1)} triệu đồng',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF8B5E34)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

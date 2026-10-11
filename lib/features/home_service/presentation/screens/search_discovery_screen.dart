import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'package:prj/core/widgets/course_card.dart';
import 'package:prj/core/widgets/doctor_card.dart';
import 'package:prj/core/widgets/empty_state.dart';
import 'package:prj/core/widgets/service_card.dart';
import 'package:prj/features/booking_payment/presentation/controllers/booking_controller.dart';
import 'package:prj/features/booking_payment/presentation/screens/booking_flow_screen.dart';
import 'package:prj/features/home_service/presentation/controllers/home_controller.dart';
import 'package:prj/features/vocational_training/presentation/controllers/course_controller.dart';
import 'package:prj/features/vocational_training/presentation/screens/course_detail_screen.dart';
import 'service_detail_screen.dart';

/// Frame 4 in Group B: Search Discovery Screen ("Bạn đang tìm kiếm điều gì?")
class SearchDiscoveryScreen extends StatefulWidget {
  final String? initialQuery;
  const SearchDiscoveryScreen({super.key, this.initialQuery});

  @override
  State<SearchDiscoveryScreen> createState() => _SearchDiscoveryScreenState();
}

class _SearchDiscoveryScreenState extends State<SearchDiscoveryScreen> {
  late final TextEditingController _searchController;
  final List<String> _recentSearches = [
    'Massage thư giãn',
    'Chăm sóc da',
  ];

  final List<String> _popularSearches = [
    'Massage thư giãn',
    'Chăm sóc da',
    'Khám tổng quát',
    'Vật lý trị liệu',
    'Bấm huyệt phục hồi',
    'Đào tạo kỹ thuật viên',
  ];

  final List<String> _typeFilters = [
    'Tất cả',
    'Dịch vụ',
    'Khóa học',
    'Chi nhánh',
    'Chuyên viên',
  ];

  String _selectedType = 'Tất cả';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialQuery ?? '');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchSubmitted(String query) {
    final trimmed = query.trim();
    if (trimmed.isNotEmpty && !_recentSearches.contains(trimmed)) {
      setState(() {
        _recentSearches.insert(0, trimmed);
      });
    }
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _selectedType = 'Tất cả';
    });
    context.read<HomeController>().setSearchQuery('');
  }

  @override
  Widget build(BuildContext context) {
    final home = context.watch<HomeController>();
    final courseCtrl = context.watch<CourseController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final queryText = _searchController.text.trim();
    final isSearching = queryText.isNotEmpty || _selectedType != 'Tất cả';

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          children: [
            // Top Header: Back Button
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.surfaceDark : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDark ? AppColors.borderDark : AppColors.borderLight,
                    ),
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                    size: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Main Title: "Bạn đang tìm kiếm điều gì?"
            Text(
              'Bạn đang tìm kiếm điều gì?',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 20),

            // Search Bar: Square Search Icon Button + Rounded Input Box
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.surfaceDark : Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isDark ? AppColors.borderDark : AppColors.borderLight,
                    ),
                  ),
                  child: const Icon(
                    Icons.search,
                    color: AppColors.primary,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.surfaceDark : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isDark ? AppColors.borderDark : AppColors.borderLight,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: TextField(
                      controller: _searchController,
                      onChanged: (val) {
                        setState(() {});
                        home.setSearchQuery(val);
                      },
                      onSubmitted: _onSearchSubmitted,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Tìm dịch vụ, khóa học, chuyên viên...',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        suffixIcon: _searchController.text.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _searchController.clear();
                                  });
                                  home.setSearchQuery('');
                                },
                                child: const Icon(Icons.clear, size: 18, color: AppColors.textSecondary),
                              )
                            : null,
                        suffixIconConstraints: const BoxConstraints(minWidth: 24, minHeight: 24),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // "Xóa tìm kiếm" Button
            Center(
              child: GestureDetector(
                onTap: _clearSearch,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Text(
                    'Xóa tìm kiếm',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Filter Pills
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _typeFilters.map((type) {
                final isSelected = _selectedType == type;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedType = type;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : (isDark ? AppColors.surfaceDark : Colors.white),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : (isDark ? AppColors.borderDark : AppColors.borderLight),
                      ),
                    ),
                    child: Text(
                      type,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected
                            ? Colors.white
                            : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 28),

            // Discovery vs Results
            if (!isSearching) ...[
              if (_recentSearches.isNotEmpty) ...[
                Text(
                  'Tìm kiếm gần đây',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 14),
                ..._recentSearches.map((term) => Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _searchController.text = term;
                          });
                          home.setSearchQuery(term);
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.history_rounded, color: AppColors.primary, size: 20),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                term,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _recentSearches.remove(term);
                                });
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(4),
                                child: Icon(Icons.close_rounded, color: AppColors.primary, size: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                const SizedBox(height: 18),
              ],

              Text(
                'Tìm kiếm phổ biến',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _popularSearches.map((term) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _searchController.text = term;
                      });
                      _onSearchSubmitted(term);
                      home.setSearchQuery(term);
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.surfaceDark : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isDark ? AppColors.borderDark : AppColors.borderLight,
                        ),
                      ),
                      child: Text(
                        term,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
            ] else ...[
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.surfaceDark : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.primary),
                    ),
                    child: const Text(
                      'Bộ lọc',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sắp xếp theo',
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark ? AppColors.textMutedDark : AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: isDark ? AppColors.surfaceDark : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isDark ? AppColors.borderDark : AppColors.borderLight,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'Phổ biến (minh họa)',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                size: 16,
                                color: isDark ? AppColors.textMutedDark : AppColors.textSecondary,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              _buildResults(context, home, courseCtrl),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildResults(
    BuildContext context,
    HomeController home,
    CourseController courseCtrl,
  ) {
    final query = _searchController.text.trim().toLowerCase();

    if (_selectedType == 'Khóa học') {
      final courses = courseCtrl.courses.where((c) {
        return query.isEmpty ||
            c.title.toLowerCase().contains(query) ||
            c.category.toLowerCase().contains(query);
      }).toList();

      if (courses.isEmpty) {
        return const EmptyState(
          icon: Icons.school_outlined,
          title: 'Không tìm thấy khóa học',
          message: 'Thử tìm với từ khóa học nghề hoặc danh mục khác.',
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${courses.length} khóa học phù hợp',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 16),
          ...courses.map((course) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CourseCard(
                  course: course,
                  onTap: () {
                    courseCtrl.selectCourse(course);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CourseDetailScreen(course: course),
                      ),
                    );
                  },
                ),
              )),
        ],
      );
    }

    if (_selectedType == 'Chuyên viên') {
      final doctors = home.doctors.where((d) {
        return query.isEmpty ||
            d.name.toLowerCase().contains(query) ||
            d.specialty.toLowerCase().contains(query);
      }).toList();

      if (doctors.isEmpty) {
        return const EmptyState(
          icon: Icons.person_search_outlined,
          title: 'Không tìm thấy chuyên viên',
          message: 'Vui lòng kiểm tra lại họ tên hoặc chuyên môn.',
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${doctors.length} chuyên gia & bác sĩ phù hợp',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 16),
          ...doctors.map((doc) => DoctorCard(
                doctor: doc,
                onTap: () {
                  final booking = context.read<BookingController>();
                  booking.startBooking(
                    service: home.services.first,
                    doctor: doc,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BookingFlowScreen(),
                    ),
                  );
                },
              )),
        ],
      );
    }

    final services = home.services.where((s) {
      return query.isEmpty ||
          s.name.toLowerCase().contains(query) ||
          s.category.toLowerCase().contains(query) ||
          s.description.toLowerCase().contains(query);
    }).toList();

    if (services.isEmpty) {
      return const EmptyState(
        icon: Icons.search_off_rounded,
        title: 'Không tìm thấy dịch vụ phù hợp',
        message: 'Vui lòng thử tìm kiếm với từ khóa khác.',
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${services.length} dịch vụ phù hợp',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 16),
        ...services.map((service) => ServiceCard(
              service: service,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ServiceDetailScreen(service: service),
                  ),
                );
              },
              onBookNow: () {
                final booking = context.read<BookingController>();
                booking.startBooking(service: service);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const BookingFlowScreen(),
                  ),
                );
              },
            )),
      ],
    );
  }
}

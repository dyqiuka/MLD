import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'package:prj/core/widgets/empty_state.dart';
import 'package:prj/core/widgets/service_card.dart';
import 'package:prj/features/home_service/presentation/controllers/home_controller.dart';
import 'search_discovery_screen.dart';
import 'service_detail_screen.dart';

/// Frame 2 in Group B: Services Screen ("Dịch vụ chăm sóc")
class AllServicesScreen extends StatefulWidget {
  const AllServicesScreen({super.key});

  @override
  State<AllServicesScreen> createState() => _AllServicesScreenState();
}

class _AllServicesScreenState extends State<AllServicesScreen> {
  late final TextEditingController _searchController;
  String _selectedSort = 'Phổ biến (minh họa)';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openSearchDiscovery() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SearchDiscoveryScreen(initialQuery: _searchController.text),
      ),
    ).then((_) {
      setState(() {});
    });
  }

  void _showSortModal(BuildContext context) {
    final sortOptions = [
      'Phổ biến (minh họa)',
      'Giá: Thấp đến cao',
      'Giá: Cao đến thấp',
      'Thời lượng ngắn nhất',
      'Đánh giá cao nhất',
    ];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Text(
                    'Sắp xếp dịch vụ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const Divider(),
                ...sortOptions.map((opt) {
                  final isChosen = _selectedSort == opt;
                  return ListTile(
                    title: Text(
                      opt,
                      style: TextStyle(
                        fontSize: 14.5,
                        fontWeight: isChosen ? FontWeight.w700 : FontWeight.w500,
                        color: isChosen ? AppColors.primary : AppColors.textPrimary,
                      ),
                    ),
                    trailing: isChosen ? const Icon(Icons.check, color: AppColors.primary) : null,
                    onTap: () {
                      setState(() {
                        _selectedSort = opt;
                      });
                      Navigator.pop(ctx);
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final home = context.watch<HomeController>();
    var services = List.from(home.filteredServices);
    if (_selectedSort == 'Giá: Thấp đến cao') {
      services.sort((a, b) => a.price.compareTo(b.price));
    } else if (_selectedSort == 'Giá: Cao đến thấp') {
      services.sort((a, b) => b.price.compareTo(a.price));
    } else if (_selectedSort == 'Thời lượng ngắn nhất') {
      services.sort((a, b) => a.durationMinutes.compareTo(b.durationMinutes));
    } else if (_selectedSort == 'Đánh giá cao nhất') {
      services.sort((a, b) => b.rating.compareTo(a.rating));
    }
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          children: [
            // Top Title
            Text(
              'Dịch vụ chăm sóc',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 6),

            // Subtitle
            Text(
              'Khám phá dịch vụ phù hợp với nhu cầu của bạn.',
              style: TextStyle(
                fontSize: 14,
                color: isDark ? AppColors.textMutedDark : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 18),

            // Search Bar Row (Square Search Button + Rounded Input Box)
            Row(
              children: [
                InkWell(
                  onTap: _openSearchDiscovery,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.surfaceDark : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isDark ? AppColors.borderDark : const Color(0xFFE5DDD5),
                      ),
                    ),
                    child: const Icon(
                      Icons.search,
                      color: AppColors.primary,
                      size: 22,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.surfaceDark : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isDark ? AppColors.borderDark : const Color(0xFFE5DDD5),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: TextField(
                      controller: _searchController,
                      onChanged: (val) {
                        home.setSearchQuery(val);
                        setState(() {});
                      },
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Tìm dịch vụ chăm sóc...',
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
                                  _searchController.clear();
                                  home.setSearchQuery('');
                                  setState(() {});
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
            const SizedBox(height: 18),

            // Categories Filter Tabs in EXACT ORDER of Figma Group B:
            // Row 1: Tất cả, Massage, Chăm sóc da
            // Row 2: Chăm sóc cơ thể, Thư giãn
            // Row 3: Gói liệu trình
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: home.categories.map((cat) {
                final isSelected = home.selectedCategory == cat;
                return GestureDetector(
                  onTap: () => home.selectCategory(cat),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : (isDark ? AppColors.surfaceDark : Colors.white),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : (isDark ? AppColors.borderDark : const Color(0xFFE5DDD5)),
                      ),
                    ),
                    child: Text(
                      cat,
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
            const SizedBox(height: 20),

            // Filters and Sorting Row (Bộ lọc & Sắp xếp theo)
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => _showSortModal(context),
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.surfaceDark : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.primary, width: 1.2),
                    ),
                    child: const Text(
                      'Bộ lọc',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Sắp xếp theo',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w500,
                          color: isDark ? AppColors.textMutedDark : AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      InkWell(
                        onTap: () => _showSortModal(context),
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 44,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: isDark ? AppColors.surfaceDark : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isDark ? AppColors.borderDark : const Color(0xFFE5DDD5),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  _selectedSort,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                size: 18,
                                color: isDark ? AppColors.textMutedDark : AppColors.textSecondary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Results Counter
            Text(
              '${services.length} dịch vụ phù hợp',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),

            // Services List
            if (services.isEmpty)
              const EmptyState(
                icon: Icons.search_off_rounded,
                title: 'Không tìm thấy dịch vụ phù hợp',
                message: 'Vui lòng thử chọn danh mục khác hoặc tìm kiếm với từ khóa khác.',
              )
            else
              ...services.map(
                (service) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ServiceCard(
                    service: service,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ServiceDetailScreen(service: service),
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

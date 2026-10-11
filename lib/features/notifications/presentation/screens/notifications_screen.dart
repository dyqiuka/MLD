import 'package:flutter/material.dart';
import 'package:prj/core/theme/app_colors.dart';

/// Frame D08 in Group D: Thông báo
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  int _selectedFilter = 0; // 0: Tất cả, 1: Lịch hẹn, 2: Liệu trình, 3: Đào tạo
  final List<String> _filters = ['Tất cả', 'Lịch hẹn', 'Liệu trình', 'Đào tạo'];

  final List<Map<String, dynamic>> _todayNotifications = [
    {
      'id': 'notif_01',
      'title': 'Nhắc lịch chăm sóc',
      'body': 'Bạn có lịch massage vào 09:00 ngày 15/10/2026.',
      'time': '08/10/2026 · 09:30 · Chưa đọc',
      'type': 'Lịch hẹn',
      'isRead': false,
      'icon': Icons.calendar_today_outlined,
      'color': Color(0xFFD97706),
    },
    {
      'id': 'notif_02',
      'title': 'Cập nhật liệu trình',
      'body': 'Gói chăm sóc của bạn còn 6 buổi sử dụng.',
      'time': '08/10/2026 · 09:15 · Chưa đọc',
      'type': 'Liệu trình',
      'isRead': false,
      'icon': Icons.spa_outlined,
      'color': Color(0xFF10B981),
    },
  ];

  final List<Map<String, dynamic>> _yesterdayNotifications = [
    {
      'id': 'notif_03',
      'title': 'Hoàn thành dịch vụ',
      'body': 'Cảm ơn bạn đã sử dụng dịch vụ tại Chi nhánh Quận 3.',
      'time': '07/10/2026 · 16:00 · Đã đọc',
      'type': 'Liệu trình',
      'isRead': true,
      'icon': Icons.check_circle_outline,
      'color': Color(0xFF8B5E34),
    },
    {
      'id': 'notif_04',
      'title': 'Thông báo khóa học',
      'body': 'Lịch khai giảng khóa Kỹ thuật viên Spa chuyên nghiệp đã mở đăng ký.',
      'time': '07/10/2026 · 10:00 · Đã đọc',
      'type': 'Đào tạo',
      'isRead': true,
      'icon': Icons.school_outlined,
      'color': Color(0xFF6366F1),
    },
  ];

  void _markAllAsRead() {
    setState(() {
      for (var n in _todayNotifications) {
        n['isRead'] = true;
        n['time'] = (n['time'] as String).replaceAll('Chưa đọc', 'Đã đọc');
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đã đánh dấu tất cả thông báo là đã đọc.'),
        backgroundColor: Color(0xFF8B5E34),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final filterText = _filters[_selectedFilter];
    final filteredToday = _selectedFilter == 0
        ? _todayNotifications
        : _todayNotifications.where((n) => n['type'] == filterText).toList();
    final filteredYesterday = _selectedFilter == 0
        ? _yesterdayNotifications
        : _yesterdayNotifications.where((n) => n['type'] == filterText).toList();

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
                    // Header & Mark All Read
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Thông báo',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF2C241E),
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                'Cập nhật lịch hẹn và các hoạt động chăm sóc của bạn.',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF7A6E65),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Action row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.tune_rounded, size: 20, color: Color(0xFF7A6E65)),
                        InkWell(
                          onTap: _markAllAsRead,
                          child: const Text(
                            'Đánh dấu đã đọc',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF8B5E34),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Filter Pills
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(_filters.length, (idx) {
                          final isSelected = _selectedFilter == idx;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: InkWell(
                              onTap: () => setState(() => _selectedFilter = idx),
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
                                  _filters[idx],
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
                    const SizedBox(height: 12),

                    const Text(
                      'Thông báo minh họa · Không phải ưu đãi hoặc ghi danh thực.',
                      style: TextStyle(
                        fontSize: 11.5,
                        color: Color(0xFF9E9187),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Section: Hôm nay · 08/10/2026
                    if (filteredToday.isNotEmpty) ...[
                      const Text(
                        'Hôm nay · 08/10/2026',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2C241E),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...filteredToday.map((n) => _buildNotificationCard(n, isDark)),
                      const SizedBox(height: 16),
                    ],

                    // Section: Hôm qua · 07/10/2026
                    if (filteredYesterday.isNotEmpty) ...[
                      const Text(
                        'Hôm qua · 07/10/2026',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2C241E),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...filteredYesterday.map((n) => _buildNotificationCard(n, isDark)),
                      const SizedBox(height: 16),
                    ],

                    if (filteredToday.isEmpty && filteredYesterday.isEmpty)
                      Container(
                        padding: const EdgeInsets.all(32),
                        alignment: Alignment.center,
                        child: const Text(
                          'Không có thông báo phù hợp trong mục này.',
                          style: TextStyle(color: Color(0xFF7A6E65)),
                        ),
                      ),

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

  Widget _buildNotificationCard(Map<String, dynamic> n, bool isDark) {
    final isRead = n['isRead'] as bool;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.borderDark : const Color(0xFFEADBCE),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F1EB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(n['icon'] as IconData, color: n['color'] as Color, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      n['title'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2C241E),
                      ),
                    ),
                    if (!isRead)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFFD97706),
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  n['body'] as String,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: Color(0xFF5A4D41),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  n['time'] as String,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF9E9187),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

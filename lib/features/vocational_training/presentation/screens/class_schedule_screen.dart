import 'package:flutter/material.dart';
import 'package:prj/core/theme/app_colors.dart';

/// Frame E11 in Group E: Lịch học & điểm danh
class ClassScheduleScreen extends StatefulWidget {
  const ClassScheduleScreen({super.key});

  @override
  State<ClassScheduleScreen> createState() => _ClassScheduleScreenState();
}

class _ClassScheduleScreenState extends State<ClassScheduleScreen> {
  int _selectedDay = 16;

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
                      'Lịch học & điểm danh',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2C241E),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Chủ động theo dõi lịch đào tạo và các buổi thực hành.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF7A6E65),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Calendar Widget Box
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
                        children: [
                          // Calendar Header
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Icon(Icons.chevron_left, color: Color(0xFF8B5E34)),
                              Text(
                                'Tháng 10, 2026',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF2C241E),
                                ),
                              ),
                              Icon(Icons.chevron_right, color: Color(0xFF8B5E34)),
                            ],
                          ),
                          const SizedBox(height: 14),

                          // Days of Week
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              _CalText('T2'), _CalText('T3'), _CalText('T4'), _CalText('T5'),
                              _CalText('T6'), _CalText('T7'), _CalText('CN'),
                            ],
                          ),
                          const SizedBox(height: 10),

                          // Grid of days (minh họa)
                          _buildCalendarGrid(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Legend
                    Text(
                      '$_selectedDay/10/2026 đang chọn · Lịch và các buổi sự kiện là minh họa.',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF8B5E34)),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      children: const [
                        _LegendDot(color: Color(0xFF3B82F6), label: 'Trực tuyến'),
                        _LegendDot(color: Color(0xFF10B981), label: 'Tại lớp'),
                        _LegendDot(color: Color(0xFFD97706), label: 'Thực hành'),
                        _LegendDot(color: Color(0xFF8B5E34), label: 'Kiểm tra'),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Event Card for the selected date
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.surfaceDark : const Color(0xFFF7F1EB),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isDark ? AppColors.borderDark : const Color(0xFFEADBCE),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'Thứ 6 · $_selectedDay/10/2026',
                                  style: const TextStyle(
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF2C241E),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD97706).withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  '13:00–17:00',
                                  style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: Color(0xFFD97706)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          const Text(
                            'Thực hành kỹ thuật massage cơ bản tại phòng Lab 02',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2C241E),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Chi nhánh Quận 3 · GV Nguyễn Thanh Hương',
                            style: TextStyle(fontSize: 12, color: Color(0xFF7A6E65)),
                          ),
                          const SizedBox(height: 12),

                          Row(
                            children: const [
                              Icon(Icons.check_circle, size: 16, color: Color(0xFF10B981)),
                              SizedBox(width: 6),
                              Text(
                                'Điểm danh có mặt (mô phỏng)',
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF10B981)),
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
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    // 5 rows
    final dates = [
      ['', '', '', '1', '2', '3', '4'],
      ['5', '6', '7', '8', '9', '10', '11'],
      ['12', '13', '14', '15', '16', '17', '18'],
      ['19', '20', '21', '22', '23', '24', '25'],
      ['26', '27', '28', '29', '30', '31', ''],
    ];

    return Column(
      children: dates.map((row) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: row.map((d) {
              if (d.isEmpty) {
                return const SizedBox(width: 34, height: 34);
              }
              final isSelected = d == '$_selectedDay';
              final dayNum = int.tryParse(d) ?? 0;
              final hasEvent = [9, 10, 16, 17, 23, 24].contains(dayNum);

              return InkWell(
                onTap: () => setState(() => _selectedDay = dayNum),
                borderRadius: BorderRadius.circular(17),
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF8B5E34) : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        d,
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                          color: isSelected ? Colors.white : const Color(0xFF2C241E),
                        ),
                      ),
                      if (hasEvent && !isSelected)
                        Container(
                          width: 4,
                          height: 4,
                          decoration: const BoxDecoration(
                            color: Color(0xFFD97706),
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}

class _CalText extends StatelessWidget {
  final String text;
  const _CalText(this.text);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 34,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: Color(0xFF7A6E65)),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF7A6E65))),
      ],
    );
  }
}

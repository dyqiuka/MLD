import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'package:prj/core/utils/formatters.dart';
import 'package:prj/core/widgets/custom_button.dart';
import 'package:prj/features/booking_payment/presentation/controllers/booking_controller.dart';
import 'package:prj/features/home_service/presentation/controllers/home_controller.dart';
import 'appointment_detail_screen.dart';
import 'my_appointments_screen.dart';

/// Sequential Booking Flow: Frames C01 -> C08 of Figma Group C
class BookingFlowScreen extends StatefulWidget {
  final int initialStep;

  const BookingFlowScreen({super.key, this.initialStep = 0});

  @override
  State<BookingFlowScreen> createState() => _BookingFlowScreenState();
}

class _BookingFlowScreenState extends State<BookingFlowScreen> {
  late int _currentStep; // 0 to 7 (Frames C01 to C08)
  
  // Step 1: Category & Search filter
  String _selectedCategory = 'Tất cả';
  String _serviceSearch = '';
  final List<String> _serviceCategories = [
    'Tất cả',
    'Massage thư giãn',
    'Chăm sóc da',
    'Chăm sóc cơ thể',
    'Chăm sóc sức khỏe',
    'Gói liệu trình',
  ];

  // Step 2: Branch & City
  String _selectedCity = 'Tất cả tỉnh / thành phố';
  bool _isListView = true;
  final List<String> _cities = [
    'Tất cả tỉnh / thành phố',
    'TP. Hồ Chí Minh',
    'Hà Nội',
    'Đà Nẵng',
    'Hải Phòng',
    'Cần Thơ',
    'Bình Dương',
    'Đồng Nai',
    'Bà Rịa - Vũng Tàu',
  ];

  final List<Map<String, dynamic>> _branches = [
    {
      'id': 'br_01',
      'name': 'Chi nhánh mẫu 01 – Quận 3',
      'city': 'TP. Hồ Chí Minh',
      'address': '123 Đường Mẫu, Phường Võ Thị Sáu, Quận 3, TP. Hồ Chí Minh',
      'hours': '09:00 - 20:00 • Cả tuần',
      'image': 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?w=500',
    },
    {
      'id': 'br_02',
      'name': 'Chi nhánh mẫu 02 – Cầu Giấy',
      'city': 'Hà Nội',
      'address': '45 Đường Duy Tân, Dịch Vọng Hậu, Cầu Giấy, Hà Nội',
      'hours': '09:00 - 20:00 • Cả tuần',
      'image': 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=500',
    },
    {
      'id': 'br_03',
      'name': 'Chi nhánh mẫu 03 – Quận 1',
      'city': 'TP. Hồ Chí Minh',
      'address': '88 Lê Lợi, Phường Bến Nghé, Quận 1, TP. Hồ Chí Minh',
      'hours': '08:30 - 21:00 • Cả tuần',
      'image': 'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=500',
    },
    {
      'id': 'br_04',
      'name': 'Chi nhánh mẫu 04 – Thảo Điền',
      'city': 'TP. Hồ Chí Minh',
      'address': '12 Quốc Hương, Thảo Điền, TP. Thủ Đức, TP. Hồ Chí Minh',
      'hours': '09:00 - 20:30 • Cả tuần',
      'image': 'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881?w=500',
    },
    {
      'id': 'br_05',
      'name': 'Chi nhánh mẫu 05 – Hoàn Kiếm',
      'city': 'Hà Nội',
      'address': '26 Tràng Tiền, Phường Tràng Tiền, Hoàn Kiếm, Hà Nội',
      'hours': '09:00 - 21:00 • Cả tuần',
      'image': 'https://images.unsplash.com/photo-1512290900672-1f55b9e59d47?w=500',
    },
    {
      'id': 'br_06',
      'name': 'Chi nhánh mẫu 06 – Hải Châu',
      'city': 'Đà Nẵng',
      'address': '150 Bạch Đằng, Phường Hải Châu 1, Hải Châu, Đà Nẵng',
      'hours': '09:00 - 20:00 • Cả tuần',
      'image': 'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?w=500',
    },
    {
      'id': 'br_07',
      'name': 'Chi nhánh mẫu 07 – Ninh Kiều',
      'city': 'Cần Thơ',
      'address': '30 Đại lộ Hòa Bình, Ninh Kiều, Cần Thơ',
      'hours': '08:30 - 20:30 • Cả tuần',
      'image': 'https://images.unsplash.com/photo-1507652313519-d4e9174996dd?w=500',
    },
    {
      'id': 'br_08',
      'name': 'Chi nhánh mẫu 08 – Lê Chân',
      'city': 'Hải Phòng',
      'address': '105 Trần Phú, Lê Chân, Hải Phòng',
      'hours': '09:00 - 20:00 • Cả tuần',
      'image': 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?w=500',
    },
    {
      'id': 'br_09',
      'name': 'Chi nhánh mẫu 09 – Thủ Dầu Một',
      'city': 'Bình Dương',
      'address': '230 Đại lộ Bình Dương, Thủ Dầu Một, Bình Dương',
      'hours': '08:30 - 20:30 • Cả tuần',
      'image': 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=500',
    },
  ];

  // Step 4: Datetime (Dynamic Month & Day selection)
  late DateTime _activeMonth;
  late DateTime _selectedDate;

  List<DateTime> get _computedDays {
    int start = 1;
    if (_selectedDate.year == _activeMonth.year && _selectedDate.month == _activeMonth.month) {
      if (_selectedDate.day > 5) {
        start = (_selectedDate.day - 3).clamp(1, 22);
      }
    } else {
      start = 10;
    }
    return List.generate(7, (i) => DateTime(_activeMonth.year, _activeMonth.month, start + i));
  }

  String _formatDow(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'T2';
      case DateTime.tuesday:
        return 'T3';
      case DateTime.wednesday:
        return 'T4';
      case DateTime.thursday:
        return 'T5';
      case DateTime.friday:
        return 'T6';
      case DateTime.saturday:
        return 'T7';
      default:
        return 'CN';
    }
  }

  // Step 5: Customer controllers
  late final TextEditingController _nameCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _emailCtrl;

  @override
  void initState() {
    super.initState();
    _currentStep = widget.initialStep;
    final booking = context.read<BookingController>();
    _selectedDate = booking.selectedDate;
    _activeMonth = DateTime(booking.selectedDate.year, booking.selectedDate.month, 1);
    _nameCtrl = TextEditingController(text: booking.customerName);
    _phoneCtrl = TextEditingController(text: booking.customerPhone);
    _emailCtrl = TextEditingController(text: booking.customerEmail);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  void _showCityPickerModal(BuildContext context, bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Chọn tỉnh / thành phố',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 20),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView.builder(
                  itemCount: _cities.length,
                  itemBuilder: (ctx, idx) {
                    final city = _cities[idx];
                    final isSelected = _selectedCity == city;
                    return ListTile(
                      title: Text(
                        city,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected ? AppColors.primary : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary),
                        ),
                      ),
                      trailing: isSelected
                          ? const Icon(Icons.check_circle, color: AppColors.primary, size: 20)
                          : null,
                      onTap: () {
                        setState(() {
                          _selectedCity = city;
                        });
                        Navigator.pop(ctx);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _nextStep() {
    if (_currentStep < 7) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final booking = context.watch<BookingController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
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
                    onTap: _prevStep,
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
                      child: const Icon(Icons.arrow_back, color: AppColors.textPrimary, size: 20),
                    ),
                  ),
                  const Text(
                    'ĐẶT LỊCH · MINH HỌA',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF8B5E34),
                      letterSpacing: 0.5,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MyAppointmentsScreen(),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.surfaceDark : const Color(0xFFFBF8F5),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isDark ? AppColors.borderDark : const Color(0xFFE5DDD5),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.calendar_month_outlined, size: 14, color: Color(0xFF8B5E34)),
                          SizedBox(width: 4),
                          Text(
                            'Lịch hẹn',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF8B5E34),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Stepper indicator (4 steps)
            _buildStepper(isDark),
            const SizedBox(height: 12),

            // Body content according to _currentStep
            Expanded(
              child: _buildCurrentStepContent(context, booking, isDark),
            ),

            // Bottom Sticky Bar
            _buildBottomBar(context, booking, isDark),
          ],
        ),
      ),
    );
  }

  // Stepper Header: Dịch vụ -> Lịch hẹn -> Xác nhận -> Hoàn tất
  Widget _buildStepper(bool isDark) {
    // Determine which steps are active based on _currentStep:
    // C01 (0): step 0 active
    // C02, C03, C04 (1, 2, 3): steps 0, 1 active
    // C05, C06 (4, 5): steps 0, 1, 2 active
    // C07, C08 (6, 7): steps 0, 1, 2, 3 active
    final stepProgress = [
      _currentStep >= 0,
      _currentStep >= 1,
      _currentStep >= 4,
      _currentStep >= 6,
    ];

    final labels = ['Dịch vụ', 'Lịch hẹn', 'Xác nhận', 'Hoàn tất'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Row(
        children: List.generate(4, (i) {
          final isActive = stepProgress[i];
          return Expanded(
            child: Container(
              margin: EdgeInsets.only(right: i < 3 ? 8 : 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 3,
                    decoration: BoxDecoration(
                      color: isActive ? AppColors.primary : const Color(0xFFE5DDD5),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    labels[i],
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                      color: isActive ? AppColors.primary : (isDark ? AppColors.textMutedDark : AppColors.textSecondary),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCurrentStepContent(BuildContext context, BookingController booking, bool isDark) {
    switch (_currentStep) {
      case 0:
        return _buildStep01SelectService(context, booking, isDark);
      case 1:
        return _buildStep02SelectBranch(context, booking, isDark);
      case 2:
        return _buildStep03SelectSpecialist(context, booking, isDark);
      case 3:
        return _buildStep04SelectDateTime(context, booking, isDark);
      case 4:
        return _buildStep05IntakeInfo(context, booking, isDark);
      case 5:
        return _buildStep06ConfirmBooking(context, booking, isDark);
      case 6:
        return _buildStep07Payment(context, booking, isDark);
      case 7:
        return _buildStep08BookingSuccess(context, booking, isDark);
      default:
        return const SizedBox.shrink();
    }
  }

  // FRAME C01: Chọn dịch vụ
  Widget _buildStep01SelectService(BuildContext context, BookingController booking, bool isDark) {
    final home = context.watch<HomeController>();
    final filtered = home.services.where((srv) {
      final matchesCat = _selectedCategory == 'Tất cả' ||
          srv.category.toLowerCase().contains(_selectedCategory.toLowerCase()) ||
          _selectedCategory.toLowerCase().contains(srv.category.toLowerCase());
      final matchesQuery = _serviceSearch.isEmpty ||
          srv.name.toLowerCase().contains(_serviceSearch.toLowerCase());
      return matchesCat && matchesQuery;
    }).toList();
    final services = filtered.isEmpty ? home.services : filtered;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      children: [
        Text(
          'Chọn dịch vụ',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Lựa chọn dịch vụ chăm sóc phù hợp với bạn.',
          style: TextStyle(fontSize: 14, color: isDark ? AppColors.textMutedDark : AppColors.textSecondary),
        ),
        const SizedBox(height: 18),

        // Search Bar
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isDark ? AppColors.borderDark : const Color(0xFFE5DDD5)),
          ),
          child: Row(
            children: [
              const Icon(Icons.search, size: 20, color: AppColors.primary),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  onChanged: (val) => setState(() => _serviceSearch = val),
                  decoration: InputDecoration(
                    hintText: 'Tìm dịch vụ chăm sóc...',
                    hintStyle: TextStyle(fontSize: 13, color: isDark ? AppColors.textMutedDark : AppColors.textSecondaryLight),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Category Pills
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _serviceCategories.map((cat) {
            final isSelected = _selectedCategory == cat;
            return GestureDetector(
              onTap: () => setState(() => _selectedCategory = cat),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : (isDark ? AppColors.surfaceDark : Colors.white),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : const Color(0xFFE5DDD5),
                  ),
                ),
                child: Text(
                  cat,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected ? Colors.white : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),

        // Service Card (with checkmark)
        ...services.map((srv) {
          final isChosen = booking.selectedService?.id == srv.id;
          return GestureDetector(
            onTap: () => booking.selectService(srv),
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isChosen ? AppColors.primary : const Color(0xFFE5DDD5),
                  width: isChosen ? 1.8 : 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            color: isChosen ? AppColors.primary : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: isChosen ? AppColors.primary : const Color(0xFFBCAAA4),
                              width: 1.5,
                            ),
                          ),
                          child: isChosen
                              ? const Icon(Icons.check, size: 16, color: Colors.white)
                              : null,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            isChosen ? 'Đã chọn · ${srv.name}' : srv.name,
                            style: TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(15)),
                    child: Image.network(
                      srv.imageUrl,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  // FRAME C02: Chọn chi nhánh
  Widget _buildStep02SelectBranch(BuildContext context, BookingController booking, bool isDark) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      children: [
        Text(
          'Chọn chi nhánh',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Bạn muốn trải nghiệm dịch vụ tại cơ sở nào?',
          style: TextStyle(fontSize: 14, color: isDark ? AppColors.textMutedDark : AppColors.textSecondary),
        ),
        const SizedBox(height: 18),

        // Search Bar
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE5DDD5)),
          ),
          child: const Row(
            children: [
              Icon(Icons.search, size: 20, color: AppColors.primary),
              SizedBox(width: 10),
              Text('Tìm dịch vụ chăm sóc...', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // City Dropdown
        Text(
          'Tỉnh / thành phố',
          style: TextStyle(fontSize: 12, color: isDark ? AppColors.textMutedDark : AppColors.textSecondary),
        ),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: () => _showCityPickerModal(context, isDark),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE5DDD5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedCity,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down, size: 20, color: AppColors.textSecondary),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // View Mode Switch: [ Danh sách ] [ Bản đồ ]
        Row(
          children: [
            GestureDetector(
              onTap: () => setState(() => _isListView = true),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                decoration: BoxDecoration(
                  color: _isListView ? AppColors.primary : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _isListView ? AppColors.primary : const Color(0xFFE5DDD5)),
                ),
                child: Text(
                  'Danh sách',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: _isListView ? Colors.white : AppColors.textPrimary,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => setState(() => _isListView = false),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                decoration: BoxDecoration(
                  color: !_isListView ? AppColors.primary : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: !_isListView ? AppColors.primary : const Color(0xFFE5DDD5)),
                ),
                child: Text(
                  'Bản đồ',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: !_isListView ? Colors.white : AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Dynamic Branch Cards filtered by city
        ...() {
          final list = _selectedCity == 'Tất cả tỉnh / thành phố'
              ? _branches
              : _branches.where((b) => b['city'] == _selectedCity).toList();
          final displayList = list.isEmpty ? _branches : list;

          return displayList.map((branch) {
            final isChosen = booking.selectedBranch == branch['name'];
            return GestureDetector(
              onTap: () {
                booking.selectBranch(branch['name'], branch['address']);
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isChosen ? AppColors.primary : const Color(0xFFE5DDD5),
                    width: isChosen ? 1.8 : 1.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 22,
                            height: 22,
                            margin: const EdgeInsets.only(top: 2),
                            decoration: BoxDecoration(
                              color: isChosen ? AppColors.primary : Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: isChosen ? AppColors.primary : const Color(0xFFBCAAA4),
                                width: 1.5,
                              ),
                            ),
                            child: isChosen ? const Icon(Icons.check, size: 16, color: Colors.white) : null,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  branch['name'],
                                  style: TextStyle(
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w700,
                                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  branch['address'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark ? AppColors.textMutedDark : AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  branch['hours'],
                                  style: const TextStyle(
                                    fontSize: 11.5,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(15)),
                      child: Image.network(
                        branch['image'],
                        height: 140,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(height: 140, color: const Color(0xFFE5DDD5)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        }(),
      ],
    );
  }

  // FRAME C03: Chọn chuyên viên
  Widget _buildStep03SelectSpecialist(BuildContext context, BookingController booking, bool isDark) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      children: [
        Text(
          'Chọn chuyên viên',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Chọn người đồng hành cùng bạn trong buổi chăm sóc.',
          style: TextStyle(fontSize: 14, color: isDark ? AppColors.textMutedDark : AppColors.textSecondary),
        ),
        const SizedBox(height: 18),

        // Option 1: Để trung tâm sắp xếp
        GestureDetector(
          onTap: () {
            booking.selectSpecialist(
              name: 'Trung tâm sắp xếp',
              title: 'Chuyên viên phù hợp',
              isAuto: true,
            );
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: booking.autoAssignSpecialist ? AppColors.primary : const Color(0xFFE5DDD5),
                width: booking.autoAssignSpecialist ? 1.5 : 1.0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      booking.autoAssignSpecialist ? Icons.radio_button_checked : Icons.radio_button_off,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Để trung tâm sắp xếp',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Hệ thống sẽ lựa chọn chuyên viên phù hợp với dịch vụ và lịch hẹn.\nChỉ phân công người đủ chuyên môn; đây là lựa chọn minh họa.',
                  style: TextStyle(fontSize: 12.5, color: isDark ? AppColors.textMutedDark : AppColors.textSecondary, height: 1.4),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Specialist filter dropdown
        Text(
          'Lọc theo chuyên môn',
          style: TextStyle(fontSize: 12, color: isDark ? AppColors.textMutedDark : AppColors.textSecondary),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE5DDD5)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Massage · Chi nhánh mẫu 01 — Quận 3',
                style: TextStyle(fontSize: 13.5, color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary),
              ),
              const Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.textSecondary),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Specialist Card: Trần Minh Phương
        GestureDetector(
          onTap: () {
            booking.selectSpecialist(
              name: 'Trần Minh Phương',
              title: 'Kỹ thuật viên massage',
              isAuto: false,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : const Color(0xFFFBF4ED),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: !booking.autoAssignSpecialist ? AppColors.primary : const Color(0xFFE5DDD5),
                width: 1.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(Icons.check, size: 16, color: Colors.white),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Chuyên viên ưu tiên',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1594824813590-b18bb3901b0b?w=200',
                          width: 68,
                          height: 68,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Trần Minh Phương',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Kỹ thuật viên massage',
                              style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Hồ sơ minh họa',
                              style: TextStyle(fontSize: 11.5, color: Color(0xFF8B5E34), fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // FRAME C04: Chọn ngày và giờ
  Widget _buildStep04SelectDateTime(BuildContext context, BookingController booking, bool isDark) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      children: [
        Text(
          'Chọn ngày và giờ',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Lựa chọn thời gian phù hợp với lịch của bạn.',
          style: TextStyle(fontSize: 14, color: isDark ? AppColors.textMutedDark : AppColors.textSecondary),
        ),
        const SizedBox(height: 16),

        // Summary banner
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : const Color(0xFFF5EBE1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                booking.selectedService?.name ?? 'Massage thư giãn toàn thân',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 4),
              Text(
                '${booking.selectedBranch} · ${booking.selectedSpecialist} · ${booking.selectedService?.durationMinutes ?? 60} phút',
                style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Đang chọn', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  Text(
                    booking.selectedTimeSlot,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF8B5E34)),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // Date Picker Strip: < Tháng MM, YYYY >
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left, size: 24, color: AppColors.textPrimary),
              onPressed: () {
                setState(() {
                  _activeMonth = DateTime(_activeMonth.year, _activeMonth.month - 1, 1);
                  _selectedDate = DateTime(_activeMonth.year, _activeMonth.month, 10);
                });
                booking.selectDate(_selectedDate);
              },
            ),
            const SizedBox(width: 4),
            Text(
              'Tháng ${_activeMonth.month}, ${_activeMonth.year}',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: 4),
            IconButton(
              icon: const Icon(Icons.chevron_right, size: 24, color: AppColors.textPrimary),
              onPressed: () {
                setState(() {
                  _activeMonth = DateTime(_activeMonth.year, _activeMonth.month + 1, 1);
                  _selectedDate = DateTime(_activeMonth.year, _activeMonth.month, 10);
                });
                booking.selectDate(_selectedDate);
              },
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Days row dynamically rendered
        Row(
          children: _computedDays.map((dayDate) {
            final isChosen = _selectedDate.year == dayDate.year &&
                _selectedDate.month == dayDate.month &&
                _selectedDate.day == dayDate.day;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() => _selectedDate = dayDate);
                  booking.selectDate(dayDate);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: isChosen ? AppColors.primary : (isDark ? AppColors.surfaceDark : Colors.white),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isChosen ? AppColors.primary : const Color(0xFFE5DDD5),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        _formatDow(dayDate.weekday),
                        style: TextStyle(
                          fontSize: 11,
                          color: isChosen ? Colors.white70 : AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dayDate.day.toString().padLeft(2, '0'),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: isChosen ? Colors.white : AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 14),

        Center(
          child: InkWell(
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime(2025, 1, 1),
                lastDate: DateTime(2028, 12, 31),
                helpText: 'CHỌN NGÀY HẸN',
                cancelText: 'HỦY',
                confirmText: 'CHỌN',
              );
              if (picked != null) {
                setState(() {
                  _selectedDate = picked;
                  _activeMonth = DateTime(picked.year, picked.month, 1);
                });
                booking.selectDate(picked);
              }
            },
            borderRadius: BorderRadius.circular(8),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              child: Text(
                'Mở lịch tháng',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primary),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            '${_selectedDate.day.toString().padLeft(2, '0')}/${_selectedDate.month.toString().padLeft(2, '0')}/${_selectedDate.year} · Lịch hẹn minh họa.',
            style: TextStyle(fontSize: 11.5, color: isDark ? AppColors.textMutedDark : AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 18),

        // Slots: Buổi sáng & Buổi chiều
        Text('Buổi sáng', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _SlotChip(label: '09:00', isSelected: booking.selectedTimeSlot == '09:00', onSelect: () => booking.selectTimeSlot('09:00')),
            _SlotChip(label: '10:00', isSelected: booking.selectedTimeSlot == '10:00', onSelect: () => booking.selectTimeSlot('10:00')),
            _SlotChip(label: '11:00', isSelected: booking.selectedTimeSlot == '11:00', onSelect: () => booking.selectTimeSlot('11:00')),
          ],
        ),
        const SizedBox(height: 14),

        Text('Buổi chiều', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _SlotChip(label: '14:00–15:00', isSelected: booking.selectedTimeSlot == '14:00–15:00', onSelect: () => booking.selectTimeSlot('14:00–15:00')),
            _SlotChip(label: '15:30', isSelected: booking.selectedTimeSlot == '15:30', onSelect: () => booking.selectTimeSlot('15:30')),
            _SlotChip(label: '17:00', isSelected: booking.selectedTimeSlot == '17:00', onSelect: () => booking.selectTimeSlot('17:00')),
          ],
        ),
      ],
    );
  }

  // FRAME C05: Thông tin đặt lịch
  Widget _buildStep05IntakeInfo(BuildContext context, BookingController booking, bool isDark) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      children: [
        Text(
          'Thông tin đặt lịch',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Vui lòng kiểm tra và bổ sung thông tin người sử dụng dịch vụ.',
          style: TextStyle(fontSize: 14, color: isDark ? AppColors.textMutedDark : AppColors.textSecondary),
        ),
        const SizedBox(height: 20),

        // Radio self vs other
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5DDD5)),
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  booking.setCustomerInfo(
                    name: _nameCtrl.text,
                    phone: _phoneCtrl.text,
                    email: _emailCtrl.text,
                    isSelf: true,
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      booking.isBookingForSelf ? Icons.check_circle : Icons.radio_button_unchecked,
                      color: AppColors.primary,
                      size: 22,
                    ),
                    const SizedBox(width: 10),
                    const Text('Tôi sử dụng dịch vụ', style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () {
                  booking.setCustomerInfo(
                    name: _nameCtrl.text,
                    phone: _phoneCtrl.text,
                    email: _emailCtrl.text,
                    isSelf: false,
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      !booking.isBookingForSelf ? Icons.check_circle : Icons.radio_button_unchecked,
                      color: AppColors.primary,
                      size: 22,
                    ),
                    const SizedBox(width: 10),
                    const Text('Đặt cho người khác', style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Form Fields
        _buildInputField('Họ và tên *', _nameCtrl, isDark),
        const SizedBox(height: 14),
        _buildInputField('Số điện thoại *', _phoneCtrl, isDark, keyboard: TextInputType.phone),
        const SizedBox(height: 14),
        _buildInputField('Email (tùy chọn)', _emailCtrl, isDark, keyboard: TextInputType.emailAddress),
      ],
    );
  }

  Widget _buildInputField(String label, TextEditingController ctrl, bool isDark, {TextInputType keyboard = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: isDark ? AppColors.textMutedDark : AppColors.textSecondary)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE5DDD5)),
          ),
          child: TextField(
            controller: ctrl,
            keyboardType: keyboard,
            style: TextStyle(fontSize: 14, color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary),
            decoration: const InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.symmetric(vertical: 12)),
          ),
        ),
      ],
    );
  }

  // FRAME C06: Xác nhận đặt lịch
  Widget _buildStep06ConfirmBooking(BuildContext context, BookingController booking, bool isDark) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      children: [
        Text(
          'Xác nhận đặt lịch',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Kiểm tra thông tin trước khi hoàn tất.',
          style: TextStyle(fontSize: 14, color: isDark ? AppColors.textMutedDark : AppColors.textSecondary),
        ),
        const SizedBox(height: 16),

        // Notice banner
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : const Color(0xFFFBF4ED),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFEFE2D6)),
          ),
          child: Text(
            'Tóm tắt minh họa · Chưa phải lịch hẹn đã xác nhận. Cần có giữ chỗ hợp lệ trước khi xác nhận và đáp ứng điều kiện thanh toán của chi nhánh.',
            style: TextStyle(fontSize: 12.5, color: isDark ? AppColors.textMutedDark : AppColors.textSecondary, height: 1.45),
          ),
        ),
        const SizedBox(height: 18),

        // Service confirmation card
        Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5DDD5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  booking.selectedService?.imageUrl ?? 'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?w=500',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.selectedService?.name ?? 'Massage thư giãn toàn thân',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Text('Thời lượng chăm sóc', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                        ),
                        Text('${booking.selectedService?.durationMinutes ?? 60} phút', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: TextButton(
                        onPressed: () => setState(() => _currentStep = 0),
                        child: const Text('Sửa dịch vụ', style: TextStyle(color: Color(0xFF8B5E34), fontWeight: FontWeight.w700)),
                      ),
                    ),
                    const Divider(),
                    Text(booking.selectedBranch, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                    const SizedBox(height: 4),
                    Text(booking.branchAddress, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    const SizedBox(height: 6),
                    Center(
                      child: TextButton(
                        onPressed: () => setState(() => _currentStep = 1),
                        child: const Text('Sửa chi nhánh', style: TextStyle(color: Color(0xFF8B5E34), fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // FRAME C07: Thanh toán
  Widget _buildStep07Payment(BuildContext context, BookingController booking, bool isDark) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      children: [
        Text(
          'Thanh toán',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Chọn phương thức thanh toán thuận tiện cho bạn.',
          style: TextStyle(fontSize: 14, color: isDark ? AppColors.textMutedDark : AppColors.textSecondary),
        ),
        const SizedBox(height: 16),

        // Notice banner
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : const Color(0xFFFBF4ED),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.access_time, color: Color(0xFF8B5E34), size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Chờ thanh toán', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                    const SizedBox(height: 4),
                    Text(
                      'Minh họa tĩnh · Chưa xác nhận lịch hẹn. Không thực hiện thanh toán.',
                      style: TextStyle(fontSize: 12, color: isDark ? AppColors.textMutedDark : AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // Payment Option Box
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : const Color(0xFFF5EBE1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Thanh toán ngay 150.000đ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () => booking.setPaymentChoice('deposit'),
                child: Row(
                  children: [
                    Icon(
                      booking.paymentChoice == 'deposit' ? Icons.check_circle : Icons.radio_button_unchecked,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text('Đặt cọc 150.000đ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => booking.setPaymentChoice('full'),
                child: Row(
                  children: [
                    Icon(
                      booking.paymentChoice == 'full' ? Icons.check_circle : Icons.radio_button_unchecked,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text('Thanh toán toàn bộ 450.000đ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Còn 300.000đ thanh toán tại cơ sở. Giá và điều kiện đặt cọc là minh họa.',
                style: TextStyle(fontSize: 12, color: isDark ? AppColors.textMutedDark : AppColors.textSecondary),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Method Box
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : const Color(0xFFF5EBE1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Row(
            children: [
              Icon(Icons.check_circle, color: AppColors.primary, size: 20),
              SizedBox(width: 10),
              Expanded(
                child: Text('Chuyển khoản ngân hàng / QR', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // FRAME C08: Đặt lịch thành công!
  Widget _buildStep08BookingSuccess(BuildContext context, BookingController booking, bool isDark) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      children: [
        Text(
          'Đặt lịch thành công!',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Cảm ơn bạn đã lựa chọn dịch vụ của chúng tôi. Hẹn gặp bạn trong buổi chăm sóc sắp tới.',
          style: TextStyle(fontSize: 14, color: isDark ? AppColors.textMutedDark : AppColors.textSecondary),
        ),
        const SizedBox(height: 20),

        // Success Checkmark Circle
        Center(
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: const Color(0xFFF5EBE1),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFDCC8B4), width: 1.5),
            ),
            child: const Icon(Icons.check, size: 36, color: Color(0xFF8B5E34)),
          ),
        ),
        const SizedBox(height: 20),

        // Note
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : const Color(0xFFFBF4ED),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            'Minh họa sau khi giữ chỗ và thanh toán cọc thành công; không phải giao dịch thực.',
            style: TextStyle(fontSize: 12.5, color: isDark ? AppColors.textMutedDark : AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),

        // Ticket Card Preview
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE5DDD5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text('Đã xác nhận (mô phỏng)', style: TextStyle(color: Color(0xFF2E7D32), fontSize: 11, fontWeight: FontWeight.w700)),
              ),
              const SizedBox(height: 10),
              const Text('MÃ LỊCH HẸN · SPA-DEMO-000128', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF8B5E34))),
              const SizedBox(height: 8),
              Text(
                booking.selectedService?.name ?? 'Massage thư giãn toàn thân',
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 12),
              _previewRow('Ngày hẹn', '12/10/2026'),
              _previewRow('Giờ hẹn', booking.selectedTimeSlot),
              _previewRow('Chi nhánh', booking.selectedBranch),
              _previewRow('Chuyên viên', booking.selectedSpecialist),
              _previewRow('Khách hàng', booking.customerName),
            ],
          ),
        ),
      ],
    );
  }

  Widget _previewRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }

  // Bottom Sticky Bar based on _currentStep
  Widget _buildBottomBar(BuildContext context, BookingController booking, bool isDark) {
    String buttonText = 'Tiếp tục';
    VoidCallback onPressed = _nextStep;
    String? subtitleText;

    switch (_currentStep) {
      case 0: // C01
        subtitleText = '1 dịch vụ · ${booking.selectedService?.durationMinutes ?? 60} phút · ${Formatters.formatCurrency(booking.selectedService?.price ?? 450000)} · Giá minh họa';
        buttonText = 'Tiếp tục';
        onPressed = _nextStep;
        break;
      case 1: // C02
        subtitleText = 'Đang chọn: ${booking.selectedBranch}';
        buttonText = 'Tiếp tục chọn chuyên viên';
        onPressed = _nextStep;
        break;
      case 2: // C03
        buttonText = 'Chọn ngày và giờ';
        onPressed = _nextStep;
        break;
      case 3: // C04
        subtitleText = '12/10/2026 · ${booking.selectedTimeSlot} · 60 phút';
        buttonText = 'Tiếp tục';
        onPressed = _nextStep;
        break;
      case 4: // C05
        buttonText = 'Kiểm tra đặt lịch';
        onPressed = () {
          booking.setCustomerInfo(
            name: _nameCtrl.text.isEmpty ? 'Nguyễn Minh Anh' : _nameCtrl.text,
            phone: _phoneCtrl.text.isEmpty ? '0912 345 678' : _phoneCtrl.text,
            email: _emailCtrl.text.isEmpty ? 'minh.anh@example.com' : _emailCtrl.text,
            isSelf: booking.isBookingForSelf,
          );
          _nextStep();
        };
        break;
      case 5: // C06
        subtitleText = 'Tổng 450.000đ · Cọc minh họa 150.000đ';
        buttonText = 'Tiếp tục thanh toán';
        onPressed = _nextStep;
        break;
      case 6: // C07
        subtitleText = 'Chờ thanh toán · Trả ngay 150.000đ (minh họa)';
        buttonText = 'Thanh toán và hoàn tất';
        onPressed = () async {
          await booking.processPayment();
          _nextStep();
        };
        break;
      case 7: // C08
        buttonText = 'Xem lịch hẹn';
        onPressed = () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => AppointmentDetailScreen(booking: booking.lastConfirmedBooking),
            ),
          );
        };
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        border: Border(
          top: BorderSide(color: isDark ? AppColors.borderDark : const Color(0xFFE5DDD5)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (subtitleText != null) ...[
            Text(
              subtitleText,
              style: TextStyle(
                fontSize: 12.5,
                color: isDark ? AppColors.textMutedDark : AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
          ],
          CustomButton(
            text: buttonText,
            width: double.infinity,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}

class _SlotChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelect;

  const _SlotChip({required this.label, required this.isSelected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF8B5E34) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isSelected ? const Color(0xFF8B5E34) : const Color(0xFFE5DDD5)),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? Colors.white : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

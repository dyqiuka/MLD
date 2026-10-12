import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'package:prj/core/widgets/custom_button.dart';
import 'package:prj/features/booking_payment/presentation/controllers/booking_controller.dart';
import 'booking_flow_screen.dart';

class BranchListScreen extends StatefulWidget {
  const BranchListScreen({super.key});

  @override
  State<BranchListScreen> createState() => _BranchListScreenState();
}

class _BranchListScreenState extends State<BranchListScreen> {
  String _selectedCity = 'Tất cả tỉnh / thành phố';
  String _searchQuery = '';
  int _activeQuickFilter = 1; // 0: Gần tôi, 1: Danh sách, 2: Bản đồ

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
      'time': '09:00 - 20:00 • Cả tuần',
      'image': 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=600',
    },
    {
      'id': 'br_02',
      'name': 'Chi nhánh mẫu 02 – Cầu Giấy',
      'city': 'Hà Nội',
      'address': '45 Đường Duy Tân, Dịch Vọng Hậu, Cầu Giấy, Hà Nội',
      'time': '09:00 - 20:00 • Cả tuần',
      'image': 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?w=600',
    },
    {
      'id': 'br_03',
      'name': 'Chi nhánh mẫu 03 – Quận 1',
      'city': 'TP. Hồ Chí Minh',
      'address': '88 Lê Lợi, Phường Bến Nghé, Quận 1, TP. Hồ Chí Minh',
      'time': '08:30 - 21:00 • Cả tuần',
      'image': 'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=600',
    },
    {
      'id': 'br_04',
      'name': 'Chi nhánh mẫu 04 – Thảo Điền',
      'city': 'TP. Hồ Chí Minh',
      'address': '12 Quốc Hương, Thảo Điền, TP. Thủ Đức, TP. Hồ Chí Minh',
      'time': '09:00 - 20:30 • Cả tuần',
      'image': 'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881?w=600',
    },
    {
      'id': 'br_05',
      'name': 'Chi nhánh mẫu 05 – Hoàn Kiếm',
      'city': 'Hà Nội',
      'address': '26 Tràng Tiền, Phường Tràng Tiền, Hoàn Kiếm, Hà Nội',
      'time': '09:00 - 21:00 • Cả tuần',
      'image': 'https://images.unsplash.com/photo-1512290900672-1f55b9e59d47?w=600',
    },
    {
      'id': 'br_06',
      'name': 'Chi nhánh mẫu 06 – Hải Châu',
      'city': 'Đà Nẵng',
      'address': '150 Bạch Đằng, Phường Hải Châu 1, Hải Châu, Đà Nẵng',
      'time': '09:00 - 20:00 • Cả tuần',
      'image': 'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?w=600',
    },
    {
      'id': 'br_07',
      'name': 'Chi nhánh mẫu 07 – Ninh Kiều',
      'city': 'Cần Thơ',
      'address': '30 Đại lộ Hòa Bình, Ninh Kiều, Cần Thơ',
      'time': '08:30 - 20:30 • Cả tuần',
      'image': 'https://images.unsplash.com/photo-1507652313519-d4e9174996dd?w=600',
    },
  ];

  void _showCityPickerModal() {
    showModalBottomSheet(
      context: context,
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
                    const Text(
                      'Chọn tỉnh / thành phố',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
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
                          color: isSelected ? AppColors.primary : AppColors.textPrimary,
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

  @override
  Widget build(BuildContext context) {
    final filtered = _branches.where((b) {
      final matchesCity = _selectedCity == 'Tất cả tỉnh / thành phố' || b['city'] == _selectedCity;
      final matchesSearch = _searchQuery.isEmpty ||
          b['name'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
          b['address'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCity && matchesSearch;
    }).toList();

    final displayBranches = filtered.isEmpty ? _branches : filtered;

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
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tìm cơ sở phù hợp với bạn.',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 18),

            // Search Field
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: AppColors.primary, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      onChanged: (val) => setState(() => _searchQuery = val),
                      decoration: const InputDecoration(
                        hintText: 'Tìm chi nhánh, địa chỉ...',
                        hintStyle: TextStyle(fontSize: 14, color: AppColors.textSecondaryLight),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Province Dropdown
            const Text('Tỉnh / thành phố', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
            const SizedBox(height: 6),
            GestureDetector(
              onTap: _showCityPickerModal,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_selectedCity, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                    const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),

            // Quick Filters
            Row(
              children: [
                _buildQuickFilterTab('Gần tôi', 0),
                const SizedBox(width: 8),
                _buildQuickFilterTab('Danh sách', 1),
                const SizedBox(width: 8),
                _buildQuickFilterTab('Bản đồ', 2),
              ],
            ),
            const SizedBox(height: 18),

            // Services Dropdown
            const Text('Dịch vụ tại cơ sở', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
            const SizedBox(height: 6),
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
            const SizedBox(height: 18),

            // Info Banner
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, size: 18, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Hiển thị ${displayBranches.length} cơ sở tại $_selectedCity.',
                      style: const TextStyle(fontSize: 12, color: AppColors.textPrimary, height: 1.3),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Branch List
            ...displayBranches.map((b) => Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: _buildBranchCard(
                    title: b['name'],
                    address: b['address'],
                    time: b['time'],
                    imageUrl: b['image'],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickFilterTab(String label, int index) {
    final isSelected = _activeQuickFilter == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _activeQuickFilter = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: isSelected ? AppColors.primary : AppColors.borderLight),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBranchCard({
    required String title,
    required String address,
    required String time,
    required String imageUrl,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              imageUrl,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(height: 160, color: AppColors.borderLight),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const SizedBox(height: 4),
                Text(address, style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary)),
                const SizedBox(height: 4),
                Text(time, style: const TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w500)),
                const SizedBox(height: 14),
                CustomButton(
                  text: 'Đặt lịch tại chi nhánh',
                  width: double.infinity,
                  onPressed: () {
                    context.read<BookingController>().selectBranch(title, address);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BookingFlowScreen(initialStep: 0),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

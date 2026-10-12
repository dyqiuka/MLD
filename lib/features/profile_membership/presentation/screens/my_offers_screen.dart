import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'package:prj/features/booking_payment/presentation/screens/booking_flow_screen.dart';

class MyOffersScreen extends StatefulWidget {
  const MyOffersScreen({super.key});

  @override
  State<MyOffersScreen> createState() => _MyOffersScreenState();
}

class _MyOffersScreenState extends State<MyOffersScreen> {
  int _selectedFilter = 0;
  final List<String> _filters = ['Có thể sử dụng', 'Đã sử dụng', 'Hết hạn'];

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
        title: const Text('Dữ liệu minh họa', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Ưu đãi của tôi', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
            const SizedBox(height: 4),
            const Text('Khám phá và sử dụng các ưu đãi dành riêng cho bạn.', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
            const SizedBox(height: 16),

            // Summary
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text('3', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.primary)),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ưu đãi có thể sử dụng', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                        Text('Hết hạn gần nhất: 31/10/2026', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            const Text('Dữ liệu minh họa · Không phải ưu đãi thực tế', style: TextStyle(fontSize: 11, color: AppColors.textSecondary, fontStyle: FontStyle.italic)),
            const SizedBox(height: 16),

            // Filters
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(_filters.length, (i) {
                  final isSelected = _selectedFilter == i;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedFilter = i),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: isSelected ? AppColors.primary : AppColors.borderLight),
                      ),
                      child: Text(
                        _filters[i],
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected ? Colors.white : AppColors.textPrimary,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 24),

            // Offer Card 1
            _buildOfferCard(
              title: 'GIẢM 20%',
              subtitle: 'Ưu đãi dịch vụ massage',
              desc: 'Dành thời gian thư giãn và chăm sóc bản thân.\nHóa đơn massage từ 300.000đ, giảm tối đa 150.000đ. Chi nhánh mẫu 01 – Quận 3. Không cộng dồn ưu đãi khác. Điều kiện minh họa.',
              expiry: 'Hết hạn: 31/12/2026',
              code: 'MASSAGE20DEMO',
              codeNote: 'Có thể sử dụng · Dữ liệu minh họa',
            ),
            _buildOfferCard(
              title: 'GIẢM 100.000đ',
              subtitle: 'Khám tổng quát lần đầu',
              desc: 'Áp dụng cho khách hàng mới đặt lịch khám tổng quát lần đầu tiên tại hệ thống. Minh họa.',
              expiry: 'Hết hạn: 15/11/2026',
              code: 'KHAMDAU100',
              codeNote: 'Có thể sử dụng · Dữ liệu minh họa',
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  HapticFeedback.lightImpact();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BookingFlowScreen(initialStep: 0),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Đặt lịch dịch vụ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildOfferCard({
    required String title,
    required String subtitle,
    required String desc,
    required String expiry,
    required String code,
    required String codeNote,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFFF8F0E5),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                const Icon(Icons.local_offer, color: AppColors.primary, size: 20),
                const SizedBox(width: 8),
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.primary)),
                const Spacer(),
                const Icon(Icons.auto_awesome, color: AppColors.primary, size: 16),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subtitle, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const SizedBox(height: 8),
                Text(desc, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.4)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.timer_outlined, size: 14, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(expiry, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Text(code, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primary, letterSpacing: 1)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          codeNote,
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
                        ),
                      ),
                    ],
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

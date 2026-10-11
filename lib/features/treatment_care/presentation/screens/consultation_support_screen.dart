import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'package:prj/features/treatment_care/presentation/controllers/treatment_controller.dart';
import 'package:prj/features/booking_payment/presentation/screens/booking_flow_screen.dart';

/// Frame D07 in Group D: Tư vấn & hỗ trợ
class ConsultationSupportScreen extends StatefulWidget {
  const ConsultationSupportScreen({super.key});

  @override
  State<ConsultationSupportScreen> createState() => _ConsultationSupportScreenState();
}

class _ConsultationSupportScreenState extends State<ConsultationSupportScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage(TreatmentController ctrl) {
    final text = _textController.text.trim();
    if (text.isEmpty) return;
    ctrl.sendConsultationMessage(text);
    _textController.clear();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final treatmentCtrl = context.watch<TreatmentController>();
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
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tư vấn & hỗ trợ',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2C241E),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Chúng tôi luôn sẵn sàng đồng hành cùng bạn.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF7A6E65),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Agent Avatar & Bubble
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.network(
                            'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=200',
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              width: 48,
                              height: 48,
                              color: const Color(0xFFE8DCCF),
                              child: const Icon(Icons.support_agent, color: Color(0xFF8B5E34)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: isDark ? AppColors.surfaceDark : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isDark ? AppColors.borderDark : const Color(0xFFEADBCE),
                              ),
                            ),
                            child: const Text(
                              'Bạn cần chúng tôi hỗ trợ điều gì?',
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF2C241E),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // 4 Quick Options (2x2 grid)
                    Row(
                      children: [
                        Expanded(
                          child: _buildCategoryChip(
                            icon: Icons.chat_bubble_outline,
                            text: 'Tư vấn dịch vụ.',
                            onTap: () {
                              _textController.text = 'Tôi muốn tìm hiểu thêm về dịch vụ chăm sóc.';
                            },
                            isDark: isDark,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildCategoryChip(
                            icon: Icons.calendar_month_outlined,
                            text: 'Hỗ trợ đặt lịch.',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const BookingFlowScreen()),
                              );
                            },
                            isDark: isDark,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _buildCategoryChip(
                            icon: Icons.spa_outlined,
                            text: 'Hỗ trợ liệu trình.',
                            onTap: () {
                              _textController.text = 'Tôi muốn hỏi về số buổi còn lại của gói liệu trình.';
                            },
                            isDark: isDark,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildCategoryChip(
                            icon: Icons.school_outlined,
                            text: 'Hỗ trợ học viên.',
                            onTap: () {
                              _textController.text = 'Tôi muốn được tư vấn đăng ký khóa học nghề spa.';
                            },
                            isDark: isDark,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      'Cuộc trò chuyện minh họa',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF9E9187),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Chat messages list
                    ...treatmentCtrl.consultationChat.map((msg) {
                      final isUser = msg['sender'] == 'user';
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Align(
                          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.75,
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              decoration: BoxDecoration(
                                color: isUser
                                    ? const Color(0xFF8B5E34)
                                    : (isDark ? AppColors.surfaceDark : Colors.white),
                                borderRadius: BorderRadius.circular(16),
                                border: isUser
                                    ? null
                                    : Border.all(
                                        color: isDark ? AppColors.borderDark : const Color(0xFFE5DDD5),
                                      ),
                              ),
                              child: Column(
                                crossAxisAlignment:
                                    isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    msg['text'] ?? '',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: isUser ? Colors.white : const Color(0xFF2C241E),
                                      height: 1.4,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    msg['time'] ?? '',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: isUser ? Colors.white70 : const Color(0xFF9E9187),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Input bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                border: Border(
                  top: BorderSide(
                    color: isDark ? AppColors.borderDark : const Color(0xFFE5DDD5),
                  ),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.attach_file, color: Color(0xFF7A6E65)),
                    tooltip: 'Đính kèm tệp',
                  ),
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        hintText: 'Nhập tin nhắn...',
                        hintStyle: TextStyle(fontSize: 13, color: Color(0xFF9E9187)),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      onSubmitted: (_) => _sendMessage(treatmentCtrl),
                    ),
                  ),
                  IconButton(
                    onPressed: () => _sendMessage(treatmentCtrl),
                    icon: const Icon(Icons.send_rounded, color: Color(0xFF8B5E34)),
                  ),
                ],
              ),
            ),

            // Bottom Sticky Bar: Liên hệ chi nhánh
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              color: isDark ? AppColors.surfaceDark : Colors.white,
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Hotline chi nhánh', style: TextStyle(fontWeight: FontWeight.w700)),
                        content: const Text('Chi nhánh Quận 3: 0912 345 678\nTổng đài hỗ trợ 24/7: 1900 8899'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text('Đóng', style: TextStyle(color: Color(0xFF8B5E34))),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B5E34),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Liên hệ chi nhánh',
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

  Widget _buildCategoryChip({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark ? AppColors.borderDark : const Color(0xFFE5DDD5),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: const Color(0xFF8B5E34)),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2C241E),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prj/core/theme/app_colors.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  bool _appointmentNotif = true;
  bool _treatmentNotif = true;
  bool _courseNotif = true;
  bool _promoNotif = false;

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
            const Text('Cài đặt tài khoản', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
            const SizedBox(height: 4),
            const Text('Quản lý trải nghiệm, bảo mật và các tùy chọn của bạn.', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
            const SizedBox(height: 24),

            // Account Section
            const Text('Tài khoản', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 12),
            _buildSettingsItem(
              icon: Icons.person_outline,
              title: 'Thông tin cá nhân',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Mở chỉnh sửa thông tin cá nhân...'), backgroundColor: AppColors.primary, duration: Duration(seconds: 1)),
                );
              },
            ),
            _buildSettingsItem(
              icon: Icons.lock_outline,
              title: 'Bảo mật tài khoản',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Mở cài đặt bảo mật...'), backgroundColor: AppColors.primary, duration: Duration(seconds: 1)),
                );
              },
            ),
            _buildSettingsItem(
              icon: Icons.phone_outlined,
              title: 'Số điện thoại liên kết',
              subtitle: '0912 345 678 · Đã xác thực',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Mở quản lý số điện thoại...'), backgroundColor: AppColors.primary, duration: Duration(seconds: 1)),
                );
              },
            ),
            const SizedBox(height: 24),

            // Notifications Section
            const Text('Thông báo', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 12),
            _buildToggleItem(
              title: 'Thông báo lịch hẹn',
              subtitle: 'Đang bật',
              value: _appointmentNotif,
              onChanged: (val) => setState(() => _appointmentNotif = val),
            ),
            _buildToggleItem(
              title: 'Thông báo liệu trình',
              subtitle: 'Đang bật',
              value: _treatmentNotif,
              onChanged: (val) => setState(() => _treatmentNotif = val),
            ),
            _buildToggleItem(
              title: 'Thông báo khóa học',
              subtitle: 'Đang bật',
              value: _courseNotif,
              onChanged: (val) => setState(() => _courseNotif = val),
            ),
            _buildToggleItem(
              title: 'Chương trình ưu đãi',
              subtitle: 'Đang tắt',
              value: _promoNotif,
              onChanged: (val) => setState(() => _promoNotif = val),
            ),
            const SizedBox(height: 24),

            // Other
            const Text('Khác', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 12),
            _buildSettingsItem(
              icon: Icons.help_outline,
              title: 'Trung tâm hỗ trợ',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Mở trung tâm hỗ trợ...'), backgroundColor: AppColors.primary, duration: Duration(seconds: 1)),
                );
              },
            ),
            _buildSettingsItem(
              icon: Icons.description_outlined,
              title: 'Điều khoản & Chính sách',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Mở điều khoản sử dụng...'), backgroundColor: AppColors.primary, duration: Duration(seconds: 1)),
                );
              },
            ),
            _buildSettingsItem(
              icon: Icons.info_outline,
              title: 'Phiên bản ứng dụng',
              subtitle: 'v1.0.0 (Build 2026.10)',
              onTap: () {},
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    ],
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.textSecondary, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleItem({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                const SizedBox(height: 2),
                Text(
                  value ? 'Đang bật' : 'Đang tắt',
                  style: TextStyle(fontSize: 12, color: value ? AppColors.success : AppColors.textSecondary),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: (newVal) {
              HapticFeedback.lightImpact();
              onChanged(newVal);
            },
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}

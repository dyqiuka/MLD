import 'package:flutter/material.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'package:prj/core/widgets/custom_button.dart';
import 'package:prj/core/widgets/custom_text_field.dart';
import 'purpose_selection_screen.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _dobCtrl = TextEditingController();
  String _selectedGender = 'Nam';

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _dobCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PurposeSelectionScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Thiết lập hồ sơ', style: TextStyle(color: AppColors.textPrimary)),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hoàn thiện thông tin',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Thông tin của bạn giúp chúng tôi cá nhân hóa dịch vụ chăm sóc tốt hơn.',
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 32),
              
              // Name
              CustomTextField(
                label: 'Họ và tên',
                hintText: 'Nhập họ và tên...',
                controller: _nameCtrl,
                prefixIcon: Icons.person_outline,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Vui lòng nhập họ và tên';
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Email
              CustomTextField(
                label: 'Email (Tùy chọn)',
                hintText: 'Nhập địa chỉ email...',
                controller: _emailCtrl,
                prefixIcon: Icons.email_outlined,
                validator: (val) {
                  if (val != null && val.isNotEmpty && !val.contains('@')) {
                    return 'Email không hợp lệ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Date of Birth
              CustomTextField(
                label: 'Ngày sinh',
                hintText: 'DD/MM/YYYY',
                controller: _dobCtrl,
                prefixIcon: Icons.calendar_today_outlined,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Vui lòng nhập ngày sinh';
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Gender Selection
              const Text(
                'Giới tính',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildGenderOption('Nam', Icons.male),
                  const SizedBox(width: 12),
                  _buildGenderOption('Nữ', Icons.female),
                ],
              ),
              const SizedBox(height: 48),

              CustomButton(
                text: 'Tiếp tục',
                width: double.infinity,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenderOption(String gender, IconData icon) {
    final isSelected = _selectedGender == gender;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedGender = gender),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.borderLight,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: isSelected ? AppColors.primary : AppColors.textSecondary, size: 20),
              const SizedBox(width: 8),
              Text(
                gender,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? AppColors.primary : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'package:prj/core/widgets/custom_button.dart';
import 'package:prj/core/widgets/custom_text_field.dart';
import 'package:prj/features/auth/domain/models/user_model.dart';
import 'package:prj/features/auth/presentation/controllers/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback onRegisterSuccess;

  const RegisterScreen({super.key, required this.onRegisterSuccess});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  UserRole _selectedRole = UserRole.patient;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng Ký Tài Khoản'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Chọn đối tượng người dùng',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                ),
              ),
              const SizedBox(height: 12),

              // Role Selector Cards
              Row(
                children: [
                  Expanded(
                    child: _RoleCard(
                      title: 'Khách hàng',
                      subtitle: 'Khám chữa bệnh & chăm sóc sức khỏe',
                      icon: Icons.person_rounded,
                      isSelected: _selectedRole == UserRole.patient,
                      onTap: () => setState(() => _selectedRole = UserRole.patient),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _RoleCard(
                      title: 'Học viên Nghề',
                      subtitle: 'Đào tạo kỹ thuật viên y dược',
                      icon: Icons.school_rounded,
                      isSelected: _selectedRole == UserRole.student,
                      onTap: () => setState(() => _selectedRole = UserRole.student),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              CustomTextField(
                label: 'Họ và tên',
                hintText: 'VD: Trần Minh Hoàng',
                prefixIcon: Icons.badge_outlined,
                controller: _nameController,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Số điện thoại',
                hintText: 'VD: 0912 345 678',
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                controller: _phoneController,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Địa chỉ Email',
                hintText: 'VD: hoang.tran@email.com',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Mật khẩu',
                hintText: 'Tối thiểu 8 ký tự...',
                prefixIcon: Icons.lock_outline,
                isPassword: true,
                controller: _passwordController,
              ),

              const SizedBox(height: 32),
              CustomButton(
                text: 'Hoàn tất đăng ký',
                width: double.infinity,
                isLoading: auth.isLoading,
                onPressed: () async {
                  final navigator = Navigator.of(context);
                  final name = _nameController.text.trim().isEmpty ? 'Người dùng mới' : _nameController.text.trim();
                  final phone = _phoneController.text.trim().isEmpty ? '0900000000' : _phoneController.text.trim();
                  final email = _emailController.text.trim().isEmpty ? 'user@medilearn.vn' : _emailController.text.trim();

                  final ok = await auth.register(
                    name: name,
                    phone: phone,
                    email: email,
                    role: _selectedRole,
                  );

                  if (ok && mounted) {
                    navigator.pop();
                    widget.onRegisterSuccess();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? const Color(0xFF0C244C) : AppColors.primaryLight)
              : (isDark ? AppColors.surfaceDark : AppColors.surfaceLight),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : (isDark ? AppColors.borderDark : AppColors.borderLight),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : (isDark ? Colors.white70 : Colors.black54),
              size: 26,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: isSelected ? AppColors.primary : (isDark ? Colors.white : AppColors.textPrimaryLight),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 11,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

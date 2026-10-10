import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'package:prj/core/widgets/custom_button.dart';
import 'package:prj/core/widgets/custom_text_field.dart';
import 'package:prj/features/auth/presentation/controllers/auth_controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  final _addressController = TextEditingController(text: '72 Lê Thánh Tôn, Bến Nghé, Quận 1, TP. Hồ Chí Minh');
  final _emergencyController = TextEditingController(text: '0903 888 999 (Người thân)');

  @override
  void initState() {
    super.initState();
    final auth = context.read<AuthController>();
    final user = auth.currentUser;
    _nameController = TextEditingController(text: user?.name ?? '');
    _phoneController = TextEditingController(text: user?.phone ?? '');
    _emailController = TextEditingController(text: user?.email ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _emergencyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chỉnh Sửa Hồ Sơ'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 46,
                    backgroundImage: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            CustomTextField(
              label: 'Họ và tên',
              controller: _nameController,
              prefixIcon: Icons.person_outline,
            ),
            const SizedBox(height: 14),
            CustomTextField(
              label: 'Số điện thoại',
              controller: _phoneController,
              prefixIcon: Icons.phone_outlined,
            ),
            const SizedBox(height: 14),
            CustomTextField(
              label: 'Địa chỉ Email',
              controller: _emailController,
              prefixIcon: Icons.email_outlined,
            ),
            const SizedBox(height: 14),
            CustomTextField(
              label: 'Địa chỉ thường trú',
              controller: _addressController,
              prefixIcon: Icons.home_outlined,
            ),
            const SizedBox(height: 14),
            CustomTextField(
              label: 'Liên hệ khẩn cấp (Người thân)',
              controller: _emergencyController,
              prefixIcon: Icons.contact_emergency_outlined,
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: 'Lưu Thay Đổi',
              width: double.infinity,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Cập nhật thông tin cá nhân thành công!'),
                    backgroundColor: AppColors.success,
                  ),
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

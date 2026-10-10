import 'package:flutter/material.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'package:prj/core/widgets/custom_button.dart';
import 'auth_success_screen.dart';

class PurposeSelectionScreen extends StatefulWidget {
  const PurposeSelectionScreen({super.key});

  @override
  State<PurposeSelectionScreen> createState() => _PurposeSelectionScreenState();
}

class _PurposeSelectionScreenState extends State<PurposeSelectionScreen> {
  final List<String> _purposes = [
    'Khám tổng quát',
    'Chăm sóc nha khoa',
    'Trị liệu da liễu',
    'Tầm soát ung thư',
    'Học nghề điều dưỡng',
    'Học nghề thẩm mỹ',
  ];
  
  final Set<String> _selectedPurposes = {};

  void _togglePurpose(String purpose) {
    setState(() {
      if (_selectedPurposes.contains(purpose)) {
        _selectedPurposes.remove(purpose);
      } else {
        _selectedPurposes.add(purpose);
      }
    });
  }

  void _submit() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const AuthSuccessScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Nhu cầu của bạn là gì?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Chọn các dịch vụ bạn đang quan tâm (có thể chọn nhiều).',
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 32),
              
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: _purposes.length,
                  itemBuilder: (context, index) {
                    final purpose = _purposes[index];
                    final isSelected = _selectedPurposes.contains(purpose);
                    
                    return GestureDetector(
                      onTap: () => _togglePurpose(purpose),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected ? AppColors.primary : AppColors.borderLight,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _getIconForPurpose(purpose),
                              size: 32,
                              color: isSelected ? AppColors.primary : AppColors.textSecondary,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              purpose,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                color: isSelected ? AppColors.primary : AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              CustomButton(
                text: 'Hoàn tất',
                width: double.infinity,
                isDisabled: _selectedPurposes.isEmpty,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconForPurpose(String purpose) {
    switch (purpose) {
      case 'Khám tổng quát': return Icons.favorite_border;
      case 'Chăm sóc nha khoa': return Icons.face;
      case 'Trị liệu da liễu': return Icons.spa_outlined;
      case 'Tầm soát ung thư': return Icons.health_and_safety_outlined;
      case 'Học nghề điều dưỡng': return Icons.school_outlined;
      case 'Học nghề thẩm mỹ': return Icons.brush_outlined;
      default: return Icons.star_border;
    }
  }
}

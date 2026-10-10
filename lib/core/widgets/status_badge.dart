import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum BadgeStatus { success, warning, error, info, primary, gold }

class StatusBadge extends StatelessWidget {
  final String label;
  final BadgeStatus status;
  final IconData? icon;
  final double fontSize;

  const StatusBadge({
    super.key,
    required this.label,
    this.status = BadgeStatus.primary,
    this.icon,
    this.fontSize = 11,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;

    switch (status) {
      case BadgeStatus.success:
        bg = AppColors.successLight;
        fg = AppColors.success;
        break;
      case BadgeStatus.warning:
        bg = AppColors.warningLight;
        fg = AppColors.warning;
        break;
      case BadgeStatus.error:
        bg = AppColors.errorLight;
        fg = AppColors.error;
        break;
      case BadgeStatus.info:
        bg = AppColors.infoLight;
        fg = AppColors.info;
        break;
      case BadgeStatus.primary:
        bg = AppColors.primaryLight;
        fg = AppColors.primary;
        break;
      case BadgeStatus.gold:
        bg = AppColors.goldLight;
        fg = const Color(0xFFB45309);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: fontSize + 1, color: fg),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'package:prj/core/utils/formatters.dart';
import 'package:prj/features/home_service/domain/models/service_model.dart';
import 'custom_button.dart';

class ServiceCard extends StatelessWidget {
  final ServiceModel service;
  final VoidCallback onTap;
  final VoidCallback? onBookNow;

  const ServiceCard({
    super.key,
    required this.service,
    required this.onTap,
    this.onBookNow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with Heart Icon
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    service.imageUrl,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 180,
                      color: AppColors.primaryLight,
                      child: const Icon(Icons.spa_outlined, color: AppColors.primary, size: 48),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.favorite_border, color: AppColors.primary, size: 20),
                  ),
                ),
              ],
            ),
            
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${service.durationMinutes} phút',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        Formatters.formatCurrency(service.price),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    service.description.isNotEmpty ? service.description : 'Thả lỏng cơ thể trong không gian yên tĩnh.',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Action buttons
                  onBookNow != null 
                    ? CustomButton(
                        text: 'Đặt lịch',
                        width: double.infinity,
                        onPressed: onBookNow,
                      )
                    : Center(
                        child: TextButton(
                          onPressed: onTap,
                          child: const Text(
                            'Xem chi tiết',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

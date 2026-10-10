import 'package:flutter/material.dart';

class VoucherModel {
  final String id;
  final String code;
  final String title;
  final String description;
  final num discountAmount;
  final bool isPercentage;
  final num minSpend;
  final DateTime expiryDate;
  final String category; // 'Medical' or 'Academy'

  const VoucherModel({
    required this.id,
    required this.code,
    required this.title,
    required this.description,
    required this.discountAmount,
    this.isPercentage = false,
    this.minSpend = 0,
    required this.expiryDate,
    required this.category,
  });
}

class MembershipTierInfo {
  final String name;
  final int minPoints;
  final int maxPoints;
  final List<String> perks;
  final List<Color> gradientColors;
  final Color badgeColor;

  const MembershipTierInfo({
    required this.name,
    required this.minPoints,
    required this.maxPoints,
    required this.perks,
    required this.gradientColors,
    required this.badgeColor,
  });

  static const List<MembershipTierInfo> allTiers = [
    MembershipTierInfo(
      name: 'Silver',
      minPoints: 0,
      maxPoints: 999,
      perks: [
        'Tích lũy 3% cho mọi dịch vụ khám & khóa học',
        'Ưu tiên đặt hẹn trong khung giờ vàng',
        '1 voucher giảm 100.000₫ định kỳ',
      ],
      gradientColors: [Color(0xFF94A3B8), Color(0xFF64748B)],
      badgeColor: Color(0xFFCBD5E1),
    ),
    MembershipTierInfo(
      name: 'Gold',
      minPoints: 1000,
      maxPoints: 2999,
      perks: [
        'Tích lũy 6% cho mọi hóa đơn khám & học phí',
        'Miễn phí 2 buổi tư vấn sức khỏe từ xa / năm',
        'Ưu tiên khám với Trưởng khoa & Chuyên gia cấp cao',
        'Tặng bộ tài liệu học tập y khoa chuyên đề độc quyền',
      ],
      gradientColors: [Color(0xFFF59E0B), Color(0xFFD97706)],
      badgeColor: Color(0xFFFDE68A),
    ),
    MembershipTierInfo(
      name: 'Platinum',
      minPoints: 3000,
      maxPoints: 6999,
      perks: [
        'Tích lũy 10% điểm thưởng VIP',
        'Bác sĩ gia đình phục vụ riêng 24/7',
        'Phòng chờ VIP sang trọng tại tất cả cơ sở viện',
        'Học bổng 15% cho tất cả chứng chỉ đào tạo nghề y khoa',
      ],
      gradientColors: [Color(0xFF0066F6), Color(0xFF00BFA5)],
      badgeColor: Color(0xFFBAE6FD),
    ),
    MembershipTierInfo(
      name: 'Diamond',
      minPoints: 7000,
      maxPoints: 99999,
      perks: [
        'Đặc quyền khám chữa bệnh ưu tiên tối đa VIP Executive',
        'Gói tầm soát sức khỏe toàn diện hàng năm cho cả gia đình',
        'Học bổng 30% toàn phần các khóa huấn luyện chuyên gia y tế',
        'Trợ lý y tế cá nhân tận tâm đồng hành',
      ],
      gradientColors: [Color(0xFF4F46E5), Color(0xFF9333EA)],
      badgeColor: Color(0xFFE9D5FF),
    ),
  ];

  static MembershipTierInfo getByName(String name) {
    return allTiers.firstWhere(
      (t) => t.name.toLowerCase() == name.toLowerCase(),
      orElse: () => allTiers[1], // Default Gold
    );
  }
}

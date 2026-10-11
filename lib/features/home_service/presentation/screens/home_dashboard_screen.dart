import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prj/core/constants/app_constants.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'package:prj/core/utils/formatters.dart';
import 'package:prj/core/widgets/course_card.dart';
import 'package:prj/core/widgets/doctor_card.dart';
import 'package:prj/core/widgets/service_card.dart';
import 'package:prj/features/auth/presentation/controllers/auth_controller.dart';
import 'package:prj/features/booking_payment/presentation/controllers/booking_controller.dart';
import 'package:prj/features/booking_payment/presentation/screens/booking_flow_screen.dart';
import 'package:prj/features/vocational_training/presentation/controllers/course_controller.dart';
import 'package:prj/features/vocational_training/presentation/screens/course_detail_screen.dart';
import 'package:prj/features/home_service/presentation/controllers/home_controller.dart';
import 'package:prj/features/notifications/presentation/screens/notifications_screen.dart';
import 'all_services_screen.dart';
import 'service_detail_screen.dart';

class HomeDashboardScreen extends StatefulWidget {
  final ValueChanged<int> onNavigateTab;

  const HomeDashboardScreen({super.key, required this.onNavigateTab});

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  final PageController _bannerController = PageController();
  int _currentBannerIndex = 0;
  Timer? _bannerTimer;

  final List<Map<String, String>> _banners = [
    {
      'title': 'Tầm Soát Tim Mạch Toàn Diện',
      'subtitle': 'Ưu đãi 20% trong tháng Tri Ân Sức Khỏe',
      'image': 'https://images.unsplash.com/photo-1628348068343-c6a848d2b6dd?w=600',
      'tag': 'Y TẾ KỸ THUẬT CAO',
    },
    {
      'title': 'Khai Giảng Khóa Điều Dưỡng Quốc Tế',
      'subtitle': 'Cấp chứng chỉ hành nghề chuẩn Kaigo Nhật Bản',
      'image': 'https://images.unsplash.com/photo-1584515979956-d9f6e5d09982?w=600',
      'tag': 'ĐÀO TẠO NGHỀ Y KHOA',
    },
    {
      'title': 'Tư Vấn Telehealth Với Chuyên Gia',
      'subtitle': 'Bác sĩ đầu ngành kết nối trực tuyến 24/7',
      'image': 'https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=600',
      'tag': 'CHĂM SÓC TẬN TÂM',
    },
  ];

  @override
  void initState() {
    super.initState();
    _bannerTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_bannerController.hasClients) {
        _currentBannerIndex = (_currentBannerIndex + 1) % _banners.length;
        _bannerController.animateToPage(
          _currentBannerIndex,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthController>();
    final home = context.watch<HomeController>();
    final bookingCtrl = context.watch<BookingController>();
    final courseCtrl = context.watch<CourseController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final user = auth.currentUser ?? AppConstants.defaultPatientUser;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar Header
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person_outline, color: AppColors.primary),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Xin chào, ${user.name.split(' ').last}!',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Hôm nay bạn muốn chăm sóc bản thân như thế nào?',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Stack(
                        children: [
                          const Icon(Icons.notifications_none_rounded, color: AppColors.primary),
                          Positioned(
                            right: 2,
                            top: 2,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: AppColors.error,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const NotificationsScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Branch Selector
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Chi nhánh đang chọn',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '• Dữ liệu minh họa',
                          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.borderLight),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Chi nhánh mẫu 01 – Quận 3',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textSecondary),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AllServicesScreen(),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: AppColors.primary, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Tìm dịch vụ, khóa học, chuyên viên...',
                            style: TextStyle(fontSize: 14, color: AppColors.textSecondaryLight),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Auto-scrolling Hero Promo Banner Carousel
              SizedBox(
                height: 160,
                child: PageView.builder(
                  controller: _bannerController,
                  itemCount: _banners.length,
                  onPageChanged: (idx) => setState(() => _currentBannerIndex = idx),
                  itemBuilder: (context, index) {
                    final b = _banners[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              b['image']!,
                              fit: BoxFit.cover,
                              errorBuilder: (_, e1, e2) => Container(color: AppColors.primary),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Colors.black.withValues(alpha: 0.85),
                                    Colors.black.withValues(alpha: 0.3),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(18),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      b['tag']!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 9.5,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    b['title']!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    b['subtitle']!,
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.85),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),

              // Banner Indicator Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _banners.length,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: _currentBannerIndex == i ? 18 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: _currentBannerIndex == i ? AppColors.primary : Colors.grey.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Quick Categories Grid
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _QuickCategoryItem(
                      icon: Icons.health_and_safety_outlined,
                      label: 'Khám Tổng',
                      color: const Color(0xFF0066F6),
                      onTap: () {
                        home.selectCategory('Khám Tổng Quát');
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const AllServicesScreen()));
                      },
                    ),
                    _QuickCategoryItem(
                      icon: Icons.favorite_border_rounded,
                      label: 'Tim Mạch',
                      color: const Color(0xFFEF4444),
                      onTap: () {
                        home.selectCategory('Tim Mạch');
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const AllServicesScreen()));
                      },
                    ),
                    _QuickCategoryItem(
                      icon: Icons.auto_awesome,
                      label: 'Da Liễu',
                      color: const Color(0xFFEC4899),
                      onTap: () {
                        home.selectCategory('Da Liễu');
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const AllServicesScreen()));
                      },
                    ),
                    _QuickCategoryItem(
                      icon: Icons.sentiment_satisfied_alt,
                      label: 'Nha Khoa',
                      color: const Color(0xFF00BFA5),
                      onTap: () {
                        home.selectCategory('Nha Khoa');
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const AllServicesScreen()));
                      },
                    ),
                    _QuickCategoryItem(
                      icon: Icons.school_outlined,
                      label: 'Học Viện',
                      color: const Color(0xFFF59E0B),
                      onTap: () => widget.onNavigateTab(3), // Academy tab (index 3)
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Recent Booking Snippet (if any)
              if (bookingCtrl.bookingHistory.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isDark
                            ? [const Color(0xFF0F2648), const Color(0xFF0E1A33)]
                            : [const Color(0xFFEFF6FF), const Color(0xFFE0F2FE)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.event_available, color: Colors.white, size: 22),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Lịch hẹn sắp tới',
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '•  ${bookingCtrl.bookingHistory.first.ticketCode}',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 3),
                              Text(
                                '${bookingCtrl.bookingHistory.first.doctorTitle} ${bookingCtrl.bookingHistory.first.doctorName}',
                                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                '${bookingCtrl.bookingHistory.first.timeSlot} • ${Formatters.formatDate(bookingCtrl.bookingHistory.first.appointmentDate)}',
                                style: TextStyle(
                                  fontSize: 11.5,
                                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: AppColors.primary),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],

              // SECTION 1: Featured Medical Services
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dịch Vụ Y Tế Nổi Bật',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AllServicesScreen(),
                          ),
                        );
                      },
                      child: const Text('Xem tất cả', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 420,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: home.services.length,
                  itemBuilder: (context, index) {
                    final service = home.services[index];
                    return SizedBox(
                      width: 280,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: ServiceCard(
                          service: service,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ServiceDetailScreen(service: service),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              // SECTION 2: Top Doctors
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Đội Ngũ Bác Sĩ & Chuyên Gia',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Just navigate to all services for now
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AllServicesScreen(),
                          ),
                        );
                      },
                      child: const Text('Xem tất cả', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 190,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: home.doctors.length,
                  itemBuilder: (context, index) {
                    final doc = home.doctors[index];
                    return DoctorCard(
                      doctor: doc,
                      isHorizontal: true,
                      onTap: () {
                        final booking = context.read<BookingController>();
                        booking.startBooking(
                          service: home.services.first,
                          doctor: doc,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const BookingFlowScreen(),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              // SECTION 3: Vocational Training Academy Highlight (Group E)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(Icons.school, color: AppColors.gold, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Học Viện Nghề Y Khoa',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () => widget.onNavigateTab(3),
                      child: const Text('Xem khóa học', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: courseCtrl.courses.length,
                  itemBuilder: (context, index) {
                    final course = courseCtrl.courses[index];
                    return CourseCard(
                      course: course,
                      isHorizontal: true,
                      onTap: () {
                        courseCtrl.selectCourse(course);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CourseDetailScreen(course: course),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 36),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickCategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickCategoryItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withValues(alpha: 0.2)),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            ),
          ),
        ],
      ),
    );
  }
}

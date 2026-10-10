import 'package:flutter/material.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'branch_list_screen.dart';
import 'professional_list_screen.dart';

class BookingTabScreen extends StatelessWidget {
  const BookingTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          title: const Text(
            'Đặt Lịch Khám & Chăm Sóc',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
          ),
          bottom: const TabBar(
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.primary,
            tabs: [
              Tab(text: 'Chi Nhánh'),
              Tab(text: 'Chuyên Viên'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            BranchListScreen(),
            ProfessionalListScreen(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/custom_bottom_nav.dart';
import 'features/auth/presentation/controllers/auth_controller.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/auth/presentation/screens/onboarding_screen.dart';
import 'features/auth/presentation/screens/splash_screen.dart';
import 'features/booking_payment/presentation/controllers/booking_controller.dart';
import 'features/home_service/presentation/controllers/home_controller.dart';
import 'features/home_service/presentation/screens/all_services_screen.dart';
import 'features/home_service/presentation/screens/home_dashboard_screen.dart';
import 'features/profile_membership/presentation/controllers/profile_controller.dart';
import 'features/profile_membership/presentation/screens/profile_screen.dart';
import 'features/treatment_care/presentation/controllers/treatment_controller.dart';
import 'features/treatment_care/presentation/screens/medical_records_screen.dart';
import 'features/vocational_training/presentation/controllers/course_controller.dart';
import 'features/vocational_training/presentation/screens/academy_catalog_screen.dart';
import 'features/booking_payment/presentation/screens/my_appointments_screen.dart';

class MediLearnApp extends StatelessWidget {
  const MediLearnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => BookingController()),
        ChangeNotifierProvider(create: (_) => TreatmentController()),
        ChangeNotifierProvider(create: (_) => CourseController()),
        ChangeNotifierProvider(create: (_) => ProfileController()),
      ],
      child: Consumer<ProfileController>(
        builder: (context, profileCtrl, _) {
          return MaterialApp(
            title: 'MediLearn Healthcare',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: profileCtrl.themeMode,
            home: const RootGateScreen(),
          );
        },
      ),
    );
  }
}

class RootGateScreen extends StatefulWidget {
  const RootGateScreen({super.key});

  @override
  State<RootGateScreen> createState() => _RootGateScreenState();
}

class _RootGateScreenState extends State<RootGateScreen> {
  bool _showSplash = true;
  bool _showOnboarding = false;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthController>();

    if (_showSplash) {
      return SplashScreen(
        onFinish: () {
          setState(() {
            _showSplash = false;
            _showOnboarding = true; // Show onboarding before login
          });
        },
      );
    }

    if (_showOnboarding) {
      return OnboardingScreen(
        onFinish: () {
          setState(() {
            _showOnboarding = false;
          });
        },
      );
    }

    if (!auth.isAuthenticated) {
      return LoginScreen(
        onLoginSuccess: () {
          setState(() {});
        },
      );
    }

    return const MainShellScreen();
  }
}

class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key});

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  int _currentIndex = 0;

  void _onTabSelect(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeDashboardScreen(onNavigateTab: _onTabSelect),
      const AllServicesScreen(),
      const MyAppointmentsScreen(),
      const AcademyCatalogScreen(),
      ProfileScreen(
        onLogout: () {
          setState(() {
            _currentIndex = 0;
          });
        },
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: _onTabSelect,
      ),
    );
  }
}

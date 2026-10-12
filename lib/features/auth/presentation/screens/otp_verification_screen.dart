import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prj/core/theme/app_colors.dart';
import 'package:prj/core/widgets/custom_button.dart';
import 'profile_setup_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phone;

  const OtpVerificationScreen({super.key, required this.phone});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _otpControllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  
  Timer? _timer;
  int _countdown = 45;
  bool _canResend = false;
  bool _isFilled = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    setState(() {
      _countdown = 45;
      _canResend = false;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown == 0) {
        setState(() => _canResend = true);
        timer.cancel();
      } else {
        setState(() => _countdown--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var ctrl in _otpControllers) {
      ctrl.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _checkFilled() {
    final otp = _otpControllers.map((c) => c.text).join();
    setState(() {
      _isFilled = otp.length == 6;
    });
    if (_isFilled) {
      // Auto verify could be triggered here or just wait for button press
    }
  }

  void _verifyOtp() async {
    if (!_isFilled) return;
    
    // In a real app, verify OTP here. We simulate success.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const ProfileSetupScreen()),
    );
  }

  String get _maskedPhone {
    if (widget.phone.length >= 6) {
      return widget.phone.replaceRange(3, widget.phone.length - 3, ' *** ');
    }
    return widget.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              InkWell(
                onTap: () => Navigator.pop(context),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  child: const Icon(Icons.arrow_back, color: AppColors.textPrimary, size: 20),
                ),
              ),
              const SizedBox(height: 32),
              
              // Phone Icon Box
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.phone_iphone_outlined, color: AppColors.primary, size: 28),
              ),
              const SizedBox(height: 24),
              
              // Title
              const Text(
                'Xác thực số điện thoại',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              
              // Subtitle
              Text(
                'Nhập mã OTP đã được gửi đến số điện thoại của bạn.',
                style: const TextStyle(
                  fontSize: 15, 
                  color: AppColors.textSecondary, 
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '+84 $_maskedPhone',
                style: const TextStyle(
                  fontSize: 16, 
                  fontWeight: FontWeight.w700, 
                  color: AppColors.textPrimary,
                ),
              ),
              
              const SizedBox(height: 40),
              
              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 48,
                    height: 56,
                    child: TextField(
                      controller: _otpControllers[index],
                      focusNode: _focusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                      decoration: InputDecoration(
                        counterText: '',
                        contentPadding: EdgeInsets.zero,
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: _otpControllers[index].text.isNotEmpty 
                                ? AppColors.primary 
                                : AppColors.borderLight,
                            width: _otpControllers[index].text.isNotEmpty ? 1.5 : 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.primary, width: 2),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 5) {
                          _focusNodes[index + 1].requestFocus();
                        }
                        if (value.isEmpty && index > 0) {
                          _focusNodes[index - 1].requestFocus();
                        }
                        _checkFilled();
                      },
                    ),
                  );
                }),
              ),
              
              const SizedBox(height: 32),
              
              // Resend Text
              Center(
                child: Text(
                  _canResend ? 'Bạn chưa nhận được mã?' : 'Gửi lại mã sau 00:${_countdown.toString().padLeft(2, '0')}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Resend Button (Disabled state matches UI)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _canResend ? _startTimer : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.borderLight,
                    disabledBackgroundColor: AppColors.borderLight.withValues(alpha: 0.5),
                    foregroundColor: AppColors.textSecondary,
                    disabledForegroundColor: AppColors.textSecondary.withValues(alpha: 0.5),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Gửi lại mã',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Change Phone
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text(
                    'Thay đổi số điện thoại',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 48),
              
              // Demo Warning Banner
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.alertBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.info_outline, color: AppColors.primary, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Bản minh họa giao diện. Không gửi hoặc xác thực OTP thực tế.',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textPrimary,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Confirm Button (Disabled until filled)
              CustomButton(
                text: 'Xác nhận',
                width: double.infinity,
                backgroundColor: _isFilled ? AppColors.primary : AppColors.borderLight,
                textColor: _isFilled ? Colors.white : AppColors.textSecondary,
                isDisabled: !_isFilled,
                onPressed: _verifyOtp,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

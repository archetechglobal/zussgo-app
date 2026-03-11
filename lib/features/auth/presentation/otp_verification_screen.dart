import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/auth_service.dart';
import '../../profile/presentation/profile_setup_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  static const Color coral = Color(0xFFFF6B6B);
  static const Color violet = Color(0xFF7B2FF7);
  static const Color darkBg = Color(0xFF0A0A12);
  static const Color inputBg = Color(0xFF16161E);

  final TextEditingController _otpController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _verifyCode() async {
    final otp = _otpController.text.trim();

    if (otp.length < 6) {
      setState(() => _errorMessage = "Please enter the full 6-digit code.");
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // In a real app, you would pass the email from the previous screen.
    // We are hardcoding an example email for testing.
    final bool isSuccess = await _authService.verifyOtp(
      email: "arjun@email.com",
      otpCode: otp,
    );

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (isSuccess) {
      // Tokens are saved! Now navigate with a premium smooth glide
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(
            milliseconds: 600,
          ), // 0.6 seconds of smoothness
          pageBuilder: (context, animation, secondaryAnimation) =>
              const ProfileSetupScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Create a fade-in effect
            var fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            );

            // Create a subtle slide-up effect
            var slideAnimation =
                Tween<Offset>(
                  begin: const Offset(0.0, 0.05),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  ),
                );

            return FadeTransition(
              opacity: fadeAnimation,
              child: SlideTransition(position: slideAnimation, child: child),
            );
          },
        ),
      );
    } else {
      setState(() {
        _errorMessage =
            "Invalid or expired code. Please try again. (Hint: Use 123456)";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushReplacementNamed(context, '/signup'),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Verify\nEmail",
                style: GoogleFonts.syne(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFFF5F5F5),
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "We sent a 6-digit code to your email.\nIt expires in 10 minutes.", //
                style: GoogleFonts.dmSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFF5F5F5).withOpacity(0.5),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 48),

              // Simple placeholder for OTP input - can be upgraded to a pin_code_fields package later
              TextField(
                controller: _otpController, // <-- Added controller
                keyboardType: TextInputType.number,
                maxLength: 6,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  if (_errorMessage != null)
                    setState(() => _errorMessage = null);
                },
                style: GoogleFonts.dmSans(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 16,
                ),
                decoration: InputDecoration(
                  counterText: "",
                  hintText: "••••••",
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.2),
                    letterSpacing: 16,
                  ),
                  filled: true,
                  fillColor: inputBg,
                  contentPadding: const EdgeInsets.symmetric(vertical: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: violet.withOpacity(0.5)),
                  ),
                  // Show red border if there's an error
                  errorText: _errorMessage,
                  errorStyle: GoogleFonts.dmSans(color: coral),
                ),
              ),
              const SizedBox(height: 32),

              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(colors: [coral, violet]),
                ),
                child: ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : _verifyCode, // Disable button if loading
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          "Verify & Continue",
                          style: GoogleFonts.dmSans(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

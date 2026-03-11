import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  // Re-defining brand colors so they are accessible in this file
  static const Color coral = Color(0xFFFF6B6B);
  static const Color violet = Color(0xFF7B2FF7);
  static const Color mint = Color(0xFF00F5D4);
  static const Color darkBg = Color(0xFF0A0A12);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    // Navigate to the onboarding screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/onboarding');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      body: Stack(
        children: [
          // Background glow — coral top left
          Positioned(
            top: -80,
            left: -80,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: coral.withOpacity(0.12),
              ),
            ),
          ),

          // Background glow — violet bottom right
          Positioned(
            bottom: -60,
            right: -60,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: violet.withOpacity(0.1),
              ),
            ),
          ),

          // Background glow — mint center right
          Positioned(
            top: 200,
            right: -40,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: mint.withOpacity(0.06),
              ),
            ),
          ),

          // Main content — centered
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo Box
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [coral, violet],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: coral.withOpacity(0.3),
                          blurRadius: 40,
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Z',
                      style: GoogleFonts.syne(
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // App name
                  Text(
                    'ZussGo',
                    style: GoogleFonts.syne(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFFF5F5F5),
                      letterSpacing: -1.5,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Tagline
                  Text(
                    'solo trip. shared vibes.',
                    style: GoogleFonts.dmSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFF5F5F5).withOpacity(0.4),
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom loading bar indicator
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  gradient: const LinearGradient(colors: [coral, violet]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Brand Colors matching your Splash Screen
  static const Color coral = Color(0xFFFF6B6B);
  static const Color violet = Color(0xFF7B2FF7);
  static const Color darkBg = Color(0xFF0A0A12);

  // Exact data from the UI designs including precise line breaks
  final List<Map<String, dynamic>> _onboardingData = [
    {
      "icon": Icons.public, // Temporary guaranteed icon
      "image": "assets/images/globe.png", // Ready for your exported 3D asset
      "title": "Find Your\nTravel Match",
      "subtitle":
          "Discover real travelers heading to the\nsame destination on the same dates as\nyou.",
      "showSkip": true,
    },
    {
      "icon": Icons.handshake_outlined,
      "image": "assets/images/handshake.png",
      "title": "Match &\nConnect",
      "subtitle":
          "Browse verified profiles, match with\nwho you vibe with, and chat before you\ngo.",
      "showSkip": false,
    },
    {
      "icon": Icons.flight_takeoff,
      "image": "assets/images/plane.png",
      "title": "Travel\nTogether",
      "subtitle":
          "No more cancelled trips. No more solo\nanxiety. Just shared adventures.",
      "showSkip": false,
    },
  ];

  void _goToNextPage() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _finishOnboarding() {
    // Navigate to Login/Signup when Auth is ready
    print("Navigate to Auth");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) {
                  final data = _onboardingData[index];

                  final IconData icon = data["icon"] as IconData;
                  final String title = data["title"]?.toString() ?? "";
                  final String subtitle = data["subtitle"]?.toString() ?? "";

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Container with the glow effect
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: coral.withOpacity(0.12),
                                blurRadius: 60,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                          child: Center(
                            // WE ARE USING A BUILT-IN ICON FOR NOW TO PREVENT ERRORS
                            child: Icon(icon, size: 72, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 50),

                        // Title
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.syne(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFFF5F5F5),
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Subtitle
                        Text(
                          subtitle,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFF5F5F5).withOpacity(0.5),
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Bottom Navigation Area (Fixed height to prevent jumping)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 24.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Dot Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _onboardingData.length,
                      (index) => _buildDot(index: index),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Next / Get Started Gradient Button
                  _buildGradientButton(
                    text: _currentPage == _onboardingData.length - 1
                        ? "Get Started"
                        : "Next",
                    onPressed: _goToNextPage,
                  ),
                  const SizedBox(height: 16),

                  // Skip Button (Maintains consistent vertical height even when hidden)
                  if (_onboardingData[_currentPage]["showSkip"] == true)
                    _buildSkipButton(onPressed: _finishOnboarding)
                  else
                    const SizedBox(
                      height: 56,
                    ), // 56 is the height of the skip button
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot({required int index}) {
    bool isActive = _currentPage == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? coral : const Color(0xFF2A2A32),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildGradientButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [coral, violet],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.dmSans(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildSkipButton({required VoidCallback onPressed}) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          'Skip',
          style: GoogleFonts.dmSans(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.6),
          ),
        ),
      ),
    );
  }
}

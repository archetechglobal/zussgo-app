import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // List of interests for Zussgo users
  final List<String> _allInterests = [
    '🏔️ Hiking',
    '🎨 Art Galleries',
    '🍜 Foodie',
    '🎸 Live Music',
    '🏖️ Beach',
    '📸 Photography',
    '💃 Nightlife',
    '🧘 Yoga',
    '🏛️ History',
  ];

  final List<String> _selectedInterests = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            Text(
              "Define your\ntravel vibe.",
              style: GoogleFonts.syne(
                fontSize: 38,
                fontWeight: FontWeight.w800,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Select at least 3 to find your best matches.",
              style: TextStyle(color: Colors.white.withOpacity(0.5)),
            ),
            const SizedBox(height: 32),

            // Interest Grid
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _allInterests.map((interest) {
                final isSelected = _selectedInterests.contains(interest);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelected
                          ? _selectedInterests.remove(interest)
                          : _selectedInterests.add(interest);
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFFFF6B6B)
                            : Colors.white10,
                      ),
                      gradient: isSelected
                          ? const LinearGradient(
                              colors: [Color(0xFFFF6B6B), Color(0xFF7B2FF7)],
                            )
                          : null,
                      color: isSelected ? null : Colors.white.withOpacity(0.05),
                    ),
                    child: Text(interest),
                  ),
                );
              }).toList(),
            ),

            const Spacer(),

            // Continue Button
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7B2FF7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                onPressed: _selectedInterests.length >= 3
                    ? () {
                        // Navigate to Destination Picker (Next Step)
                      }
                    : null, // Disables button if < 3 selected
                child: const Text(
                  "Continue",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  static const Color coral = Color(0xFFFF6B6B);
  static const Color violet = Color(0xFF7B2FF7);
  static const Color darkBg = Color(0xFF0A0A12);
  static const Color inputBg = Color(0xFF16161E);

  // State variables for the selections
  String _selectedTravelStyle = "Comfort";
  final List<String> _selectedInterests = [
    "Adventure",
    "Photography",
    "Nature",
  ];

  final List<String> _travelStyles = ["Backpacker", "Comfort", "Luxury"];
  final List<String> _allInterests = [
    "Adventure",
    "Photography",
    "Culture",
    "Nightlife",
    "Nature",
    "Trekking",
    "Beach",
    "Spiritual",
    "Food",
    "Road Trip",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Header
              Text(
                "Set Up Profile",
                style: GoogleFonts.syne(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFFF5F5F5),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Help us find your perfect travel match",
                style: GoogleFonts.dmSans(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 32),

              // Photo Placeholder
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: inputBg,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: violet.withOpacity(0.5),
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.add_a_photo_outlined,
                        color: violet,
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Add Photo",
                      style: GoogleFonts.dmSans(
                        color: violet,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Basic Info Fields
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: _buildTextField(
                      label: "Age",
                      hint: "24",
                      isNumber: true,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: _buildTextField(label: "City", hint: "Mumbai"),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              _buildTextField(
                label: "Bio",
                hint: "Love mountains, chai, and spontaneous trips...",
                maxLines: 3,
              ),
              const SizedBox(height: 32),

              // Travel Style
              Text(
                "Travel Style",
                style: GoogleFonts.dmSans(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                children: _travelStyles
                    .map(
                      (style) => _buildChoiceChip(
                        label: style,
                        isSelected: _selectedTravelStyle == style,
                        onTap: () =>
                            setState(() => _selectedTravelStyle = style),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 32),

              // Interests
              Text(
                "Interests",
                style: GoogleFonts.dmSans(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: _allInterests
                    .map(
                      (interest) => _buildChoiceChip(
                        label: interest,
                        isSelected: _selectedInterests.contains(interest),
                        onTap: () {
                          setState(() {
                            if (_selectedInterests.contains(interest)) {
                              _selectedInterests.remove(interest);
                            } else {
                              _selectedInterests.add(interest);
                            }
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 48),

              // Start Exploring Button
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(colors: [coral, violet]),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Save Profile to Backend, then go to Home
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    "Start Exploring",
                    style: GoogleFonts.dmSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    int maxLines = 1,
    bool isNumber = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.dmSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          style: GoogleFonts.dmSans(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.dmSans(color: Colors.white.withOpacity(0.3)),
            filled: true,
            fillColor: inputBg,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: violet),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChoiceChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? violet.withOpacity(0.15) : inputBg,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? violet : Colors.white.withOpacity(0.05),
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.dmSans(
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

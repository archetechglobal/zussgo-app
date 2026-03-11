import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Brand Colors
  static const Color coral = Color(0xFFFF6B6B);
  static const Color violet = Color(0xFF7B2FF7);
  static const Color darkBg = Color(0xFF0A0A12);
  static const Color inputBg = Color(0xFF16161E);

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
              // Title
              Text(
                "Create\nAccount",
                style: GoogleFonts.syne(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFFF5F5F5),
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 12),
              // Subtitle
              Text(
                "Find your travel match in minutes",
                style: GoogleFonts.dmSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFF5F5F5).withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 40),

              // Form Fields
              _buildTextField(label: "Full Name", hint: "Saiteja Challa"),
              const SizedBox(height: 20),
              _buildTextField(label: "Email", hint: "challa@email.com"),
              const SizedBox(height: 20),
              _buildTextField(
                label: "Password",
                hint: "••••••••",
                isPassword: true,
              ),
              const SizedBox(height: 40),

              // Sign Up Button
              _buildGradientButton("Sign Up", () {
                // Implementing architecture step: Email does not exist -> generate OTP
                Navigator.pushReplacementNamed(context, '/otp_verification');
              }),
              const SizedBox(height: 32),

              // Divider
              Center(
                child: Text(
                  "or continue with",
                  style: GoogleFonts.dmSans(
                    color: Colors.white.withOpacity(0.3),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Social Buttons
              Row(
                children: [
                  Expanded(
                    child: _buildSocialButton("Google", Icons.g_mobiledata),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildSocialButton("Phone", Icons.phone_outlined),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Bottom Navigation
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: GoogleFonts.dmSans(
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushReplacementNamed(context, '/login'),
                    child: Text(
                      "Log in",
                      style: GoogleFonts.dmSans(
                        color: coral,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Same helper widgets as LoginScreen to keep UI consistent
  Widget _buildTextField({
    required String label,
    required String hint,
    bool isPassword = false,
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
          obscureText: isPassword,
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
              borderSide: BorderSide(color: violet.withOpacity(0.5), width: 1),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGradientButton(String text, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(colors: [coral, violet]),
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

  Widget _buildSocialButton(String text, IconData icon) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: TextButton.icon(
        onPressed: () {},
        icon: Icon(icon, color: Colors.white, size: 24),
        label: Text(
          text,
          style: GoogleFonts.dmSans(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}

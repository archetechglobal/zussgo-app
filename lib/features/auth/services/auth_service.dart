import 'dart:convert';
// import 'package:http/http.dart' as http; // Uncomment when backend is ready
import '../../../core/services/secure_storage_service.dart';

class AuthService {
  final SecureStorageService _secureStorage = SecureStorageService();

  // Replace with your actual backend URL later
  final String _baseUrl = 'https://api.zussgo.com/v1/auth';

  /// Verifies the OTP and stores the tokens if successful
  Future<bool> verifyOtp({
    required String email,
    required String otpCode,
  }) async {
    try {
      /* --- REAL BACKEND CODE (Commented out until your API is ready) ---
      final response = await http.post(
        Uri.parse('$_baseUrl/verify-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'otp': otpCode}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Extract tokens based on your backend architecture document
        final accessToken = data['access_token'];
        final refreshToken = data['refresh_token'];
        
        // Save them securely
        await _secureStorage.saveTokens(accessToken: accessToken, refreshToken: refreshToken);
        return true;
      } else {
        // Handle error (e.g., OTP expired, invalid OTP)
        return false;
      }
      ------------------------------------------------------------------ */

      // --- SIMULATED DELAY FOR UI TESTING ---
      await Future.delayed(const Duration(seconds: 2)); // Fake network delay

      if (otpCode == "123456") {
        // Fake success condition
        try {
          // Attempt to save tokens. If this crashes, you need a full app rebuild!
          await _secureStorage.saveTokens(
            accessToken: "fake_access_token_123",
            refreshToken: "fake_refresh_token_456",
          );
          print("✅ Tokens saved securely!");
        } catch (storageError) {
          print(
            "⚠️ Secure Storage Error (Native linking issue): $storageError",
          );
          print("⚠️ Bypassing storage for now so you can test the UI flow...");
          // We still return true here for now so you can keep building the UI
        }

        return true;
      }

      return false; // Fake failure condition
    } catch (e) {
      print("❌ CRITICAL ERROR in verifyOtp: $e");
      return false;
    }
  }
}

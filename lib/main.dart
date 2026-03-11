import 'package:flutter/material.dart';
import 'features/onboarding/presentation/splash_screen.dart';
import 'features/onboarding/presentation/onboarding_screen.dart';

void main() {
  runApp(const ZussGoApp());
}

class ZussGoApp extends StatelessWidget {
  const ZussGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZussGo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0A12),
        // Adding a global font or primary color here is a pro-tip
        primaryColor: const Color(0xFF7B2FF7),
      ),

      // The starting point of your app
      initialRoute: '/',

      // FIXED: All routes must be inside ONE routes map
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
      },
    );
  }
}

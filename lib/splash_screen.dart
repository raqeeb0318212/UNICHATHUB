import 'package:flutter/material.dart';
import 'dart:async';
import 'welcome_screen.dart'; // Import the Welcome Screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Logic: Wait 3 seconds, then replace current screen with WelcomeScreen
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // Background color: #B5AAAC
      backgroundColor: Color(0xFFB5AAAC),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Graduation Cap Icon
            Icon(
              Icons.school, // Mortarboard icon
              color: Colors.white,
              size: 120,
            ),
            SizedBox(height: 20), // Spacing between icon and text
            // UniChatHub Text
            Text(
              'UNICHATHUB',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
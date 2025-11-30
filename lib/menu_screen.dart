import 'package:flutter/material.dart';

// IMPORTANT: Import your screens here
import 'color_change_screen.dart';
import 'about_app_screen.dart'; // Make sure to import the new screen

// Custom color derived from the Figma design's background
const Color _backgroundColor = Color(0xFFEBE3E3);
const Color _foregroundColor = Colors.black87;

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  // Updated Helper widget: Now accepts an onTap function
  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    bool isColorful = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Icon(
              icon,
              color: _foregroundColor,
              size: 24,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  color: _foregroundColor,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: _foregroundColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: _foregroundColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Large White Graduation Cap Icon
            const Padding(
              padding: EdgeInsets.only(top: 40.0, bottom: 60.0),
              child: Icon(
                Icons.school,
                color: Colors.white,
                size: 100,
              ),
            ),

            // 2. Menu Items List
            _buildMenuItem(
              icon: Icons.person_outline,
              title: 'Profile',
              onTap: () {
                // Navigate to Profile
              },
            ),
            _buildMenuItem(
              icon: Icons.border_color,
              title: 'Home Feed',
            ),
            _buildMenuItem(
              icon: Icons.work_outline,
              title: 'Jobs',
            ),
            _buildMenuItem(
              icon: Icons.chat_bubble_outline,
              title: 'Chat',
            ),
            _buildMenuItem(
              icon: Icons.menu_book_outlined,
              title: 'Events',
            ),

            // --- UPDATED COLOURS ITEM ---
            _buildMenuItem(
              icon: Icons.palette_outlined,
              title: 'Colours',
              isColorful: true,
              onTap: () {
                // Navigate to ColorChangeScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ColorChangeScreen(),
                  ),
                );
              },
            ),

            _buildMenuItem(
              icon: Icons.contact_page_outlined,
              title: 'Contact',
            ),

            const SizedBox(height: 70),

            // 3. Sign Out Button
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              width: double.infinity,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  // Handle Sign Out
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign Out',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: _foregroundColor,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward,
                      color: _foregroundColor,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),

            // 4. ABOUT APP Text
            TextButton(
              onPressed: () {
                // --- NAVIGATION LOGIC ADDED HERE ---
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutAppScreen(),
                  ),
                );
              },
              child: const Text(
                'ABOUT APP',
                style: TextStyle(
                  fontSize: 16,
                  color: _foregroundColor,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationColor: _foregroundColor,
                  decorationThickness: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
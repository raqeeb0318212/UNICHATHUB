import 'package:flutter/material.dart';

// IMPORTANT: Import your MenuScreen here if you use push instead of pop,
// but pop is recommended for back buttons.
import 'menu_screen.dart';
import 'notification_screen.dart';

// Custom colors derived from the Figma design
const Color _backgroundColor = Color(0xFFEBE3E3);
const Color _cardUnselectedColor = Color(0xFFDCDCDC);
const Color _confirmButtonColor = Color(0xFFE3D0A8);
const Color _foregroundColor = Colors.black87;

class ColorChangeScreen extends StatefulWidget {
  const ColorChangeScreen({super.key});

  @override
  State<ColorChangeScreen> createState() => _ColorChangeScreenState();
}

class _ColorChangeScreenState extends State<ColorChangeScreen> {
  ThemeOption _selectedOption = ThemeOption.protopia;
  Color? _selectedCustomColor;

  Widget _buildSelectionCard(ThemeOption option, String title) {
    final bool isSelected = _selectedOption == option;
    final cardColor = isSelected ? Colors.white : _cardUnselectedColor;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedOption = option;
          _selectedCustomColor = null;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  color: _foregroundColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Colors.white : _cardUnselectedColor,
                border: Border.all(
                  color: isSelected ? Colors.grey.shade400 : Colors.grey.shade400,
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? Colors.grey.shade600 : Colors.transparent,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomColorSquare(Color color) {
    final bool isSelected = _selectedCustomColor == color;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCustomColor = color;
          _selectedOption = ThemeOption.defaultTheme;
        });
      },
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(color: Colors.black, width: 3)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 2,
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
        // --- LOGIC: Back Arrow goes back to Menu ---
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: _foregroundColor, size: 30),
          onPressed: () {
            // Navigator.pop goes back to the previous screen (MenuScreen)
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          'Color Change',
          style: TextStyle(
            color: _foregroundColor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NotificationScreen()),
                );
              },
              child: const Icon(Icons.notifications_none, color: _foregroundColor, size: 28),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- LOGIC: "Home" text goes back to Menu ---
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 8, 28, 20),
              child: GestureDetector(
                onTap: () {
                  // Navigator.pop goes back to the previous screen (MenuScreen)
                  Navigator.pop(context);
                },
                behavior: HitTestBehavior.opaque,
                child: const Text(
                  '← Home',
                  style: TextStyle(
                    color: _foregroundColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),

            _buildSelectionCard(ThemeOption.defaultTheme, 'Default Theme'),
            _buildSelectionCard(ThemeOption.protopia, 'Protopia (Red,Green)'),
            _buildSelectionCard(ThemeOption.deuotropia, 'Deutropia (Blue,Yellow)'),

            const SizedBox(height: 30),

            const Padding(
              padding: EdgeInsets.only(left: 28.0, bottom: 16.0),
              child: Text(
                'Custom select :',
                style: TextStyle(
                  color: _foregroundColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 28.0),
              child: Row(
                children: [
                  _buildCustomColorSquare(Colors.red),
                  _buildCustomColorSquare(Colors.green),
                  _buildCustomColorSquare(Colors.blue),
                  _buildCustomColorSquare(Colors.yellow),
                ],
              ),
            ),

            const SizedBox(height: 70),

            // Confirm Button
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 55,
                decoration: BoxDecoration(
                  color: _confirmButtonColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextButton(
                  onPressed: () {
                    // --- LOGIC: Show "Done successfully" message ---
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Done successfully"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: const Text(
                    'Confirm',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: _foregroundColor,
                    ),
                  ),
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

enum ThemeOption {
  defaultTheme,
  protopia,
  deuotropia,
}
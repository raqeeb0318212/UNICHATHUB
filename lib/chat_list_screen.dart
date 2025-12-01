import 'package:flutter/material.dart';
import 'chat_conversation_screen.dart'; // Import the conversation screen

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 🎨 Colors
    const Color backgroundColor = Color(0xFFB4A8A9);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          // ✅ FIX: This pops the current screen to go back to MenuScreen
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 22),
        ),
        title: const Text(
          'Home',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Pass context to the function so we can navigate
            _buildUserCard(context, "User Name 1"),
            const SizedBox(height: 16),
            _buildUserCard(context, "User Name 2"),
          ],
        ),
      ),
    );
  }

  // Updated to accept Context and a Name
  Widget _buildUserCard(BuildContext context, String userName) {
    const Color cardColor = Color(0xFFD8D8D8);
    const Color textColor = Colors.black;

    return GestureDetector(
      onTap: () {
        // Navigation Logic: Go to the specific conversation
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ChatConversationScreen(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            // User Icon
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, color: Colors.black, size: 32),
            ),
            const SizedBox(width: 12),
            // User Name Text
            Expanded(
              child: Text(
                userName,
                style: const TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // Arrow icon
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black54,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
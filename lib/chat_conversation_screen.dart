import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatConversationScreen extends StatelessWidget {
  const ChatConversationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 🎨 Color sampled exactly from the Figma image
    const Color mainColor = Color(0xFFB4A8A9); // Dusty Mauve
    const Color iconColor = Colors.black;

    // Set system status bar color
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0,
        leadingWidth: 40,
        titleSpacing: 0,
        // Back Button
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: iconColor),
          onPressed: () => Navigator.of(context).pop(), // Goes back to List
        ),
        // Avatar + Username Row
        title: Row(
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person,
                color: Colors.black,
                size: 32,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'User-name',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // 1. Chat Area
          Expanded(
            child: Container(
              color: Colors.transparent,
              // ListView of messages would go here
            ),
          ),

          // 2. Input Area
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.black54, width: 0.5)
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.sentiment_satisfied_alt_outlined),
                              color: Colors.black,
                              onPressed: () {},
                            ),
                            const Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Message",
                                  hintStyle: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                                ),
                                style: TextStyle(color: Colors.black, fontSize: 16),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.image_outlined),
                              color: Colors.black,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
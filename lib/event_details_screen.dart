import 'package:flutter/material.dart';
import 'menu_screen.dart';
import 'notification_screen.dart';

// Custom colors derived from the Figma design series
const Color _backgroundColor = Color(0xFFEBE3E3); // Light Taupe/Mauve
const Color _foregroundColor = Colors.black87; // Dark text/icon color
const Color _headingColor = Color(0xFF8B77AA); // Purple for 'Events Description' and underlines
const Color _lightHeadingColor = Color(0xFF8B77AA); // Adjusted to be the same purple

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  // Helper widget to build the detail line with an underline
  Widget _buildDetailSection(String title, {bool isUnderlined = true}) {
    return Container(
      width: title.length * 10.5 + 20,
      decoration: BoxDecoration(
        border: isUnderlined
            ? const Border(
          bottom: BorderSide(
            color: _headingColor, // Purple underline
            width: 1.0,
          ),
        )
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 2.0),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: _foregroundColor,
          ),
        ),
      ),
    );
  }

  // Helper for the value part
  Widget _buildValueText(String value) {
    return Text(
      value,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: _foregroundColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Mock data for featured events
    const featuredEvents = [
      'Badminton Tournament',
      'Cricket Tournament',
      'Track Events',
      'Football Tournament',
      'Marathon',
    ];

    // --- REAL IMAGE URL (Sports Track) ---
    const imageUrl = 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80';

    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        elevation: 0,
        // Menu icon on the left - Navigates to Menu
        leading: IconButton(
          icon: const Icon(Icons.menu, color: _foregroundColor, size: 30),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MenuScreen()),
            );
          },
        ),
        centerTitle: true,
        title: const Text(
          'Event',
          style: TextStyle(
            color: _foregroundColor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        // Notification icon on the right
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: const Icon(Icons.notifications_none, color: _foregroundColor, size: 28),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NotificationScreen()),
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button (Text next to the arrow)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: GestureDetector(
                  onTap: () {
                    // --- GO BACK TO CALENDAR ---
                    Navigator.pop(context);
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_back, color: _foregroundColor, size: 28),
                      SizedBox(width: 8),
                      Text(
                        'Back',
                        style: TextStyle(
                          color: _foregroundColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Events Description Header
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                child: Text(
                  'Events Description',
                  style: TextStyle(
                    color: _lightHeadingColor, // Purple color
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              // Event Title
              const Padding(
                padding: EdgeInsets.only(bottom: 15.0),
                child: Text(
                  'Winter Sports Meet',
                  style: TextStyle(
                    color: _foregroundColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Image Display with Padding and Rounded Corners
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                          color: _headingColor,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.broken_image, color: _foregroundColor.withOpacity(0.5)),
                            Text(
                              'Image failed to load',
                              style: TextStyle(color: _foregroundColor.withOpacity(0.5)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Featured Events Header
              const Text(
                'Featured Events',
                style: TextStyle(
                  color: _foregroundColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // List of Featured Events
              ...featuredEvents.map(
                    (event) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Text(
                    event,
                    style: TextStyle(
                      color: _foregroundColor.withOpacity(0.8),
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                ),
              ).toList(),

              const SizedBox(height: 40),

              // Date and Time Details in two columns
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailSection('Date'),
                        const SizedBox(height: 10.0),
                        _buildValueText('20/12/2025'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailSection('Time'),
                        const SizedBox(height: 10.0),
                        _buildValueText('9:30 AM Onwards'),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Location Detail
              _buildDetailSection('Location'),
              const SizedBox(height: 10),
              _buildValueText('Sports Ground'),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'notification_screen.dart';
import 'job_details_screen.dart'; // <--- ADDED THIS IMPORT

// Custom colors derived from the Figma design series
const Color _backgroundColor = Color(0xFFEBE3E3); // Light Taupe/Mauve
const Color _cardColor = Color(0xFFDCDCDC); // Soft Grey for the job cards
const Color _foregroundColor = Colors.black87; // Dark text/icon color

// Data model for a single job listing
class JobListing {
  final String user;
  final String timeAgo;
  final String title;
  final String location;
  final String salary;

  const JobListing({
    required this.user,
    required this.timeAgo,
    required this.title,
    required this.location,
    required this.salary,
  });
}

class JobsFeedScreen extends StatelessWidget {
  const JobsFeedScreen({super.key});

  // Mock list of job data
  final List<JobListing> jobListings = const [
    JobListing(
      user: 'John Doe',
      timeAgo: '1h',
      title: 'Store Associate',
      location: 'Frederick, MD',
      salary: '17/hr',
    ),
    JobListing(
      user: 'John Doe',
      timeAgo: '1h',
      title: 'Store Associate',
      location: 'Frederick, MD',
      salary: '17/hr',
    ),
    JobListing(
      user: 'John Doe',
      timeAgo: '1h',
      title: 'Store Associate',
      location: 'Frederick, MD',
      salary: '17/hr',
    ),
    JobListing(
      user: 'John Doe',
      timeAgo: '1h',
      title: 'Store Associate',
      location: 'Frederick, MD',
      salary: '17/hr',
    ),
  ];

  // Helper widget for a single job card
  Widget _buildJobCard(BuildContext context, JobListing job) {
    return GestureDetector(
      // --- NAVIGATION LOGIC ADDED HERE ---
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const JobDetailsScreen()),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _cardColor,
          borderRadius: BorderRadius.circular(20), // Highly rounded corners
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
            // Job details section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User and time posted
                  Row(
                    children: [
                      Text(
                        job.user,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _foregroundColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        job.timeAgo,
                        style: TextStyle(
                          fontSize: 14,
                          color: _foregroundColor.withOpacity(0.6),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Job Title
                  Text(
                    job.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _foregroundColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Location and Salary
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Location Icon and Text
                      const Icon(Icons.location_on_outlined,
                          size: 18, color: _foregroundColor),
                      const SizedBox(width: 4),
                      Text(
                        job.location,
                        style: const TextStyle(
                          fontSize: 16,
                          color: _foregroundColor,
                        ),
                      ),
                      const SizedBox(width: 20),
                      // Salary Icon and Text
                      const Icon(Icons.monetization_on_outlined,
                          size: 18, color: _foregroundColor),
                      const SizedBox(width: 4),
                      Text(
                        job.salary,
                        style: const TextStyle(
                          fontSize: 16,
                          color: _foregroundColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Navigation Arrow (Right side)
            const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Icon(
                Icons.arrow_forward_ios,
                color: _foregroundColor,
                size: 28,
              ),
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
        // Menu icon on the left - Navigates Back
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: _foregroundColor, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        // Title updated as in design
        title: const Text(
          'Jobs Feed',
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
              icon: const Icon(Icons.notifications_none,
                  color: _foregroundColor, size: 28),
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
      body: ListView.builder(
        itemCount: jobListings.length,
        itemBuilder: (context, index) {
          return _buildJobCard(context, jobListings[index]);
        },
      ),
    );
  }
}
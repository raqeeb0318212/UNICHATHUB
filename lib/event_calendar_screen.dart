import 'package:flutter/material.dart';
import 'notification_screen.dart';
import 'event_details_screen.dart'; // <--- ADDED THIS IMPORT

// Custom colors derived from the Figma design
const Color _backgroundColor = Color(0xFFEBE3E3); // Light Taupe/Mauve
const Color _cardColor = Color(0xFFDCDCDC); // Soft Grey for the calendar card
const Color _foregroundColor = Colors.black87; // Dark text/icon color
const Color _highlightColor = Color(0xFFF9D87E); // Yellow for highlighted/selected dates
const Color _orangeHighlightColor = Color(0xFFF09A51); // Orange for 'Today'
const Color _upcomingEventsColor = Color(0xFF8B77AA); // Purple for 'Upcoming Events'

class EventCalendarScreen extends StatefulWidget {
  const EventCalendarScreen({super.key});

  @override
  State<EventCalendarScreen> createState() => _EventCalendarScreenState();
}

class _EventCalendarScreenState extends State<EventCalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // --- Logic to get month name ---
  String _getMonthName(int month) {
    const List<String> months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  // --- Navigation Logic ---
  void _onLeftArrowTap() {
    setState(() {
      _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1);
    });
  }

  void _onRightArrowTap() {
    setState(() {
      _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1);
    });
  }

  // --- Helper to build date cell ---
  Widget _buildDateCell(int? date, {bool isToday = false, bool isSelected = false}) {
    if (date == null) return const SizedBox(); // Empty cell

    Color? bgColor;
    if (isSelected) {
      bgColor = _highlightColor; // Yellow for selected
    } else if (isToday) {
      bgColor = _orangeHighlightColor; // Orange for today
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDay = DateTime(_focusedDay.year, _focusedDay.month, date);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          '$date',
          style: const TextStyle(
            color: _foregroundColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 1. Calculate Calendar Logic
    final int year = _focusedDay.year;
    final int month = _focusedDay.month;
    final int daysInMonth = DateTime(year, month + 1, 0).day;
    final int firstWeekday = DateTime(year, month, 1).weekday;
    final int offset = firstWeekday - 1;

    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        elevation: 0,
        // Menu icon on left - Navigates Back
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: _foregroundColor, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          'Event Calendar',
          style: TextStyle(
            color: _foregroundColor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(28, 8, 28, 20),
              child: Text(
                'Organised by Department',
                style: TextStyle(
                  color: _foregroundColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Calendar Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: _foregroundColor, size: 30),
                    onPressed: _onLeftArrowTap,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.70,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: _cardColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 0,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          '${_getMonthName(month)} $year',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: _foregroundColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Mo', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('Tu', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('We', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('Th', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('Fr', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('Sa', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('Su', style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 15),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 1.0,
                          ),
                          itemCount: offset + daysInMonth,
                          itemBuilder: (context, index) {
                            if (index < offset) return _buildDateCell(null);
                            final int date = index - offset + 1;

                            final bool isSelected = _selectedDay != null &&
                                _selectedDay!.day == date &&
                                _selectedDay!.month == month &&
                                _selectedDay!.year == year;

                            final DateTime now = DateTime.now();
                            final bool isToday = now.day == date &&
                                now.month == month &&
                                now.year == year;

                            return _buildDateCell(
                              date,
                              isToday: isToday,
                              isSelected: isSelected,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios, color: _foregroundColor, size: 30),
                    onPressed: _onRightArrowTap,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Upcoming Events Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 200,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: _upcomingEventsColor,
                          width: 2,
                        ),
                      ),
                    ),
                    child: const Text(
                      'Upcoming Events',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: _upcomingEventsColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // --- CLICKABLE EVENT CARD ---
                  GestureDetector(
                    onTap: () {
                      if (_selectedDay != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const EventDetailsScreen()),
                        );
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: _cardColor,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              _selectedDay != null
                                  ? 'Winter Sports Meet\nDepartment of CS'
                                  : 'Select a date to view events.',
                              style: const TextStyle(
                                color: _foregroundColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          if (_selectedDay != null)
                            const Icon(Icons.arrow_forward_ios, size: 16, color: _foregroundColor),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
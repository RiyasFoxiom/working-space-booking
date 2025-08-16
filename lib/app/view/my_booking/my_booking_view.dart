import 'package:coworking_space_booking/core/extensions/space_ext.dart';
import 'package:coworking_space_booking/core/style/app_font.dart';
import 'package:flutter/material.dart';

class MyBookingView extends StatelessWidget {
  const MyBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'My Bookings',
          style: TextStyle(fontFamily: inter600, fontSize: 24),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SimpleBookingCard(
            status: 'Upcoming',
            statusColor: Colors.blue.shade50,
            statusTextColor: Colors.blue.shade700,
            accentColor: Colors.blue,
            title: 'WeWork BKC',
            location: 'Bandra Kurla Complex, Mumbai',
            date: 'Dec 20, 2024',
            time: '9:00 AM - 1:00 PM',
            price: '₹800',
          ),

          16.hBox,

          SimpleBookingCard(
            status: 'Upcoming',
            statusColor: Colors.blue.shade50,
            statusTextColor: Colors.blue.shade700,
            accentColor: Colors.blue,
            title: '91springboard Koramangala',
            location: 'Koramangala, Bangalore',
            date: 'Dec 22, 2024',
            time: '2:00 PM - 6:00 PM',
            price: '₹600',
          ),

          16.hBox,

          SimpleBookingCard(
            status: 'Completed',
            statusColor: Colors.green.shade50,
            statusTextColor: Colors.green.shade700,
            accentColor: Colors.green,
            title: 'Innov8 Connaught Place',
            location: 'Connaught Place, Delhi',
            date: 'Dec 15, 2024',
            time: '10:00 AM - 6:00 PM',
            price: '₹1200',
          ),
        ],
      ),
    );
  }
}

class SimpleBookingCard extends StatelessWidget {
  final String status;
  final Color statusColor;
  final Color statusTextColor;
  final Color accentColor;
  final String title;
  final String location;
  final String date;
  final String time;
  final String price;

  const SimpleBookingCard({
    super.key,
    required this.status,
    required this.statusColor,
    required this.statusTextColor,
    required this.accentColor,
    required this.title,
    required this.location,
    required this.date,
    required this.time,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border(left: BorderSide(color: accentColor, width: 4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: statusTextColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),

            16.hBox,

            // Title
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            12.hBox,

            // Location
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 18,
                  color: Colors.red[400],
                ),
                8.wBox,
                Expanded(
                  child: Text(
                    location,
                    style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            12.hBox,

            // Date and Time row
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 18,
                  color: Colors.grey[600],
                ),
                8.wBox,
                Text(
                  date,
                  style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                ),
                20.wBox,
                Icon(
                  Icons.access_time_outlined,
                  size: 18,
                  color: Colors.grey[600],
                ),
                8.wBox,
                Expanded(
                  child: Text(
                    time,
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  ),
                ),
              ],
            ),

            16.hBox,

            // Price
            Text(
              price,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

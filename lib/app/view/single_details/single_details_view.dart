import 'package:cached_network_image/cached_network_image.dart';
import 'package:coworking_space_booking/app/models/working_space_model.dart';
import 'package:coworking_space_booking/app/view/booking_view/booking_view.dart';
import 'package:coworking_space_booking/core/extensions/space_ext.dart';
import 'package:coworking_space_booking/core/screen_utils.dart';
import 'package:flutter/material.dart';

class SingleDetailsView extends StatelessWidget {
  const SingleDetailsView({super.key, required this.office});

  final WorkSpace office;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          office.name ?? "Workspace Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: Colors.black,
       
      ),
      body: Column(
        children: [
          // Scrollable content
          Expanded(
            child: ListView(
              children: [
                // Hero Image Section
                Container(
                  height: height / 3.2,
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                          imageUrl: office.image ?? '',
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[200],
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[200],
                            child: Icon(Icons.image_not_supported, size: 50),
                          ),
                        ),
                        // Gradient overlay
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha:  0.4),
                              ],
                            ),
                          ),
                        ),
                        // Price badge
                        Positioned(
                          top: 16,
                          right: 16,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha:  0.8),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "₹${office.ratePerHr?.toInt() ?? 0}/hr",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Content Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title Section
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha:  0.05),
                              blurRadius: 10,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              office.name ?? "Workspace",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                         12.hBox,
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.red[50],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.location_on,
                                    size: 18,
                                    color: Colors.red[400],
                                  ),
                                ),
                               10.wBox,
                                Expanded(
                                  child: Text(
                                    office.location ?? "Location not specified",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                   16.hBox,

                      // Description Section
                      if (office.description != null && office.description!.isNotEmpty)
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Discription",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              12.hBox,
                              Text(
                                office.description!,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey[700],
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),

                      16.hBox,

                      // Amenities Section
                      if (office.amenities != null && office.amenities!.isNotEmpty)
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Amenities",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                             16.hBox,
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: office.amenities!.map((amenity) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.blue[50],
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: Colors.blue[100]!),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          _getAmenityIcon(amenity),
                                          size: 16,
                                          color: Colors.blue[700],
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          amenity,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.blue[700],
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),

                    100.hBox,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // Floating Book Now Button
      floatingActionButton: Container(
        width: double.infinity,
        margin: EdgeInsets.all(16),
        child: FloatingActionButton.extended(
          onPressed: () {
            Screen.open(BookingView(office: office));
          },
          backgroundColor: Colors.blue,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          label: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.book_online, color: Colors.white),
              SizedBox(width: 8),
              Text(
                "Book Now • ₹${office.ratePerHr?.toInt() ?? 0}/hr",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // Helper method to get appropriate icons for amenities
  IconData _getAmenityIcon(String amenity) {
    final amenityLower = amenity.toLowerCase();
    if (amenityLower.contains('wifi') || amenityLower.contains('internet')) {
      return Icons.wifi;
    } else if (amenityLower.contains('parking')) {
      return Icons.local_parking;
    } else if (amenityLower.contains('meeting') || amenityLower.contains('conference')) {
      return Icons.meeting_room;
    } else if (amenityLower.contains('coffee') || amenityLower.contains('tea')) {
      return Icons.local_cafe;
    } else if (amenityLower.contains('24') || amenityLower.contains('access')) {
      return Icons.access_time;
    } else if (amenityLower.contains('air') || amenityLower.contains('ac')) {
      return Icons.ac_unit;
    } else if (amenityLower.contains('security')) {
      return Icons.security;
    } else if (amenityLower.contains('printer')) {
      return Icons.print;
    } else if (amenityLower.contains('kitchen')) {
      return Icons.kitchen;
    } else if (amenityLower.contains('locker')) {
      return Icons.lock;
    } else {
      return Icons.check_circle_outline;
    }
  }
}
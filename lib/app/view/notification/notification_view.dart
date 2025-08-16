import 'package:coworking_space_booking/app/controllers/notification_controller.dart';
import 'package:coworking_space_booking/core/extensions/space_ext.dart';
import 'package:coworking_space_booking/core/style/app_font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(
            fontSize: 20,
            fontFamily: inter600,
            color: const Color(0xFF1E293B),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        shadowColor: Colors.black12,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF64748B)),
          onPressed: () => Get.back(),
        ),
       
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return _buildShimmerList();
        }
        
        if (controller.notifications.isEmpty) {
          return _buildEmptyState();
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            final notification = controller.notifications[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildNotificationCard(notification, index),
            );
          },
        );
      }),
    );
  }

  Widget _buildNotificationCard(notification, int index) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 300 + (index * 100)),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha:  0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _buildNotificationIcon(notification),
                16.wBox,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification.title ?? 'Notification',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: inter600,
                                color: const Color(0xFF1E293B),
                                height: 1.3,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (!notification.isRead)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFF3B82F6),
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      if (notification.content?.isNotEmpty == true) ...[
                        6.hBox,
                        Text(
                          notification.content!,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: inter400,
                            color: const Color(0xFF64748B),
                            height: 1.4,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      8.hBox,
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: const Color(0xFF94A3B8),
                          ),
                          4.wBox,
                          Text(
                            _getTimeAgo(notification.createdAt?.toIso8601String() ?? ''),
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: inter400,
                              color: const Color(0xFF94A3B8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationIcon(notification) {
    IconData iconData;
    Color backgroundColor;
    Color iconColor;

    // Customize based on notification type
    switch (notification.type?.toLowerCase()) {
      case 'booking':
        iconData = Icons.event_seat;
        backgroundColor = const Color(0xFFDCFCE7);
        iconColor = const Color(0xFF16A34A);
        break;
      case 'payment':
        iconData = Icons.payment;
        backgroundColor = const Color(0xFFDEF7FF);
        iconColor = const Color(0xFF0EA5E9);
        break;
      case 'reminder':
        iconData = Icons.schedule;
        backgroundColor = const Color(0xFFFEF3C7);
        iconColor = const Color(0xFFF59E0B);
        break;
      case 'alert':
        iconData = Icons.warning;
        backgroundColor = const Color(0xFFFEE2E2);
        iconColor = const Color(0xFFEF4444);
        break;
      default:
        iconData = Icons.notifications;
        backgroundColor = const Color(0xFFE0E7FF);
        iconColor = const Color(0xFF6366F1);
    }

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        iconData,
        color: iconColor,
        size: 24,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(60),
            ),
            child: const Icon(
              Icons.notifications_off_outlined,
              size: 60,
              color: Color(0xFF94A3B8),
            ),
          ),
          24.hBox,
          Text(
            'No notifications yet',
            style: TextStyle(
              fontSize: 20,
              fontFamily: inter600,
              color: const Color(0xFF1E293B),
            ),
          ),
          8.hBox,
          Text(
            'When you receive notifications,\nthey will appear here',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontFamily: inter400,
              color: const Color(0xFF64748B),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: const NotificationShimmer(),
      ),
    );
  }

  String _getTimeAgo(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inMinutes < 1) {
        return 'Just now';
      } else if (difference.inMinutes < 60) {
        return '${difference.inMinutes}m ago';
      } else if (difference.inHours < 24) {
        return '${difference.inHours}h ago';
      } else if (difference.inDays < 7) {
        return '${difference.inDays}d ago';
      } else {
        return '${(difference.inDays / 7).floor()}w ago';
      }
    } catch (e) {
      return '';
    }
  }
}

class NotificationShimmer extends StatelessWidget {
  const NotificationShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Leading icon placeholder
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            16.wBox,
            // Content placeholder
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 16,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  8.hBox,
                  Container(
                    height: 14,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  6.hBox,
                  Container(
                    height: 14,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  8.hBox,
                  Container(
                    height: 12,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
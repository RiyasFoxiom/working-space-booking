
// Updated AppNotification model with additional properties
class AppNotification {
  final String? id;
  final String? title;
  final String? content;
  final String? type;
  final String? referenceId;
  final DateTime? createdAt;
  final bool isRead;

  AppNotification({
    this.id,
    this.title,
    this.content,
    this.type,
    this.referenceId,
    this.createdAt,
    this.isRead = false,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      type: json['type'] as String?,
      referenceId: json['referenceId'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      isRead: json['isRead'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'type': type,
      'referenceId': referenceId,
      'createdAt': createdAt?.toIso8601String(),
      'isRead': isRead,
    };
  }

  // Create a copy with updated properties
  AppNotification copyWith({
    String? id,
    String? title,
    String? content,
    String? type,
    String? referenceId,
    DateTime? createdAt,
    bool? isRead,
    String? actionUrl,
  }) {
    return AppNotification(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      type: type ?? this.type,
      referenceId: referenceId ?? this.referenceId,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
    );
  }
}



// Enhanced mock data with additional properties
List<Map<String, dynamic>> mockNotificationsJson = [
  {
    "id": "1",
    "title": "Booking Confirmed",
    "content": "Your workspace at WeWork BKC is confirmed for Dec 20, 2024 at 9:00 AM.",
    "type": "booking",
    "referenceId": "BK001",
    "createdAt": "2025-08-16T10:30:00Z",
    "isRead": false,
  },
  {
    "id": "2",
    "title": "Payment Successful",
    "content": "Payment of ₹1,500 for your booking at 91springboard has been processed successfully.",
    "type": "payment",
    "referenceId": "PAY001",
    "createdAt": "2025-08-16T09:15:00Z",
    "isRead": false,
  },
  {
    "id": "3",
    "title": "Booking Reminder",
    "content": "You have a booking tomorrow at 91springboard Koramangala at 2:00 PM.",
    "type": "reminder",
    "referenceId": "BK002",
    "createdAt": "2025-08-15T14:45:00Z",
    "isRead": true,
  },
  {
    "id": "4",
    "title": "Session Completed",
    "content": "Thank you for using Innov8 Connaught Place. Rate your experience!",
    "type": "booking",
    "referenceId": "BK003",
    "createdAt": "2025-08-14T09:15:00Z",
    "isRead": true,
  },
  {
    "id": "5",
    "title": "Welcome Bonus",
    "content": "Congratulations! You've earned ₹200 cashback on your first booking.",
    "type": "payment",
    "referenceId": "CB001",
    "createdAt": "2025-08-13T16:30:00Z",
    "isRead": false,
  },
  {
    "id": "6",
    "title": "Maintenance Alert",
    "content": "Scheduled maintenance at WeWork Andheri on Aug 18, 2025 from 2:00 PM to 4:00 PM.",
    "type": "alert",
    "referenceId": "MAIN001",
    "createdAt": "2025-08-12T11:00:00Z",
    "isRead": false,
  },
  {
    "id": "7",
    "title": "New Space Available",
    "content": "Check out the newly opened co-working space at Cyber City, Gurgaon!",
    "type": "info",
    "referenceId": "SP001",
    "createdAt": "2025-08-11T13:20:00Z",
    "isRead": true,
  }
];
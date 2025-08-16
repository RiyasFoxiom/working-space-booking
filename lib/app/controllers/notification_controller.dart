import 'package:coworking_space_booking/app/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class NotificationController extends GetxController {
  RxList<AppNotification> notifications = <AppNotification>[].obs;
  RxBool isLoading = false.obs;
  RxInt unreadCount = 0.obs;

  @override
  void onInit() {
    loadNotificationsFromMock();
    super.onInit();
  }

  void loadNotificationsFromMock() async {
    try {
      isLoading.value = true;

      await Future.delayed(Duration(seconds: 2));

      List<AppNotification> loadedNotifications = mockNotificationsJson
          .map((json) => AppNotification.fromJson(json))
          .toList();

      notifications.value = loadedNotifications;
      isLoading.value = false;
    } catch (e) {
      debugPrint("Error loading notifications: $e");
      isLoading.value = false;
    }
  }



}

import 'package:carousel_slider/carousel_controller.dart';
import 'package:coworking_space_booking/app/models/working_space_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final CarouselSliderController carouselController =
      CarouselSliderController();
  RxInt currentIndex = 0.obs;

  RxBool isLoading = false.obs;

  RxList<WorkSpace> officeSpaces = <WorkSpace>[].obs;

  List<String> images = [
    "https://innerspace.work/wp-content/uploads/slider/cache/9b329c275031a751a127e162fd87aeda/UB-Business-Centre-1-1-scaled.jpg",
    "https://innerspace.work/wp-content/uploads/slider/cache/5e70f85812485cc290e8dea164cd8dfc/IMG-20231214-WA0029-1-scaled.jpg",
    "https://innerspace.work/wp-content/uploads/slider/cache/9daddae2c42097afaf5a1f5ba5a35341/office-space.webp",
    "https://innerspace.work/wp-content/uploads/slider/cache/e4a61d1fa313e2317b880b7ccaebc7ce/Slide4_Innerspace.jpg",
  ];
  @override
  void onInit() {
    super.onInit();
    getOfficeSpaces();
  }

  void getOfficeSpaces() async {
    try {
      isLoading.value = true;

      // Simulate network delay
      await Future.delayed(Duration(seconds: 2));

      // Convert JSON maps to Place objects
      officeSpaces.value = mockPlacesJson
          .map((json) => WorkSpace.fromJson(json))
          .toList();
    } catch (e) {
      debugPrint("Error fetching office spaces: $e");
    } finally {
      isLoading.value = false;
    }
  }
}

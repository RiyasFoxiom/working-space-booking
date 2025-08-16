import 'package:coworking_space_booking/app/controllers/landing_controller.dart';
import 'package:coworking_space_booking/app/view/home/home_view.dart';
import 'package:coworking_space_booking/app/view/map_view/map_view.dart';
import 'package:coworking_space_booking/app/view/my_booking/my_booking_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/app_bottom_nav.dart';

class LandingView extends StatelessWidget {
  const LandingView({super.key, this.pageIndex = 0});

  final int pageIndex;

  List<Widget> get pages {
    return [HomeView(), MapView(), MyBookingView()];
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(
      LandingController(currentIndex: pageIndex),
      tag: "$hashCode-$pageIndex",
    );
    return Obx(
      () => Scaffold(
        body: pages[ctrl.currentIndex.value],
        bottomNavigationBar: AppBottomNav(
          currentIndex: ctrl.currentIndex.value,
          onTap: (index) {
            ctrl.setIndex(index);
          },
        ),
      ),
    );
  }
}

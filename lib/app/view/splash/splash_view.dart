import 'package:coworking_space_booking/app/controllers/splash_controller.dart';
import 'package:coworking_space_booking/core/style/app_font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      body: Column(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/coworking.png",
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          Center(
            child: Text(
              "Inner Space",
              style: TextStyle(fontFamily: inter600, fontSize: 24),
            ),
          ),
          Text(
            "Find your perfect workspace",
            style: TextStyle(fontFamily: inter400, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

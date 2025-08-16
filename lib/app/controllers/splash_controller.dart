import 'package:coworking_space_booking/app/view/landing_view/landing_view.dart';
import 'package:coworking_space_booking/core/screen_utils.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(Duration(seconds: 3), () {
      Screen.openAsNewPage(LandingView());
    });
    super.onInit();
  }
}

import 'dart:async';

import 'package:coworking_space_booking/core/screen_utils.dart';
import 'package:coworking_space_booking/core/style/app_font.dart';
import 'package:coworking_space_booking/shared/widgets/app_svg.dart';
import 'package:flutter/material.dart';

class AppSuccessBottomSheet extends StatelessWidget {
  const AppSuccessBottomSheet({super.key, this.title, this.subTitle});

  final String? title, subTitle;

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Screen.close();
    });
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
            leading: const AppSvg(assetName: "circle_check"),
            title: Text(
              title ?? "",
              style: TextStyle(fontFamily: inter600, fontSize: 17),
            ),
            subtitle: Text(
              subTitle ?? "",
              style: TextStyle(fontFamily: inter400, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

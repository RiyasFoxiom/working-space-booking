import 'package:coworking_space_booking/core/extensions/string_ext.dart';
import 'package:coworking_space_booking/core/style/app_font.dart';
import 'package:coworking_space_booking/shared/widgets/app_svg.dart';
import 'package:flutter/material.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    final title = ["Home", "Map", "My Booking"];
    final activeIcons = ['home_0', 'map', 'note_2'];
    final inactiveIcons = ['home', 'map_1', 'note'];

    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedFontSize: 14,
      onTap: onTap,
      items: List.generate(
        activeIcons.length,
        (index) => BottomNavigationBarItem(
          icon: BnvIcon(iconName: inactiveIcons[index], color: Colors.grey),
          activeIcon: BnvIcon(
            iconName: activeIcons[index],
            color: Color(0xffc0bd00),
          ),
          label: title[index].upperFirst,
        ),
      ),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Color(0xffc0bd00),
      selectedLabelStyle: TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontFamily: inter400,
      ),
      unselectedLabelStyle: TextStyle(
        color: Colors.grey,
        fontSize: 14,
        fontFamily: inter400,
      ),
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
    );
  }
}

class BnvIcon extends StatelessWidget {
  const BnvIcon({super.key, required this.iconName, required this.color});

  final String iconName;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: AppSvg(assetName: iconName, color: color),
    );
  }
}

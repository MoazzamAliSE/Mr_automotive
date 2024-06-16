import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_motive/view%20model/controller/bottom_nav_bar_controller.dart';
import 'package:auto_motive/view/add_services/bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomNav extends StatelessWidget {
  final controller = Get.put(BottomNavigationBarController());

  CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      extendBody: true,
      body: GetBuilder<BottomNavigationBarController>(
        builder: (controller) => PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.pageController,
          onPageChanged: (index) {
            controller.bottomNavIndex = index;
          },
          children: controller.pageList,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ServicesBottomSheet.show();
        },
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.grey,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: GetBuilder<BottomNavigationBarController>(
        builder: (controller) => AnimatedBottomNavigationBar.builder(
          itemCount: controller.iconList.length,
          tabBuilder: (int index, bool isActive) {
            final isSelected = controller.bottomNavIndex == index;
            final IconData iconData = isSelected
                ? controller.iconList[index]
                : controller.outlinedIconList[index];
            final color =
                isActive ? Colors.white : Colors.white.withOpacity(0.5);
            final iconSize = isActive ? 30.0 : 24.0;
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  size: iconSize,
                  color: color,
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    controller.textList[index],
                    maxLines: 1,
                    style: const TextStyle(color: Colors.white, fontSize: 9),
                  ),
                )
              ],
            );
          },
          backgroundColor: Colors.grey[900],
          activeIndex: controller.bottomNavIndex,
          splashColor: Colors.black,
          splashSpeedInMilliseconds: 300,
          notchSmoothness: NotchSmoothness.defaultEdge,
          gapLocation: GapLocation.center,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          onTap: controller.onTapBottomIcon,
          shadow: const BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 12,
            spreadRadius: 0.5,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

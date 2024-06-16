import 'package:auto_motive/view/chat/chat_with.dart';
import 'package:auto_motive/view/favourite/favourite_items.dart';
import 'package:auto_motive/view/home_page/home_page.dart';
import 'package:auto_motive/view/account/account_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationBarController extends GetxController {
  int bottomNavIndex = 0;
   PageController pageController=PageController();
  final iconList = <IconData>[
    Icons.home,
    Icons.favorite,
    Icons.chat,
    Icons.person,
  ];
  onTapBottomIcon(index) {
    bottomNavIndex = index;
    // pageController.jumpToPage(index);
    pageController.animateToPage(index, duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
    update();
  }

  final textList = <String>[
    "Home",
    "Favorites",
    "Chat",
    "Profile",
  ];
  final outlinedIconList = <IconData>[
    Icons.home_outlined,
    Icons.favorite_outline,
    Icons.chat_outlined,
    Icons.person_outline,
  ];
  final pageList = <Widget>[
    const HomePage(),
    FavouriteItems(),
    const ChatWith(),
    const AccountPage(),
  ];
  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: bottomNavIndex);
  }
}

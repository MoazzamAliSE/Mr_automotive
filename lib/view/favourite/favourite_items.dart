import 'package:auto_motive/view%20model/controller/bottom_nav_bar_controller.dart';
import 'package:auto_motive/view%20model/controller/fav_controller.dart';
import 'package:auto_motive/view/common%20widgets/back_button.dart';
import 'package:auto_motive/view/favourite/fav_services/fav_services.dart';
import 'package:auto_motive/view/favourite/favourite_products/favourite_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouriteItems extends StatelessWidget {
   FavouriteItems({super.key});
  final controller=Get.put(FavController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: darkBackgroundColor,
      body: DefaultTabController(
        length: 2,
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black,
                    Colors.black,
                    Colors.black54,
                  ])
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                   Row(
                    children: [
                      CustomBackButton(
                        onTap: () {
                          Get.put(BottomNavigationBarController()).onTapBottomIcon(0);

                        },
                      ),
                      const SizedBox(width: 20,),
                      const Text('Favourite Items',style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),)
                    ],
                  ),
                  const SizedBox(height: 20,),
                  const TabBar(
                    dividerColor: Colors.transparent,
                      unselectedLabelColor: Colors.white70,
                      labelColor: Colors.pinkAccent,
                      indicatorColor: Colors.pinkAccent,
                      tabs: [
                    Tab(
                     text: 'Services',
                    ),
                    Tab(
                      text: 'Spare Parts',
                    )
                  ]),
                  const SizedBox(height: 20,),
                  Expanded(child: TabBarView(
                    children: [
                      FavouriteServices(),
                      FavouriteProducts(),]
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

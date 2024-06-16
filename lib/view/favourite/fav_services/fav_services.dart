import 'package:auto_motive/view%20model/controller/fav_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../available_services/components/services_holder.dart';

class FavouriteServices extends StatelessWidget {
   FavouriteServices({super.key});
   final controller=Get.put(FavController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.favouriteServicesItem.isEmpty ? const Center(
      child: Text('No Favourite Item available',style: TextStyle(color: Colors.white),),
    ):
    GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.7),

      itemCount: controller.favouriteServicesItem.length,
      itemBuilder: (context, index) {
        return Padding(
             padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
            child: ServicesHolder(service: controller.favouriteServicesItem[index]));
      },)
    );
  }
}

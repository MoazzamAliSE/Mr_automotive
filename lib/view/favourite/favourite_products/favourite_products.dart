import 'package:auto_motive/view/available_products/components/product_holder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../view model/controller/fav_controller.dart';

class FavouriteProducts extends StatelessWidget {
  FavouriteProducts({super.key});
  final controller=Get.put(FavController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.favouriteSparePartItem.isEmpty ? const Center(
      child: Text('No Favourite Item available',style: TextStyle(color: Colors.white),),
    ):
    GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.7),

      itemCount: controller.favouriteSparePartItem.length,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
            child: ProductHolder(product: controller.favouriteSparePartItem[index]));
      },)
    );
  }
}

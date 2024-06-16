import 'package:auto_motive/view%20model/controller/add_to_cart_controller.dart';
import 'package:auto_motive/view/common%20widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../available_products/components/product_holder.dart';

class MyCart extends StatelessWidget {
   MyCart({super.key});
   final controller=Get.put(AddToCartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: darkBackgroundColor,
      body: Container(
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
                    CustomBackButton(onTap: () => Get.back(),),
                    const SizedBox(width: 20,),
                    const Text('My Cart',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                  ],
                ),
                const SizedBox(height: 20,),
                Expanded(child: Obx(() => controller.cartItems.isEmpty ? const Center(
                  child: Text('No Item available in your cart',style: TextStyle(color: Colors.white),),
                ):
                GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.7),
                  itemCount: controller.cartItems.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
                        child: ProductHolder(product: controller.cartItems[index]));
                  },)
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}



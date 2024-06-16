import 'package:auto_motive/data/network/firebase/order_services.dart';
import 'package:auto_motive/model/product_model.dart';
import 'package:auto_motive/res/routes/routes.dart';
import 'package:auto_motive/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController{
  placeOrder({required int quantity,required int price,required ProductModel product})async{
    Get.offAndToNamed(Routes.home);
    Utils.showSnackBar('Placeing Order', 'Your order request is sedning to the server. Please wait we will notify you',
    const Icon(Icons.timer_outlined,color: Colors.white,)
    );
    try{
     await OrderServices().place(price: price, quantity: quantity, product: product);
      Utils.showSnackBar('Order Placed', 'Your order successfully placed.',
          const Icon(Icons.done_all,color: Colors.white,)
      );
    }catch(_){
      Utils.showSnackBar('Error', 'Unable to place order. ${_.toString()}', const Icon(Icons.warning_amber));
    }



  }

}

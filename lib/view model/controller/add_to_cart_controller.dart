import 'package:auto_motive/data/network/firebase/product_service.dart';
import 'package:auto_motive/model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddToCartController extends GetxController{
  List<dynamic> cart=[].obs;
  RxList cartItems=[].obs;


  getCart() async {
    if(cart.isEmpty){
      try{
        final snapshot=await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
        final list=snapshot.get('myCart');
        final itemSnapshot=await FirebaseFirestore.instance.collection('products').where(FieldPath.documentId,
            whereIn: list
        ).get();
        cartItems.value=itemSnapshot.docs.map((e) => ProductModel.fromFirestore(e)).toList();
        cart.addAll(list);
      }catch(_){
      }
    }
  }

  addToCart({required String id,required ProductModel service}){
    if(cart.contains(id)){
      showGeneralDialog(context: Get.context!, pageBuilder: (context, animation, secondaryAnimation) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          title: const Text('Confirmation',style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),),
          content: const Text('Are you sure to remove this product from your cart'),
          actions: [
            TextButton(onPressed: () => Get.back(), child: const Text('cancel',style: TextStyle(color: Colors.black,
            ),)),
            TextButton(onPressed: () {
              cart.remove(id);
              cartItems.removeWhere((element) => element.id==id);
              Get.back();
              try{
                ProductServices().removeCart(id: id);
              }catch(_){
              }
            }, child: const Text('Ok',style: TextStyle(color: Colors.redAccent,
            ),))
          ],
        );
      },);
    }else{
      showGeneralDialog(context: Get.context!, pageBuilder: (context, animation, secondaryAnimation) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          title: const Text('Confirmation',style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),),
          content: const Text('Are you sure to add this product in your cart'),
          actions: [
            TextButton(onPressed: () => Get.back(), child: const Text('cancel',style: TextStyle(color: Colors.black,
            ),)),
            TextButton(onPressed: () {
              cart.add(id);
              cartItems.add(service);
              Get.back();
              try{
                ProductServices().addToCart(id: id);
              }catch(_){
              }
            }, child: const Text('Ok',style: TextStyle(color: Colors.redAccent,
            ),))
          ],
        );
      },);
    }

  }
}
import 'package:auto_motive/main.dart';
import 'package:auto_motive/model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderServices{
  Future<void> place({required int price,required int quantity,required ProductModel product})async{
    await FirebaseFirestore.instance.collection('users').doc(
        FirebaseAuth.instance.currentUser!.uid
    ).collection('myOrders').doc(product.id).set({
      'productId': product.id,
      'price' : price,
      'clientId' : localUser!.token,
      'quantity' : quantity,
      'product' : product.toMap()
    });


    await FirebaseFirestore.instance.collection('users').doc(
        product.owner.id
    ).collection('receivedOrders').doc(product.id).set(
        {
          'clientId' : localUser!.token,
          'productId': product.id,
          'price' : price,
          'quantity' : quantity,
          'product' : product.toMap()
        }
    );
  }
}
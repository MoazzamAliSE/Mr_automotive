import 'package:auto_motive/data/network/firebase/product_service.dart';
import 'package:auto_motive/model/product_model.dart';
import 'package:auto_motive/model/service_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../data/network/firebase/sell_services.dart';
class FavController extends GetxController{
  RxInt page=0.obs;
  List<dynamic> favouriteServices=[].obs;
  RxList favouriteServicesItem=[].obs;
  List<dynamic> favouriteSpareParts=[].obs;
  RxList<dynamic> favouriteSparePartItem=[].obs;

  getFavouriteServices() async {
    if(favouriteServices.isEmpty){
      try{
        final snapshot=await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
        final list=snapshot.get('favouriteServices');
        final itemSnapshot=await FirebaseFirestore.instance.collection('services').where(FieldPath.documentId,
            whereIn: list
        ).get();
        favouriteServicesItem.value=itemSnapshot.docs.map((e) => ServiceModel.fromFirestore(e)).toList();
        favouriteServices.addAll(list);
      }catch(_){
      }
    }
  }

  addToFavouriteServices({required String id,required ServiceModel service}){
    if(favouriteServices.contains(id)){
      favouriteServices.remove(id);
      favouriteServicesItem.removeWhere((element) => element.id==id);
      try{
        SellServices().removeFavourite(id: id);
      }catch(_){
      }
    }else{
      favouriteServices.add(id);
      favouriteServicesItem.add(service);
      try{
        SellServices().addToFavourite(id: id);
      }catch(_){
      }
    }

  }


  getFavouriteSpareParts() async {
    if(favouriteSpareParts.isEmpty){
      try{
        final snapshot=await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
        final list=snapshot.get('favouriteProducts');
        final itemSnapshot=await FirebaseFirestore.instance.collection('products').where(FieldPath.documentId,
            whereIn: list
        ).get();
        favouriteSparePartItem.value=itemSnapshot.docs.map((e) => ProductModel.fromFirestore(e)).toList();
        favouriteSpareParts.addAll(list);
      }catch(_){
      }
    }
  }

  addToFavouriteProducts({required String id,required ProductModel model}){
    if(favouriteSpareParts.contains(id)){
      favouriteSpareParts.remove(id);
      favouriteSparePartItem.removeWhere((element) => element.id==id);
      try{
        ProductServices().removeFavourite(id: id);
      }catch(_){
      }
    }else{
      favouriteSpareParts.add(id);
      favouriteSparePartItem.add(model);
      try{
        ProductServices().addToFavourite(id: id);
      }catch(_){
      }
    }

  }

}
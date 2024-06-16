import 'package:auto_motive/Data/network/firebase/user_services.dart';
import 'package:auto_motive/data/network/firebase/file_services.dart';
import 'package:auto_motive/main.dart';
import 'package:auto_motive/model/appointment_model_mechanic.dart';
import 'package:auto_motive/model/appointment_models_clients.dart';
import 'package:auto_motive/model/product_order_model.dart';
import 'package:auto_motive/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/user_model.dart';

class ProfileController extends GetxController{
  Rx<UserModel> user=localUser!.obs;
  RxList<AppointmentModel> appointmentWithClients=<AppointmentModel>[].obs;
  RxList<AppointmentModelMechanic> appointmentWithMechanic=<AppointmentModelMechanic>[].obs;
  RxList<ProductOrderModel> myOrders=<ProductOrderModel>[].obs;
  RxList<ProductOrderModel> receivedOrder=<ProductOrderModel>[].obs;
  RxInt rating=5.obs;
  final TextEditingController review=TextEditingController();

  pickImage() async {
    final picker=await ImagePicker().pickImage(source: ImageSource.gallery);
    if(picker!=null){
      showGeneralDialog(context: Get.context!, pageBuilder: (context, animation, secondaryAnimation) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          content: const Text('Are you sure to change your profile picture',style: TextStyle(color: Colors.black),),
          title: const Text('Profile Picture'),
          actions: [
            TextButton(onPressed: () => Get.back(), child: const Text('Cancel',)),
            TextButton(onPressed: () async {
              try{
                Get.back();
                Utils.showSnackBar('Profile Picture', 'Updating your picture', const Icon(Icons.timer_outlined,color: Colors.white,));
                final url=await FileServices.uploadFile(filePath: picker.path,
                    uploadPath: 'profilePictures/${localUser!.token.toString()}/${DateTime.now().microsecondsSinceEpoch.toString()}.jpeg');
                FirebaseServices.updateProfilePicture(url: url);
                // final snapshot=await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
                user.value=localUser!.copyWith(profilePicture: url);
                localUser=user.value;
              }catch(_){
                Utils.showSnackBar('Error', 'Can\'t update your profile picture. ${_.toString()}', const Icon(Icons.warning_amber,color: Colors.redAccent,));
              }
            }, child: const Text('ok',style: TextStyle(color: Colors.red),)),
          ],
        );
      },);
    }
  }
  
  
  
  
  getAppointmentWithClient()async{
    getAppointmentWithMechanic();
    getMyOrders();
    if(appointmentWithClients.isEmpty){
      try{
        final snapshot=await FirebaseFirestore.instance.collection('users').doc(
            FirebaseAuth.instance.currentUser!.uid
        ).get();
        final list=snapshot.get('appointmentWithClients');
        for(var item in list){
          appointmentWithClients.add(AppointmentModel.fromMap(item));
        }
      }catch(_){

      }
    }
  }
  getAppointmentWithMechanic()async{
    if(appointmentWithMechanic.isEmpty){
      try{
        final snapshot=await FirebaseFirestore.instance.collection('users').doc(
            FirebaseAuth.instance.currentUser!.uid
        ).get();
        final list=snapshot.get('appointmentWithMechanic');
        for(var item in list){
          appointmentWithMechanic.add(AppointmentModelMechanic.fromMap(item));
        }
      }catch(_){

      }
    }
  }



  getMyOrders()async{
    getReceivedOrders();
    if(myOrders.isEmpty){
      try{
        final snapshot=await FirebaseFirestore.instance.collection('users').doc(
            FirebaseAuth.instance.currentUser!.uid
        ).get();
        final list=snapshot.get('myOrders');
        for(var item in list){
          myOrders.add(ProductOrderModel.fromMap(item));
        }
      }catch(_){

      }
    }
  }
  getReceivedOrders()async{
    if(receivedOrder.isEmpty){
      try{
        final snapshot=await FirebaseFirestore.instance.collection('users').doc(
            FirebaseAuth.instance.currentUser!.uid
        ).get();
        final list=snapshot.get('receivedOrders');
        for(var item in list){
          receivedOrder.add(ProductOrderModel.fromMap(item));
        }
      }catch(_){

      }
    }
  }

}
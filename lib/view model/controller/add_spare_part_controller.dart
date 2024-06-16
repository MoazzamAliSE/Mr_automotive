import 'package:auto_motive/data/network/firebase/product_service.dart';
import 'package:auto_motive/data/shared%20pref/shared_pref.dart';
import 'package:auto_motive/model/product_model.dart';
import 'package:auto_motive/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/network/firebase/file_services.dart';
import '../../main.dart';
import '../../model/service_model.dart';
import '../../utils/utils.dart';

class AddSparePartController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  final title = TextEditingController();
  final location = TextEditingController();
  final warranty = TextEditingController();
  final delivery = TextEditingController();
  final price = TextEditingController();
  final description = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RxString selectedLocation = ''.obs;
  double latitude = 0;
  double longitude = 0;
  RxBool isPickedImages = false.obs;
  RxInt currentImage = 0.obs;
  RxList images = [].obs;

  @override
  void onInit() async {
    super.onInit();
    final UserModel userModel = await UserPref.getUser();
    name.text = userModel.name ?? "";
    number.text = userModel.phoneNumber ?? "";
    update();
  }

  pickImages() async {
    final picker = await ImagePicker().pickMultiImage();
    final imagesList = picker.map((e) => e.path).toList();
    images.addAll(imagesList);
    if (images.isNotEmpty) {
      isPickedImages.value = true;
    }
    return null;
  }

  removeImage({required String image}) {
    images.remove(image);
    if (images.isEmpty) {
      isPickedImages.value = false;
      currentImage.value = currentImage.value--;
    }
  }

  uploadProduct() async {
    RegExp phoneRegex = RegExp(r'^\+\d{12}$');
    if (!phoneRegex.hasMatch(number.value.text.toString())) {
      Utils.showSnackBar(
        'Warning',
        'Please enter a valid phone number in the format: +923123456789',
        const Icon(FontAwesomeIcons.triangleExclamation, color: Colors.pink),
      );
      return;
    }
    bool isAnyFieldEmpty = [
      name,
      title,
      location,
      warranty,
      delivery,
      price,
      description,
    ].any((controller) => controller.value.text.toString().isEmpty);
    if (isAnyFieldEmpty) {
      Utils.showSnackBar(
          'Warning',
          'Please fill data correctly',
          const Icon(
            Icons.warning_amber,
            color: Colors.red,
          ));
      return;
    } else if (images.isEmpty) {
      Utils.showSnackBar(
          'Warning',
          'Please upload at least one image',
          const Icon(
            Icons.warning_amber,
            color: Colors.red,
          ));
      return;
    }
    Get.back();
    Utils.showSnackBar(
        'Uploading product',
        'Your product is being uploaded. We will notify you.',
        const Icon(
          Icons.done_all,
          color: Colors.white,
        ));
    try {
      ProductModel product = ProductModel(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          name: name.value.text.toString(),
          ratings: [],
          reviews: [],
          title: title.value.text.toString(),
          number: number.value.text.toString(),
          description: description.value.text.toString(),
          price: price.value.text.toString(),
          location: location.value.text.toString(),
          delivery: delivery.value.text.toString(),
          longitude: longitude,
          latitude: latitude,
          warranty: warranty.value.text.toString(),
          owner: Owner(
              profilePicture: localUser!.profilePicture.toString(),
              name: localUser!.name.toString(),
              date: Utils.formatDate(DateTime.now()),
              id: FirebaseAuth.instance.currentUser!.uid,
              contact: localUser!.phoneNumber.toString(),
              latitude: localUser!.latitude!,
              longitude: localUser!.longitude!),
          images: await uploadImages(),
          timeStamp: DateTime.now().microsecondsSinceEpoch.toString());
      await ProductServices().sell(product: product);
      Utils.showSnackBar(
          'Success',
          'Successfully uploaded your product',
          const Icon(
            Icons.done_all,
            color: Colors.white,
          ));
      for (var element in [
        name,
        title,
        location,
        warranty,
        delivery,
        price,
        description,
      ]) {
        element.clear();
      }
      latitude = 0;
      longitude = 0;
      images.clear();
      isPickedImages.value = false;
    } catch (_) {
      Utils.showSnackBar(
          'Error',
          'Can\'t upload your product ${_.toString()}',
          const Icon(
            Icons.done_all,
            color: Colors.white,
          ));
    }
  }

  Future<List<String>> uploadImages() async {
    List<String> ulr = [];
    for (var image in images) {
      try {
        ulr.add(await FileServices.uploadFile(
            filePath: image,
            uploadPath:
                'products/${localUser!.token.toString()}/${DateTime.now().microsecondsSinceEpoch.toString()}/.jpeg'));
      } catch (_) {}
    }
    return ulr;
  }
}

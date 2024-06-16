import 'package:auto_motive/data/network/firebase/file_services.dart';
import 'package:auto_motive/data/network/firebase/sell_services.dart';
import 'package:auto_motive/data/shared%20pref/shared_pref.dart';
import 'package:auto_motive/main.dart';
import 'package:auto_motive/model/service_model.dart';
import 'package:auto_motive/model/user_model.dart';
import 'package:auto_motive/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddServiceController extends GetxController {
  final name = TextEditingController();
  final number = TextEditingController();
  final title = TextEditingController();
  final location = TextEditingController();
  final skill = TextEditingController();
  final experience = TextEditingController();
  final price = TextEditingController();
  final description = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RxString selectedLocation = ''.obs;
  double latitude = 0;
  double longitude = 0;
  RxBool isPickedImages = false.obs;
  RxInt currentImage = 0.obs;
  RxList images = [].obs;
  final nameInitialValue = "".obs;
  final phoneInitialValue = "".obs;

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
  }

  removeImage({required String image}) {
    images.remove(image);
    if (images.isEmpty) {
      isPickedImages.value = false;
      currentImage.value = currentImage.value--;
    }
  }

  uploadServices() async {
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
      skill,
      experience,
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
        'Uploading Service',
        'Your service is being uploaded. We will notify you.',
        const Icon(
          Icons.done_all,
          color: Colors.white,
        ));

    try {
      ServiceModel service = ServiceModel(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          name: name.value.text.toString(),
          ratings: [],
          reviews: [],
          title: title.value.text.toString(),
          number: number.value.text.toString(),
          description: description.value.text.toString(),
          price: price.value.text.toString(),
          location: location.value.text.toString(),
          experience: experience.value.text.toString(),
          longitude: longitude,
          latitude: latitude,
          skill: skill.value.text.toString(),
          owner: Owner(
              profilePicture: localUser!.profilePicture.toString(),
              name: localUser!.name.toString(),
              date: Utils.formatDate(DateTime.now()),
              id: FirebaseAuth.instance.currentUser!.uid,
              contact: localUser!.phoneNumber.toString(),
              latitude: localUser!.latitude ?? 0,
              longitude: localUser!.longitude ?? 0),
          images: await uploadImages(),
          timeStamp: DateTime.now().microsecondsSinceEpoch.toString());
      await SellServices().sell(service: service);
      Utils.showSnackBar(
          'Success',
          'Successfully uploaded your service',
          const Icon(
            Icons.done_all,
            color: Colors.white,
          ));
      for (var element in [
        name,
        title,
        location,
        skill,
        experience,
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
          'Can\'t upload your service ${_.toString()}',
          const Icon(
            Icons.done_all,
            color: Colors.white,
          ));
      print(_.toString());
    }
  }

  Future<List<String>> uploadImages() async {
    List<String> ulr = [];
    for (var image in images) {
      try {
        ulr.add(await FileServices.uploadFile(
            filePath: image,
            uploadPath:
                'services/${localUser!.token.toString()}/${DateTime.now().microsecondsSinceEpoch.toString()}/.jpeg'));
      } catch (_) {}
    }
    return ulr;
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../Data/network/firebase/user_services.dart';
import '../../utils/utils.dart';

class SignupController extends GetxController {
  RxBool nameFocus = false.obs;
  RxBool emailFocus = false.obs;
  RxBool passwordFocus = false.obs;
  RxBool phoneFocus = false.obs;
  RxBool correctEmail = false.obs;
  RxBool correctName = false.obs;
  RxBool showPassword = true.obs;
  RxBool loading = false.obs;
  // final FirebaseServices firebase=FirebaseServices();
  final email = TextEditingController().obs;
  final name = TextEditingController().obs;
  final phoneNumber = TextEditingController().obs;
  final password = TextEditingController().obs;
  void validateEmail() {
    correctEmail.value = Utils.validateEmail(email.value.text.toString());
  }

  void validateName() {
    correctName.value = name.value.text.toString().isNotEmpty;
  }

  void setLoading(bool value) {
    loading.value = value;
  }

  validatePhone(String phone) {
    RegExp phoneRegex = RegExp(r'^\+\d{12}$');
    if (!phoneRegex.hasMatch(phone)) {
      return false;
    }
    return true;
  }

  validatePassword(String password) {
    // Define a regular expression to match password requirements
    RegExp passwordRegex = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$',
    );
    if (!passwordRegex.hasMatch(password)) {
      return false;
    }
    return true;
  }

  Future<void> createAccount() async {
    if (!correctName.value) {
      Utils.showSnackBar(
          'Warning',
          'Enter Correct Name',
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.pink,
          ));
      return;
    }
    if (!correctEmail.value) {
      Utils.showSnackBar(
          'Warning',
          'Enter Correct Email',
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.pink,
          ));
      return;
    }

    if (!validatePassword(password.value.text.toString())) {
      Utils.showSnackBar(
        'Warning',
        'Password must contain at least one uppercase letter, one lowercase letter, one number, one special character(!@#\$&*~), and be at least 6 characters long.',
        const Icon(FontAwesomeIcons.triangleExclamation, color: Colors.pink),
      );
      return;
    }
    if (!validatePhone(phoneNumber.value.text.toString())) {
      Utils.showSnackBar(
        'Warning',
        'Please enter a valid phone number in the format: +923123456789',
        const Icon(FontAwesomeIcons.triangleExclamation, color: Colors.pink),
      );
      return;
    }

    if (password.value.text.toString().length < 6) {
      Utils.showSnackBar(
          'Warning',
          'Password length should greater than 5',
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.pink,
          ));
      return;
    }

    try {
      setLoading(true);
      final position = await _determinePosition();
      await FirebaseServices.createAccount(
          latitude: position.latitude, longitude: position.longitude);
      setLoading(false);
      name.value.clear();
      password.value.clear();
      email.value.clear();
      phoneNumber.value.clear();
    } catch (_) {
      setLoading(false);
      Utils.showSnackBar(
          'Error',
          _.toString(),
          const Icon(
            Icons.warning_amber,
            color: Colors.red,
          ));
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled. Please enable it.');
    }
    return await Geolocator.getCurrentPosition();
  }

  void onFocusEmail() {
    emailFocus.value = true;
    nameFocus.value = false;
    passwordFocus.value = false;
    phoneFocus.value = false;
  }

  void onFocusName() {
    emailFocus.value = false;
    nameFocus.value = true;
    passwordFocus.value = false;
    phoneFocus.value = false;
  }

  void onFocusPassword() {
    emailFocus.value = false;
    nameFocus.value = false;
    passwordFocus.value = true;
    phoneFocus.value = false;
  }

  void onFocusPhone() {
    emailFocus.value = false;
    nameFocus.value = false;
    passwordFocus.value = false;
    phoneFocus.value = true;
  }

  void onTapOutside(BuildContext context) {
    emailFocus.value = false;
    nameFocus.value = false;
    passwordFocus.value = false;
    phoneFocus.value = false;
    FocusScope.of(context).unfocus();
  }
}

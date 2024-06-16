import 'package:auto_motive/main.dart';
import 'package:auto_motive/model/service_model.dart';
import 'package:auto_motive/res/routes/routes.dart';
import 'package:auto_motive/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookAppointmentController extends GetxController {
  String date = '';
  RxInt selectedDate = 0.obs;
  RxInt selectedTime = 0.obs;
  String time = '';

  makeAppointment(ServiceModel service) async {
    if (selectedTime.value == 0 || selectedDate.value == 0) {
      Utils.showSnackBar(
          'Warning',
          'Please select date and time',
          const Icon(
            Icons.warning_amber,
            color: Colors.red,
          ));
      return;
    }
    showGeneralDialog(
      context: Get.context!,
      pageBuilder: (context, animation, secondaryAnimation) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: const Text(
            'Confirm',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
          ),
          content: const Text(
            'Are you sure to make appointment.',
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
          actions: [
            TextButton(
                onPressed: () => Get.back(),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                )),
            TextButton(
                onPressed: () async {
                  Utils.showSnackBar(
                      'Requesting',
                      'We are sending request to the server. Please wait we will notify you',
                      const Icon(
                        Icons.timer_outlined,
                        color: Colors.white,
                      ));
                  Get.offAllNamed(Routes.home);
                  try {
                    final key =
                        DateTime.now().microsecondsSinceEpoch.toString();
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('appointmentWithMechanic')
                        .doc(service.id)
                        .set({
                      'id': service.id,
                      'date': date,
                      'time': time,
                      'mechanic': service.owner.toMap(),
                      'service': service.toMap()
                    });
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(service.owner.id)
                        .collection('appointmentWithClients')
                        .doc(service.id)
                        .set({
                      'id': service.id,
                      'date': date,
                      'time': time,
                      'client': {
                        'name': localUser!.name,
                        'email': localUser!.email,
                        'contact': localUser!.phoneNumber,
                        'id': localUser!.token.toString(),
                        'profilePicture': localUser!.profilePicture.toString()
                      },
                      'service': service.toMap()
                    });
                    Utils.showSnackBar(
                        'Success',
                        'Your appointment is successfully booked. Check it in you appointment list',
                        const Icon(
                          Icons.done_all,
                          color: Colors.white,
                        ));
                  } catch (_) {
                    print(_.toString());
                    Utils.showSnackBar(
                        'Error',
                        _.toString(),
                        const Icon(
                          Icons.warning_amber,
                          color: Colors.red,
                        ));
                  }
                },
                child: const Text(
                  'Ok',
                  style: TextStyle(color: Colors.pinkAccent),
                )),
          ],
        );
      },
    );
  }
}

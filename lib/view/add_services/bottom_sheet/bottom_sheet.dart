import 'package:auto_motive/res/app_images.dart';
import 'package:auto_motive/res/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServicesBottomSheet {
  static show() {
    final context = Get.context!;
    Get.bottomSheet(
      Container(
        height: 200,
        width: MediaQuery.sizeOf(context).width,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            color: Colors.black,
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, -4), color: Colors.white54, blurRadius: 10)
            ]),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 18,
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: (){
                Get.back();
                Get.toNamed(Routes.addSparePart);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  children: [
                    const Text(
                      'Sell Parts',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Image.asset(
                      AppImages.whiteWheelIcon,
                      height: 40,
                      width: 40,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Get.back();
                Get.toNamed(Routes.addServices);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  children: [
                    const Text(
                      'Add Services',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Image.asset(
                      AppImages.whiteCarIcon,
                      height: 40,
                      width: 40,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.black,
      barrierColor: Colors.transparent,
      isScrollControlled: false,
    );
  }
}

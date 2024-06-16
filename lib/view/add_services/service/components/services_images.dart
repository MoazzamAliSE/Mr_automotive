import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'indicators.dart';

class ServiceImages extends StatelessWidget {
  const ServiceImages({super.key,required this.controller});
  final controller;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        GestureDetector(
          onTap: () => controller.pickImages(),
          child: Obx(
            () => Container(
              height: 200,
              width: size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white12),
              child: !controller.isPickedImages.value
                  ? Center(
                      child: IconButton(
                          onPressed: () => controller.pickImages(),
                          icon: const CircleAvatar(
                              backgroundColor: Colors.white12,
                              radius: 30,
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ))),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CarouselSlider(
                          items: [
                            ...controller.images.map((element) => Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Image.file(
                                      File(element),
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 10,
                                      child: IconButton(
                                          onPressed: () {
                                            controller.removeImage(
                                                image: element);
                                          },
                                          icon: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          )),
                                    )
                                  ],
                                )),
                          ],
                          options: CarouselOptions(
                            initialPage: 0,
                            viewportFraction: 1,
                            onPageChanged: (index, reason) {
                              controller.currentImage.value = index;
                            },
                            enableInfiniteScroll: false,
                            reverse: false,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            scrollDirection: Axis.horizontal,
                          )),
                    ),
            ),
          ),
        ),
        Positioned(
            bottom: 20,
            child: Obx(() => Indicators(
                length: controller.images.length,
                currentIndex: controller.currentImage.value)))
      ],
    );
  }
}

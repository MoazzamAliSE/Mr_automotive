import 'package:auto_motive/main.dart';
import 'package:auto_motive/model/service_model.dart';
import 'package:auto_motive/utils/utils.dart';
import 'package:auto_motive/view%20model/controller/book_appointment_controller.dart';
import 'package:auto_motive/view%20model/controller/service_detail_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/user_model.dart';
import '../add_services/service/components/indicators.dart';
import '../chat/chat_screen.dart';
import '../common widgets/back_button.dart';
import '../sign up/components/button.dart';

class BookAppointment extends StatelessWidget {
  BookAppointment({super.key, required this.service});

  final ServiceModel service;
  final controller = Get.put(BookAppointmentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: darkBackgroundColor,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Colors.black,
              Colors.black,
              Colors.black54,
            ])),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    CustomBackButton(
                      onTap: () => Get.back(),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      'Service Details',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 160,
                    decoration: const BoxDecoration(color: Colors.white12),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CarouselSlider(
                              items: [
                                ...service.images.map((element) => Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: element,
                                          placeholderFadeInDuration:
                                              Duration.zero,
                                          fadeOutDuration: Duration.zero,
                                          fadeInDuration: Duration.zero,
                                          placeholder: (context, url) {
                                            return const Center(
                                              child: SizedBox(
                                                height: 20,
                                                width: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                  strokeWidth: 1,
                                                ),
                                              ),
                                            );
                                          },
                                          imageBuilder:
                                              (context, imageProvider) {
                                            return Image(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        ),
                                      ],
                                    )),
                              ],
                              options: CarouselOptions(
                                initialPage: Get.put(ServiceDetailsController())
                                    .currentImage
                                    .value,
                                viewportFraction: 1,
                                onPageChanged: (index, reason) {
                                  Get.put(ServiceDetailsController())
                                      .currentImage
                                      .value = index;
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
                        Positioned(
                            bottom: 15,
                            child: Indicators(
                              length: service.images.length,
                              currentIndex: Get.put(ServiceDetailsController())
                                  .currentImage
                                  .value,
                            ))
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 45,
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            const Text(
                              'Price',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              service.price,
                              style: const TextStyle(color: Colors.white70),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Set Date',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  30,
                                  (index) => Obx(
                                    () => DateContainer(
                                      date: Utils.formatDateDay(DateTime.now()
                                              .add(Duration(days: index)))
                                          .replaceAll('-', '\n'),
                                      onTap: () {
                                        controller.date = Utils.formatDate(
                                            DateTime.now()
                                                .add(Duration(days: index)));
                                        controller.selectedDate.value =
                                            index + 1;
                                      },
                                      isSelected:
                                          controller.selectedDate.value ==
                                              index + 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Set Time',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  24,
                                  (index) => Obx(
                                    () => DateContainer(
                                      date: Utils.formatTime(DateTime.now()
                                              .add(Duration(hours: index)))
                                          .replaceAll(' ', '\n'),
                                      onTap: () {
                                        controller.time = Utils.formatTime(
                                            DateTime.now()
                                                .add(Duration(hours: index)));
                                        controller.selectedTime.value =
                                            index + 1;
                                      },
                                      isSelected:
                                          controller.selectedTime.value ==
                                              index + 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            const Text(
                              'Address',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              Icons.location_on_outlined,
                              color: Colors.white,
                              size: 18,
                            ),
                            const Spacer(),
                            Text(
                              service.location,
                              style: const TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Payment Method',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: [
                            Divider(
                              color: Colors.white70,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Cash Only',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.money,
                                  color: Colors.white,
                                )
                              ],
                            ),
                            Divider(
                              color: Colors.white70,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (service.id != localUser!.token)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Get.to(() => ChatScreen(
                                        user: UserModel(
                                            name: service.owner.name,
                                            profilePicture:
                                                service.owner.profilePicture,
                                            latitude: 0,
                                            myServices: [],
                                            mySpareParts: [],
                                            longitude: 0,
                                            token: service.owner.id,
                                            email: service.owner.contact,
                                            phoneNumber:
                                                service.owner.contact)));
                                  },
                                  child: const Icon(
                                    Icons.chat,
                                    color: Colors.white,
                                  )),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: SizedBox(
                                height: 45,
                                child: AccountButton(
                                  text: 'Book Appointment',
                                  loading: false,
                                  onTap: () {
                                    controller.makeAppointment(service);
                                  },
                                ),
                              ))
                            ],
                          ),
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DateContainer extends StatelessWidget {
  const DateContainer(
      {super.key,
      required this.date,
      required this.onTap,
      required this.isSelected});

  final String date;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: 90,
        width: 100,
        decoration: BoxDecoration(
            color: isSelected ? Colors.pinkAccent : Colors.white12,
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Text(
            date,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
                height: 1.4),
          ),
        ),
      ),
    );
  }
}

import 'package:auto_motive/main.dart';
import 'package:auto_motive/model/appointment_model_mechanic.dart';
import 'package:auto_motive/res/app_color.dart';
import 'package:auto_motive/utils/utils.dart';
import 'package:auto_motive/view%20model/controller/profile_controller.dart';
import 'package:auto_motive/view/common%20widgets/back_button.dart';
import 'package:auto_motive/view/sign%20up/components/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentWithMechanic extends StatelessWidget {
  AppointmentWithMechanic({super.key});

  final controller = Get.put(ProfileController());

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
                      width: 10,
                    ),
                    const Text(
                      'Appointment with Mechanics',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(localUser!.token)
                      .collection('appointmentWithMechanic')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Text(
                          'Loading...',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    } else {
                      List<AppointmentModelMechanic>? list = snapshot.data?.docs
                          .map((e) => AppointmentModelMechanic.fromFirestore(e))
                          .toList();
                      if (list == null || list.isEmpty) {
                        return const Center(
                          child: Text(
                            'No Appointment',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Card(
                                surfaceTintColor: Colors.black,
                                color: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                        color: Colors.white30)),
                                shadowColor: Colors.white,
                                child: Container(
                                  height: 100,
                                  width: MediaQuery.sizeOf(context).width,
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              list[index].service.title,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            // Text('RS '+controller.appointmentWithClients[index].service.price,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.location_on_outlined,
                                                  color: Colors.white,
                                                  size: 18,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  list[index].service.location,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.calendar_month,
                                                  color: Colors.white,
                                                  size: 18,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  '${list[index].date} At ${list[index].time}',
                                                  style: const TextStyle(
                                                      color: Colors.white70),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      // const Icon(
                                      //   Icons.chat,
                                      //   color: Colors.white70,
                                      // ),
                                      // SizedBox(
                                      //   width: 10,
                                      // ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: PopupMenuButton(
                                            color: Colors.white,
                                            icon: const Icon(
                                              Icons.more_vert_rounded,
                                              color: Colors.white,
                                            ),
                                            itemBuilder: (context) {
                                              return [
                                                const PopupMenuItem(
                                                  value: 1,
                                                  child: Text(
                                                    'Mark as complete',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                const PopupMenuItem(
                                                  value: 2,
                                                  child: Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ];
                                            },
                                            onSelected: (value) {
                                              if (value == 1) {
                                                showGeneralDialog(
                                                  context: context,
                                                  pageBuilder: (context,
                                                      animation,
                                                      secondaryAnimation) {
                                                    return AlertDialog(
                                                      surfaceTintColor:
                                                          Colors.white,
                                                      title: const Text(
                                                        'Complete Appointment',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16),
                                                      ),
                                                      content: SizedBox(
                                                        height: 270,
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              width: MediaQuery
                                                                      .sizeOf(
                                                                          context)
                                                                  .width,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  const Text(
                                                                      'Submit Review'),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 100,
                                                                    child:
                                                                        Stack(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            ...List.generate(
                                                                                5,
                                                                                (index) => GestureDetector(
                                                                                    onTap: () => controller.rating.value = index + 1,
                                                                                    child: const Icon(
                                                                                      Icons.star_outline,
                                                                                      color: Colors.grey,
                                                                                      size: 19,
                                                                                    ))),
                                                                          ],
                                                                        ),
                                                                        Obx(() =>
                                                                            Row(
                                                                              children: [
                                                                                ...List.generate(
                                                                                    controller.rating.value,
                                                                                    (index) => GestureDetector(
                                                                                        onTap: () => controller.rating.value = index + 1,
                                                                                        child: const Icon(
                                                                                          Icons.star,
                                                                                          color: Colors.orangeAccent,
                                                                                          size: 19,
                                                                                        ))),
                                                                              ],
                                                                            ))
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            TextFormField(
                                                              maxLines: 4,
                                                              controller:
                                                                  controller
                                                                      .review,
                                                              cursorColor:
                                                                  Colors.black,
                                                              decoration: InputDecoration(
                                                                  hintText:
                                                                      'Enter your review',
                                                                  hintStyle: const TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          13),
                                                                  enabledBorder: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      borderSide: const BorderSide(
                                                                          color:
                                                                              grey)),
                                                                  focusedBorder: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      borderSide:
                                                                          const BorderSide(
                                                                              color: Colors.black))),
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            SizedBox(
                                                              height: 45,
                                                              child:
                                                                  AccountButton(
                                                                text: 'Submit',
                                                                loading: false,
                                                                onTap:
                                                                    () async {
                                                                  Get.back();
                                                                  Utils.showSnackBar(
                                                                      'Review',
                                                                      'Submitting your review',
                                                                      const Icon(
                                                                        Icons
                                                                            .timer_outlined,
                                                                        color: Colors
                                                                            .white,
                                                                      ));

                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'services')
                                                                      .doc(list[
                                                                              index]
                                                                          .id)
                                                                      .update({
                                                                    'ratings':
                                                                        FieldValue
                                                                            .arrayUnion([
                                                                      controller
                                                                          .rating
                                                                          .value
                                                                    ])
                                                                  });

                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'services')
                                                                      .doc(list[
                                                                              index]
                                                                          .id)
                                                                      .update({
                                                                    'reviews':
                                                                        FieldValue
                                                                            .arrayUnion([
                                                                      controller
                                                                          .review
                                                                          .value
                                                                          .text
                                                                          .toString()
                                                                    ])
                                                                  });

                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'users')
                                                                      .doc(localUser!
                                                                          .token)
                                                                      .collection(
                                                                          'appointmentWithMechanic')
                                                                      .doc(list[
                                                                              index]
                                                                          .id)
                                                                      .delete();

                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'users')
                                                                      .doc(localUser!
                                                                          .token)
                                                                      .collection(
                                                                          'appointmentWithClients')
                                                                      .doc(list[
                                                                              index]
                                                                          .id)
                                                                      .delete();

                                                                  Utils.showSnackBar(
                                                                      'Review',
                                                                      'Your review is submitted',
                                                                      const Icon(
                                                                        Icons
                                                                            .timer_outlined,
                                                                        color: Colors
                                                                            .white,
                                                                      ));
                                                                },
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              } else if (value == 2) {
                                                showGeneralDialog(
                                                  context: context,
                                                  pageBuilder: (context,
                                                      animation,
                                                      secondaryAnimation) {
                                                    return AlertDialog(
                                                      surfaceTintColor:
                                                          Colors.white,
                                                      title: const Text(
                                                        'Cancel Appointment',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      content: const Text(
                                                        "Are you sure to cancel this appointment",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () =>
                                                                Get.back(),
                                                            child: const Text(
                                                              'Cancel',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            )),
                                                        TextButton(
                                                            onPressed:
                                                                () async {
                                                              Get.back();
                                                              await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'users')
                                                                  .doc(localUser!
                                                                      .token)
                                                                  .collection(
                                                                      'appointmentWithMechanic')
                                                                  .doc(list[
                                                                          index]
                                                                      .id)
                                                                  .delete();

                                                              await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'users')
                                                                  .doc(list[
                                                                          index]
                                                                      .service
                                                                      .owner
                                                                      .id)
                                                                  .collection(
                                                                      'appointmentWithClients')
                                                                  .doc(list[
                                                                          index]
                                                                      .id)
                                                                  .delete();
                                                              Utils.showSnackBar(
                                                                  'Cancel',
                                                                  'Your appointment is canceled',
                                                                  const Icon(
                                                                    Icons
                                                                        .timer_outlined,
                                                                    color: Colors
                                                                        .white,
                                                                  ));
                                                            },
                                                            child: const Text(
                                                              'Ok',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .pinkAccent),
                                                            )),
                                                      ],
                                                    );
                                                  },
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }
                  },
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

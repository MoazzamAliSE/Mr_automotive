import 'package:auto_motive/main.dart';
import 'package:auto_motive/model/product_order_model.dart';
import 'package:auto_motive/res/app_color.dart';
import 'package:auto_motive/view%20model/controller/profile_controller.dart';
import 'package:auto_motive/view/common%20widgets/back_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/utils.dart';
import '../sign up/components/button.dart';

class MyOrders extends StatelessWidget {
  MyOrders({super.key});
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SafeArea(
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
                      width: 20,
                    ),
                    const Text(
                      'My Orders',
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
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(localUser!.token)
                        .collection('myOrders')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      } else {
                        List<ProductOrderModel>? orders = snapshot.data?.docs
                            .map((e) => ProductOrderModel.fromFirestore(e))
                            .toList();

                        if (orders == null || orders.isEmpty) {
                          return const Center(
                            child: Text(
                              'No orders right now',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: orders.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: 160,
                                    width: MediaQuery.sizeOf(context).width,
                                    decoration: const BoxDecoration(
                                      color: Colors.white12,
                                    ),
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: SizedBox(
                                            width: 160,
                                            height: 160,
                                            child: CarouselSlider(
                                                items: [
                                                  ...orders[index]
                                                      .product
                                                      .images
                                                      .map((element) => Stack(
                                                            fit:
                                                                StackFit.expand,
                                                            children: [
                                                              CachedNetworkImage(
                                                                imageUrl:
                                                                    element,
                                                                imageBuilder:
                                                                    (context,
                                                                        imageProvider) {
                                                                  return Image(
                                                                    image:
                                                                        imageProvider,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  );
                                                                },
                                                              ),
                                                            ],
                                                          )),
                                                ],
                                                options: CarouselOptions(
                                                  initialPage: 0,
                                                  viewportFraction: 1,
                                                  onPageChanged:
                                                      (index, reason) {},
                                                  enableInfiniteScroll: false,
                                                  reverse: false,
                                                  autoPlayInterval:
                                                      const Duration(
                                                          seconds: 3),
                                                  autoPlayAnimationDuration:
                                                      const Duration(
                                                          milliseconds: 800),
                                                  autoPlayCurve:
                                                      Curves.fastOutSlowIn,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                )),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              orders[index].product.title,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  'Quantity',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  orders[index].quantity,
                                                  style: const TextStyle(
                                                      color: Colors.white70),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  'Price',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  orders[index].price,
                                                  style: const TextStyle(
                                                      color: Colors.white70),
                                                ),
                                              ],
                                            ),
                                            // Row(
                                            //   children: [
                                            //     Text('Delivery',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),),
                                            //     Spacer(),
                                            //     Text(orders[index].product.delivery,style: TextStyle(color: Colors.white70),),
                                            //   ],
                                            // ),
                                            // Row(
                                            //   crossAxisAlignment: CrossAxisAlignment.start,
                                            //   children: [
                                            //     Text('Location',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),),
                                            //     Spacer(),
                                            //     Expanded(child: Text(orders[index].product.location,style: TextStyle(color: Colors.white70),maxLines: 2,)),
                                            //   ],
                                            // ),
                                            // Row(
                                            //   children: [
                                            //     Icon(Icons.chat,color: Colors.white,)
                                            //   ],
                                            // )
                                          ],
                                        )),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: PopupMenuButton(
                                              color: Colors.white,
                                              padding: EdgeInsets.zero,
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
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                                                                      width:
                                                                          100,
                                                                      child:
                                                                          Stack(
                                                                        alignment:
                                                                            Alignment.center,
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
                                                                    Colors
                                                                        .black,
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
                                                                            const BorderSide(color: Colors.black))),
                                                              ),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              SizedBox(
                                                                height: 45,
                                                                child:
                                                                    AccountButton(
                                                                  text:
                                                                      'Submit',
                                                                  loading:
                                                                      false,
                                                                  onTap:
                                                                      () async {
                                                                    Get.back();
                                                                    Utils.showSnackBar(
                                                                        'Review',
                                                                        'Submitting your review',
                                                                        const Icon(
                                                                          Icons
                                                                              .timer_outlined,
                                                                          color:
                                                                              Colors.white,
                                                                        ));

                                                                    await FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'products')
                                                                        .doc(orders[index]
                                                                            .productId)
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
                                                                            'products')
                                                                        .doc(orders[index]
                                                                            .productId)
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

                                                                    controller
                                                                        .rating
                                                                        .value = 5;
                                                                    controller
                                                                        .review
                                                                        .clear();

                                                                    await FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'users')
                                                                        .doc(localUser!
                                                                            .token)
                                                                        .collection(
                                                                            'myOrders')
                                                                        .doc(orders[index]
                                                                            .productId)
                                                                        .delete();

                                                                    await FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'users')
                                                                        .doc(orders[index]
                                                                            .product
                                                                            .owner
                                                                            .id)
                                                                        .collection(
                                                                            'receivedOrders')
                                                                        .doc(orders[index]
                                                                            .productId)
                                                                        .delete();

                                                                    Utils.showSnackBar(
                                                                        'Review',
                                                                        'Your review is submitted',
                                                                        const Icon(
                                                                          Icons
                                                                              .timer_outlined,
                                                                          color:
                                                                              Colors.white,
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
                                                          'Cancel Order',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        content: const Text(
                                                          "Are you sure to cancel this Order",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
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
                                                                        'myOrders')
                                                                    .doc(orders[
                                                                            index]
                                                                        .productId)
                                                                    .delete();

                                                                await FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'users')
                                                                    .doc(localUser!
                                                                        .token)
                                                                    .collection(
                                                                        'receivedOrders')
                                                                    .doc(orders[
                                                                            index]
                                                                        .productId)
                                                                    .delete();
                                                                Utils.showSnackBar(
                                                                    'Cancel',
                                                                    'Your Order is canceled',
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
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

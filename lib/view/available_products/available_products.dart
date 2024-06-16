import 'package:auto_motive/model/product_model.dart';
import 'package:auto_motive/view%20model/controller/available_services_controller.dart';
import 'package:auto_motive/view%20model/controller/availalble_product_controller.dart';
import 'package:auto_motive/view/available_products/components/product_holder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../add_services/service/components/input_field.dart';
import '../common widgets/back_button.dart';

class AvailableProducts extends StatelessWidget {
  AvailableProducts({super.key});

  final controller = Get.put(AvailableProductController());

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
                ])
        ),
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
                      width: 20,
                    ),
                    Expanded(
                        child: InputField(
                            hint: 'Search',
                            controller: TextEditingController(),
                            onChanged: (p0) {
                              controller.search.value = p0;
                            },
                            icon: const Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            title: '')),

                    const SizedBox(
                      width: 20,
                    ),
                    const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    )
                    // Text('Services',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return Container(
                          height: 200,
                          width: MediaQuery.sizeOf(context).width,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  topLeft: Radius.circular(30))),
                          padding:
                              const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Filters',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Obx(
                                      () => TextButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                          controller.filter.value ==
                                                  Filters.lowToHigh
                                              ? Colors.pinkAccent
                                              : Colors.transparent,
                                        )),
                                        onPressed: () {
                                          controller.changeFilter(
                                              f: Filters.lowToHigh);
                                        },
                                        child: Text(
                                          'Price Low to High',
                                          style: TextStyle(
                                            color: controller.filter.value ==
                                                    Filters.lowToHigh
                                                ? Colors.white
                                                : null,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Obx(
                                      () => TextButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                            controller.filter.value ==
                                                    Filters.highToLow
                                                ? Colors.pinkAccent
                                                : Colors.transparent,
                                          )),
                                          onPressed: () {
                                            controller.changeFilter(
                                                f: Filters.highToLow);
                                          },
                                          child: Text(
                                            'Price High to Low',
                                            style: TextStyle(
                                              color: controller.filter.value ==
                                                      Filters.highToLow
                                                  ? Colors.white
                                                  : null,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              Center(
                                child: TextButton(
                                    onPressed: () {
                                      controller.changeFilter(f: Filters.all);
                                    },
                                    child: const Text('Clear Filter')),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: const Row(
                    children: [
                      Text(
                        'Filters',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Icon(
                        Icons.filter_list,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Obx(() => StreamBuilder(
                        stream: controller.filter.value == Filters.all
                            ? FirebaseFirestore.instance
                                .collection('products')
                                .snapshots()
                            : controller.filter.value == Filters.lowToHigh
                                ? FirebaseFirestore.instance
                                    .collection('products')
                                    .orderBy('price', descending: true)
                                    .snapshots()
                                : FirebaseFirestore.instance
                                    .collection('products')
                                    .orderBy('price', descending: false)
                                    .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    )),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Loading...',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            );
                          } else {
                            List<ProductModel>? listOfData = snapshot.data?.docs
                                .map((e) => ProductModel.fromFirestore(e))
                                .toList();
                            if (listOfData==null  || listOfData.isEmpty){
                              return const Center(
                                child: Text(
                                  'No Product available',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            }else{
                             return Obx(() {
                                if (controller.search.isEmpty) {
                                  return GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 0.7),
                                    itemCount: listOfData.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20, left: 10, right: 10),
                                          child: ProductHolder(
                                              product: listOfData[index]));
                                    },
                                  );
                                } else {
                                  return Wrap(
                                    spacing: 20,
                                    children: [
                                      ...listOfData.map((e) {
                                        if (e.title.toLowerCase().contains(
                                            controller.search.value
                                                .toLowerCase())) {
                                          return Padding(
                                            padding: const EdgeInsets.only(top: 20),
                                            child: SizedBox(
                                              height: 220,
                                              width: 140,
                                              child: ProductHolder(product: e),
                                            ),
                                          );
                                        }
                                        return const SizedBox.shrink();
                                      })
                                    ],
                                  );
                                }
                              });
                            }


                          }
                        },
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

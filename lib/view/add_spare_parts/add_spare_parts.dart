import 'package:auto_motive/view%20model/controller/add_spare_part_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/app_color.dart';
import '../add_services/service/components/enum_type.dart';
import '../add_services/service/components/input_field.dart';
import '../add_services/service/components/open_map.dart';
import '../add_services/service/components/services_images.dart';
import '../common widgets/back_button.dart';
import '../sign up/components/button.dart';

class AddSparePart extends StatelessWidget {
  AddSparePart({super.key});

  final controller = Get.put(AddSparePartController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: darkBackgroundColor,
      body: SafeArea(
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
                    'Sell Spare Parts',
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
              ServiceImages(
                controller: controller,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                child: Text(
                  'Add Details',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                  child: Container(
                      width: size.width,
                      decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SingleChildScrollView(
                        child: Form(
                          key: controller.formKey,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 22,
                                  ),
                                  const CircleAvatar(
                                    radius: 6,
                                    backgroundColor: Colors.pinkAccent,
                                  ),
                                  Container(
                                    height: 35,
                                    width: 3,
                                    decoration: const BoxDecoration(
                                        color: Colors.pinkAccent),
                                  ),
                                  const CircleAvatar(
                                    radius: 6,
                                    backgroundColor: Colors.pinkAccent,
                                  ),
                                  Container(
                                    height: 210,
                                    width: 3,
                                    decoration: const BoxDecoration(
                                        color: Colors.pinkAccent),
                                  ),
                                  const CircleAvatar(
                                    radius: 6,
                                    backgroundColor: Colors.pinkAccent,
                                  ),
                                  Container(
                                    height: 530,
                                    width: 3,
                                    decoration: const BoxDecoration(
                                        color: Colors.pinkAccent),
                                  ),
                                  const CircleAvatar(
                                    radius: 6,
                                    backgroundColor: Colors.pinkAccent,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                      onTap: () => Get.to(() => const OpenMap(
                                          serviceType: MapScreenType.product)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.location_searching,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Obx(
                                            () => Text(
                                              controller
                                                      .selectedLocation.isEmpty
                                                  ? 'Select your location'
                                                  : controller
                                                      .selectedLocation.value,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      'Contact Details',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    InputField(
                                      readOnly: true,
                                      title: 'Name',
                                      hint: 'Enter your name',
                                      controller: controller.name,
                                      icon: const Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                    ),
                                    InputField(
                                      readOnly: true,
                                      title: 'Number',
                                      hint: 'Ex. (+923123456789)',
                                      controller: controller.number,
                                      type: TextInputType.phone,
                                      icon: const Icon(
                                        Icons.phone_iphone_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      'Service Details',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Text(
                                          'Title',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          height: 45,
                                          child: DropdownButtonFormField(
                                            decoration: InputDecoration(
                                                hintText:
                                                    'Select title of product',
                                                hintStyle: const TextStyle(
                                                    color: Colors.white12,
                                                    fontSize: 12),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .white)),
                                                contentPadding: const EdgeInsets
                                                    .symmetric(horizontal: 20),
                                                hoverColor: Colors.white,
                                                prefixIcon: const Icon(
                                                  Icons.title,
                                                  color: Colors.white,
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Colors.white12,
                                                        ))),
                                            isExpanded: true,
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                            padding: EdgeInsets.zero,
                                            dropdownColor: Colors.black,
                                            items: const [
                                              DropdownMenuItem(
                                                value:
                                                    'Engine and Transmission Parts',
                                                child: Text(
                                                  'Engine and Transmission Parts',
                                                ),
                                              ),
                                              DropdownMenuItem(
                                                value:
                                                    'Suspension and Steering Parts',
                                                child: Text(
                                                  'Suspension and Steering Parts',
                                                ),
                                              ),
                                              DropdownMenuItem(
                                                value: 'Braking Components',
                                                child: Text(
                                                  'Braking Components',
                                                ),
                                              ),
                                              DropdownMenuItem(
                                                value:
                                                    'Electrical and Electronics Parts',
                                                child: Text(
                                                  'Electrical and Electronics Parts',
                                                ),
                                              ),
                                              DropdownMenuItem(
                                                value: 'Exhaust System Parts',
                                                child: Text(
                                                  'Exhaust System Parts',
                                                ),
                                              ),
                                              DropdownMenuItem(
                                                value:
                                                    'Cooling and Heating Components',
                                                child: Text(
                                                  'Cooling and Heating Components',
                                                ),
                                              ),
                                              DropdownMenuItem(
                                                value: 'Body and Chassis Parts',
                                                child: Text(
                                                  'Body and Chassis Parts',
                                                ),
                                              ),
                                              DropdownMenuItem(
                                                value: 'Interior Components',
                                                child: Text(
                                                  'Interior Components',
                                                ),
                                              ),
                                              DropdownMenuItem(
                                                value: 'Lighting Components',
                                                child: Text(
                                                  'Lighting Components',
                                                ),
                                              ),
                                              DropdownMenuItem(
                                                value: 'Wheels and Tires',
                                                child: Text(
                                                  'Wheels and Tires',
                                                ),
                                              ),
                                            ],
                                            onChanged: (value) {
                                              controller.title.text =
                                                  value.toString();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    // InputField(title: 'Location',
                                    //   hint: 'Your Address',
                                    //   controller: controller.location,icon: Icon(Icons.location_on_rounded,color: Colors.white,),),
                                    // InputField(
                                    //   title: 'Skill',
                                    //   hint: 'Write your experties',
                                    //   controller: controller.skill,
                                    //   icon: const Icon(
                                    //     Icons.workspace_premium_rounded,
                                    //     color: Colors.white,
                                    //   ),
                                    // ),
                                    InputField(
                                      title: 'Delivery',
                                      hint: 'Delivery in days',
                                      controller: controller.delivery,
                                      type: TextInputType.number,
                                      icon: const Icon(
                                        Icons.person_add_alt_1,
                                        color: Colors.white,
                                      ),
                                    ),
                                    InputField(
                                      title: 'Warranty',
                                      hint:
                                          'Enter warranty of product in years',
                                      type: TextInputType.number,
                                      controller: controller.warranty,
                                      icon: const Icon(
                                        Icons.workspace_premium_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                    InputField(
                                      title: 'Price',
                                      type: TextInputType.number,
                                      hint: 'Enter you price',
                                      controller: controller.price,
                                      icon: const Icon(
                                        Icons.attach_money_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                    InputField(
                                      title: 'Description',
                                      hint: 'Description of product',
                                      controller: controller.description,
                                      icon: const Icon(
                                        Icons.short_text_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Center(
                                      child: SizedBox(
                                          height: 45,
                                          width: 180,
                                          child: AccountButton(
                                            text: 'Add Product',
                                            loading: false,
                                            onTap: () {
                                              controller.uploadProduct();
                                            },
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))),
              const SizedBox(
                height: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

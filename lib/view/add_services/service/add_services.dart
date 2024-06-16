import 'package:auto_motive/res/app_color.dart';
import 'package:auto_motive/view%20model/controller/add_services_controller.dart';
import 'package:auto_motive/view/add_services/service/components/input_field.dart';
import 'package:auto_motive/view/add_services/service/components/open_map.dart';
import 'package:auto_motive/view/add_services/service/components/services_images.dart';
import 'package:auto_motive/view/common%20widgets/back_button.dart';
import 'package:auto_motive/view/sign%20up/components/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/enum_type.dart';

class AddServices extends StatelessWidget {
  AddServices({super.key});
  final controller = Get.put(AddServiceController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: darkBackgroundColor,
      body: Container(
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //         begin: Alignment.topCenter,
        //         end: Alignment.bottomCenter,
        //         colors: [
        //           Colors.black,
        //           Colors.black,
        //           Colors.black54,
        //         ])
        // ),
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
                      'Add Services',
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      InkWell(
                                        onTap: () => Get.to(() => const OpenMap(
                                              serviceType:
                                                  MapScreenType.service,
                                            )),
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
                                                controller.selectedLocation
                                                        .isEmpty
                                                    ? 'Select your location'
                                                    : controller
                                                        .selectedLocation.value,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                        type: TextInputType.phone,
                                        controller: controller.number,
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
                                                      'Select title of services',
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
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 20),
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
                                                            color:
                                                                Colors.white12,
                                                          ))),
                                              isExpanded: true,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                              padding: EdgeInsets.zero,
                                              dropdownColor: Colors.black,
                                              items: const [
                                                DropdownMenuItem(
                                                  value: 'Oil Change',
                                                  child: Text(
                                                    'Oil Change',
                                                  ),
                                                ),
                                                DropdownMenuItem(
                                                  value:
                                                      'Brake Service and Repair',
                                                  child: Text(
                                                      'Brake Service and Repair'),
                                                ),
                                                DropdownMenuItem(
                                                  value:
                                                      'Engine Diagnostic and Repair',
                                                  child: Text(
                                                      'Engine Diagnostic and Repair'),
                                                ),
                                                DropdownMenuItem(
                                                  value:
                                                      'Transmission Service and Repair',
                                                  child: Text(
                                                      'Transmission Service and Repair'),
                                                ),
                                                DropdownMenuItem(
                                                  value:
                                                      'Tire Rotation and Balancing',
                                                  child: Text(
                                                      'Tire Rotation and Balancing'),
                                                ),
                                                DropdownMenuItem(
                                                  value:
                                                      'Battery Replacement and Electrical Repair',
                                                  child: Text(
                                                      'Battery Replacement and Electrical Repair'),
                                                ),
                                                DropdownMenuItem(
                                                  value:
                                                      'AC and Heating Repair',
                                                  child: Text(
                                                      'AC and Heating Repair'),
                                                ),
                                                DropdownMenuItem(
                                                  value:
                                                      'Exhaust System Repair',
                                                  child: Text(
                                                      'Exhaust System Repair'),
                                                ),
                                                DropdownMenuItem(
                                                  value: 'Suspension Work',
                                                  child:
                                                      Text('Suspension Work'),
                                                ),
                                                DropdownMenuItem(
                                                  value:
                                                      'Preventive Maintenance',
                                                  child: Text(
                                                      'Preventive Maintenance'),
                                                ),
                                                DropdownMenuItem(
                                                  value: 'Tune-ups',
                                                  child: Text('Tune-ups'),
                                                ),
                                                DropdownMenuItem(
                                                  value:
                                                      'Timing Belt Replacement',
                                                  child: Text(
                                                      'Timing Belt Replacement'),
                                                ),
                                                DropdownMenuItem(
                                                  value: 'Clutch Repairs',
                                                  child: Text('Clutch Repairs'),
                                                ),
                                                DropdownMenuItem(
                                                  value:
                                                      'Fluid Replacement Services (coolant, brake fluid, transmission fluid, etc.)',
                                                  child: Text(
                                                      'Fluid Replacement Services (coolant, brake fluid, transmission fluid, etc.)'),
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
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const Text(
                                            'Skills',
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
                                                  hintText: 'Select your skill',
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
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 20),
                                                  hoverColor: Colors.white,
                                                  prefixIcon: const Icon(
                                                    Icons
                                                        .workspace_premium_rounded,
                                                    color: Colors.white,
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide:
                                                              const BorderSide(
                                                            color:
                                                                Colors.white12,
                                                          ))),
                                              isExpanded: true,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                              padding: EdgeInsets.zero,
                                              dropdownColor: Colors.black,
                                              items: const [
                                                DropdownMenuItem(
                                                  value: 'Engine Expert',
                                                  child: Text(
                                                    'Engine Expert',
                                                  ),
                                                ),
                                                DropdownMenuItem(
                                                  value: 'Brakes Expert',
                                                  child: Text('Brakes Expert'),
                                                ),
                                                DropdownMenuItem(
                                                  value:
                                                      'Electrical system Expert',
                                                  child: Text(
                                                      'Electrical system Expert'),
                                                ),
                                                DropdownMenuItem(
                                                  value: 'Body repair exepert',
                                                  child: Text(
                                                      'Body repair exepert'),
                                                ),
                                                DropdownMenuItem(
                                                  value:
                                                      'Maintenance and Inspection',
                                                  child: Text(
                                                      'Maintenance and Inspection'),
                                                ),
                                              ],
                                              onChanged: (value) {
                                                controller.skill.text =
                                                    value.toString();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      InputField(
                                        title: 'Experience',
                                        hint: 'Your Experience in years',
                                        type: TextInputType.number,
                                        controller: controller.experience,
                                        icon: const Icon(
                                          Icons.person_add_alt_1,
                                          color: Colors.white,
                                        ),
                                      ),
                                      InputField(
                                        title: 'Price',
                                        hint: 'Enter you price',
                                        controller: controller.price,
                                        type: TextInputType.number,
                                        icon: const Icon(
                                          Icons.attach_money_rounded,
                                          color: Colors.white,
                                        ),
                                      ),
                                      InputField(
                                        title: 'Description',
                                        hint: 'Description of job',
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
                                              text: 'Add Service',
                                              loading: false,
                                              onTap: () {
                                                controller.uploadServices();
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
      ),
    );
  }
}

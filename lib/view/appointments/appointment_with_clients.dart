import 'package:auto_motive/model/appointment_models_clients.dart';
import 'package:auto_motive/view%20model/controller/profile_controller.dart';
import 'package:auto_motive/view/common%20widgets/back_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../../utils/utils.dart';

class AppointmentWithClients extends StatelessWidget {
   AppointmentWithClients({super.key});
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
                ])
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20,),
                Row(
                  children: [
                    CustomBackButton(
                      onTap: () => Get.back(),
                    ),
                    const SizedBox(width: 20,),
                    const Text('Appointment with Clients',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)
                  ],
                ),
                const SizedBox(height: 20,),
                Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('users').doc(localUser!.token).collection('appointmentWithClients').snapshots(),
                      builder: (context, snapshot) {


                        if(snapshot.connectionState==ConnectionState.waiting){
                          return const Center(child: Text('Loading...',style: TextStyle(color: Colors.white),),);
                        }
                        else{
                          List<AppointmentModel>? list=snapshot.data?.docs.map((e) => AppointmentModel.fromFirestore(e)).toList();
                          if(list==null || list.isEmpty){
                            return const Center(
                              child: Text(
                                'No Appointment',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }else{
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
                                        side: const BorderSide(color: Colors.white30)),
                                    shadowColor: Colors.white,
                                    child: Container(
                                      height: 100,
                                      width: MediaQuery.sizeOf(context).width,
                                      padding:
                                      const EdgeInsets.only(left: 30, right: 10),
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
                                                  list[index]
                                                      .service
                                                      .title,
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
                                                      list[
                                                      index]
                                                          .service
                                                          .location,
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
                                                      '${list[
                                                      index]
                                                          .date} At ${list[index].time}',
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
                                              padding: const EdgeInsets.only(top: 10),
                                              child: PopupMenuButton(
                                                color: Colors.white,
                                                icon: const Icon(
                                                  Icons.more_vert_rounded,
                                                  color: Colors.white,
                                                ),
                                                itemBuilder: (context) {
                                                  return [
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
                                                   if(value==2){
                                                    showGeneralDialog(context: context, pageBuilder: (context, animation, secondaryAnimation) {
                                                      return AlertDialog(
                                                        surfaceTintColor: Colors.white,
                                                        title: const Text('Cancel Appointment',style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold,
                                                        ),),
                                                        content: const Text("Are you sure to cancel this appointment",style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14
                                                        ),),
                                                        actions: [
                                                          TextButton(onPressed: () => Get.back(), child: const Text('Cancel',style: TextStyle(color: Colors.black),)),
                                                          TextButton(onPressed: () async {
                                                            Get.back();
                                                            await FirebaseFirestore.instance.collection('users').doc(localUser!.token).collection('appointmentWithClients').
                                                            doc(list[index].id).delete();

                                                            await FirebaseFirestore.instance.collection('users').doc(list[index].client.id).collection('appointmentWithMechanic').
                                                            doc(list[index].id).delete();
                                                            Utils.showSnackBar(
                                                                'Cancel',
                                                                'Your appointment is canceled',
                                                                const Icon(
                                                                  Icons
                                                                      .timer_outlined,
                                                                  color: Colors
                                                                      .white,
                                                                ));
                                                          }, child: const Text('Ok',style: TextStyle(color: Colors.pinkAccent),)),
                                                        ],
                                                      );
                                                    },);
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
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

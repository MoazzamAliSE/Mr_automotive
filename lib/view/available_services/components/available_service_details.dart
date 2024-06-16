import 'package:auto_motive/main.dart';
import 'package:auto_motive/model/service_model.dart';
import 'package:auto_motive/model/user_model.dart';
import 'package:auto_motive/res/app_color.dart';
import 'package:auto_motive/view%20model/controller/service_detail_controller.dart';
import 'package:auto_motive/view/add_services/service/components/indicators.dart';
import 'package:auto_motive/view/book_appointment/book_appointment.dart';
import 'package:auto_motive/view/chat/chat_screen.dart';
import 'package:auto_motive/view/common%20widgets/back_button.dart';
import 'package:auto_motive/view/sign%20up/components/button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AvailableServicesDetails extends StatelessWidget {
   AvailableServicesDetails({super.key, required this.service});
  final ServiceModel service;
  final controller=Get.put(ServiceDetailsController());
  @override
  Widget build(BuildContext context) {
    int add = 0;
    for (var rate in service.ratings) {
      add = add + (int.parse(rate.toString()));
    }
    int rating = 0;
    try {
      rating = add ~/ service.ratings.length;
    } catch (_) {}
    return Scaffold(
      backgroundColor: darkBackgroundColor,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                Row(
                  children: [
                    CustomBackButton(onTap: () => Get.back(),
                    ),
                    const SizedBox(width: 20,),
                    const Text('Service Details',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                  ],
                ),
                const SizedBox(height: 20,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 160,
                    decoration: const BoxDecoration(
                      color: Colors.white12
                    ),
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
                              CachedNetworkImage(imageUrl: element,
                                placeholderFadeInDuration: Duration.zero,
                                fadeOutDuration: Duration.zero,
                                fadeInDuration: Duration.zero,
                                placeholder: (context, url) {
                                  return const Center(
                                    child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 1,
                                      ),
                                    ),
                                  );
                                },

                                imageBuilder: (context, imageProvider) {
                                return Image(image: imageProvider,fit: BoxFit.cover,);
                              },
                              ),
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
                        )),),
                        Positioned(
                            bottom: 15,
                            child: Indicators(
                              length: service.images.length,
                              currentIndex: controller.currentImage.value,
                            ))
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Expanded(child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20,),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10,),
                        Text(service.name,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                        Text(service.description,style: const TextStyle(color: Colors.white70),),
                        Padding(padding:
                        const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Divider(color: Colors.white70,),
                              ),
                    
                             Row(
                               children: [
                                 const Text('Skill',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                 const SizedBox(width: 10,),
                                 const Spacer(),
                                 Text(service.skill,style: const TextStyle(color: Colors.white70,),maxLines: 2,),
                               ],
                             ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Divider(color: Colors.white70,),
                              ),
                              Row(
                                children: [
                                  const Text('Experience',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                  const SizedBox(width: 10,),
                                  const Spacer(),
                                  Text('${service.experience} experience',style: const TextStyle(color: Colors.white70,),maxLines: 2,),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Divider(color: Colors.white70,),
                              ),
                              Row(
                                children: [
                                  const Text('Location',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                  const SizedBox(width: 10,),
                                  const Spacer(),
                                  Text(service.location,style: const TextStyle(color: Colors.white70,),maxLines: 2,),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Divider(color: Colors.white70,),
                              ),
                              Row(
                                children: [
                                  const Text('Contact No',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                  const SizedBox(width: 10,),
                                  const Spacer(),
                                  Text(service.number,style: const TextStyle(color: Colors.white70,),maxLines: 2,),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Divider(color: Colors.white70,),
                              ),
                              Row(
                                children: [
                                  const Text('Ratings',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                  const SizedBox(width: 10,),
                                  const Spacer(),
                                  Stack(
                                    children: [
                                      Row(
                                        children: [
                                          ...List.generate(
                                              5,
                                                  (index) => const Icon(
                                                Icons
                                                    .star_border_purple500_outlined,
                                                color: Colors
                                                    .white30,
                                              )),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          ...List.generate(
                                              rating,
                                                  (index) => const Icon(
                                                Icons.star,
                                                color: Colors
                                                    .orangeAccent,
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Divider(color: Colors.white70,),
                              ),
                              const Row(
                                children: [
                                  Text('Reviews',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                  SizedBox(width: 10,),
                                  Spacer(),
                                  Text('See All',style: TextStyle(color: Colors.white70,),maxLines: 2,),
                                ],
                              ),
                              const Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                              Text(service.reviews.isEmpty ? '' : service.reviews[service.reviews.length-1],style: const TextStyle(color: Colors.white70),)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )),
                const SizedBox(height: 20,),
              if(service.owner.id!=localUser!.token)  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(()=>ChatScreen(user: UserModel(
                              name: service.owner.name,
                              profilePicture: service.owner.profilePicture,
                              latitude: 0,
                              myServices: [],
                              mySpareParts: [],
                              longitude: 0,
                              token: service.owner.id,
                              email: service.owner.contact,
                              phoneNumber: service.owner.contact)));
                        },
                          child: const Icon(Icons.chat,color: Colors.white,)),
                      const SizedBox(width: 20,),
                      Expanded(child: SizedBox(
                        height: 45,
                        child: AccountButton(text: 'Book Appointment', loading: false, onTap: () {
                          Get.to(()=>BookAppointment(service: service))
;                        },),
                      ))
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                
              ],
            )),
      ),
    );
  }
}

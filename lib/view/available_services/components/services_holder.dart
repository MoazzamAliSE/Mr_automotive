import 'package:auto_motive/model/service_model.dart';
import 'package:auto_motive/view%20model/controller/fav_controller.dart';
import 'package:auto_motive/view/available_services/components/available_service_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../main.dart';

class ServicesHolder extends StatelessWidget {
   ServicesHolder({super.key, required this.service,});
  final ServiceModel service;
  final controller=Get.put(FavController());
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white12,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: () => Get.to(()=>AvailableServicesDetails(service: service,)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Column(
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: service.images[0],
                  fit: BoxFit.cover,
                  placeholderFadeInDuration: Duration.zero,
                  fadeOutDuration: Duration.zero,
                  fadeInDuration: Duration.zero,
                  placeholder: (context, url) {
                    return const SizedBox(
                      height: 100,
                      child: Center(
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 1,
                          ),
                        ),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Can\'t load pictures'
                        ),
                      ),
                    );
                  },
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10)),
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover),
                      ),
                      child: service.owner.id==localUser!.token?
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: 20,
                          width: 50,
                          decoration: const BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)
                              )
                          ),
                          alignment: Alignment.center,
                          child: const Text('My Post',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 10),),
                        ),
                      ):null,
                    );
                  },
                ),
              ),
              Container(
                color: Colors.black,
                child: Container(
                  color: Colors.white12,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          service.title,
                          maxLines: 2,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              overflow:
                              TextOverflow.ellipsis),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 5),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
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
                                                size: 17,
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
                                                size: 17,
          
                                          )),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(
                                          '${service
                                              .experience} experience',
                                          style: const TextStyle(
                                            color: Colors
                                                .white70,
                                            fontSize: 12,
                                            overflow:
                                            TextOverflow
                                                .ellipsis,
                                          ),
                                        ),
                                        Text(
                                          service
                                              .skill,
                                          maxLines: 2,
                                          style: const TextStyle(
                                            color: Colors
                                                .white70,
                                            fontSize: 12,
                                            overflow:
                                            TextOverflow
                                                .ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
          
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller
                                          .addToFavouriteServices(
                                          id: service
                                              .id,
                                      service: service
                                      );
                                    },
                                    child: Obx(
                                          () => Icon(
                                        controller
                                            .favouriteServices
                                            .contains(
                                            service
                                                .id)
                                            ? Icons.favorite
                                            : Icons
                                            .favorite_border,
                                        color: controller
                                            .favouriteServices
                                            .contains(
                                            service
                                                .id)
                                            ? Colors.red
                                            : Colors.grey,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 5),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              'Rs ${service.price}',
                              style: const TextStyle(
                                color: Colors
                                    .white70,
                                fontSize: 12,
                                overflow:
                                TextOverflow
                                    .ellipsis,
                              ),
                            ),
                          ),
                        ),
          
                        const SizedBox(height: 10)
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

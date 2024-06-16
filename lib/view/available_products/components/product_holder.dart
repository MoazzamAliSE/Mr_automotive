import 'package:auto_motive/main.dart';
import 'package:auto_motive/model/product_model.dart';
import 'package:auto_motive/view%20model/controller/add_to_cart_controller.dart';
import 'package:auto_motive/view/available_products/components/available_product_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../view model/controller/fav_controller.dart';

class ProductHolder extends StatelessWidget {
   ProductHolder({super.key, required this.product});
   final ProductModel product;
  final controller=Get.put(FavController());
  final cartController=Get.put(AddToCartController());
  @override
  Widget build(BuildContext context) {
    int add = 0;
    for (var rate in product.ratings) {
      add = add + (int.parse(rate.toString()));
    }
    int rating = 0;
    try {
      rating = add ~/ product.ratings.length;
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
        // onTap: () => Get.to(()=>AvailableServicesDetails(service: service,)),
        onTap: () => Get.to(()=>AvailableProductDetails(service: product)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: product.images[0],
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
                    child:
                    product.owner.id==localUser!.token?
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
            Padding(
              padding: const EdgeInsets.only(
              left: 10,right: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          product.title,
                          maxLines: 2,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              overflow:
                              TextOverflow.ellipsis),
                        ),
                        const SizedBox(height: 5,),
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

                        // SizedBox(height: 5,),
                        Text(
                          '${product
                              .warranty} Years Warranty',
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
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller
                              .addToFavouriteProducts(
                              id: product
                                  .id,
                              model: product
                          );
                        },
                        child: Obx(
                              () => Icon(
                            controller
                                .favouriteSpareParts
                                .contains(
                                product
                                    .id)
                                ? Icons.favorite
                                : Icons
                                .favorite_border,
                            color: controller
                                .favouriteSpareParts
                                .contains(
                                product
                                    .id)
                                ? Colors.red
                                : Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5,),
                      product.owner.id!=localUser!.token?   GestureDetector(
                        onTap: () {
                          cartController
                              .addToCart(
                              id: product
                                  .id,
                              service: product
                          );
                        },
                        child: Obx(
                              () => Icon(
                            cartController
                                .cart
                                .contains(
                                product
                                    .id)
                                ? Icons.shopping_cart
                                : Icons.add_shopping_cart_rounded,
                            color: cartController
                                .cart
                                .contains(
                                product
                                    .id)
                                ? Colors.orangeAccent
                                : Colors.grey,
                          ),
                        ),
                      ):const SizedBox(),
                    ],
                  )
                ],
              ),
            ),
            Align(alignment: Alignment.topRight,
              child:  Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Text(
                  'RS ${product
                      .price}'
                  ,
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
    );
  }
}

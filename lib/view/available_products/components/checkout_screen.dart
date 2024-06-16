import 'package:auto_motive/model/product_model.dart';
import 'package:auto_motive/res/app_color.dart';
import 'package:auto_motive/view%20model/controller/order_controller.dart';
import 'package:auto_motive/view/common%20widgets/back_button.dart';
import 'package:auto_motive/view/sign%20up/components/button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key, required this.product});
  final ProductModel product;

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  int price=0;
  int productPrice=0;
  int quantity=1;
  @override
  void initState() {
    super.initState();
    try{
      int p=int.parse(widget.product.price.replaceAll(',', ''));
      price=p;
      productPrice=p;
    }catch(_){

    }
    setState(() {

    });
  }

  increaseQuantity(){
    if(quantity<10){
      quantity++;
      price=price+productPrice;
      setState(() {

      });
    }
  }

  decreaseQuantity(){
    if(quantity>1){
      quantity--;
      price=price-productPrice;
      setState(() {

      });
    }
  }


  @override
  Widget build(BuildContext context) {
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
                  const Text('Checkout',style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),)
                ],
              ),
              const SizedBox(height: 20,),
              Container(
                height: 160,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                        width: 160,
                        height: 160,
                        child: CarouselSlider(
                            items: [
                              ...widget.product.images.map((element) => Stack(
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
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.product.title,style: const TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                            const SizedBox(height: 10,),
                            Text(widget.product.description,style: const TextStyle(color: Colors.white70),)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Container(height: 50,
              width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(10)
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const Text('Price',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                    const Spacer(),
                    Row(
                      children: [
                        const Text('Quantity',style: TextStyle(color: Colors.white70),),
                        const SizedBox(width: 10,),
                        GestureDetector(
                          onTap: () => decreaseQuantity(),
                          child: const CircleAvatar(radius: 9,
                          backgroundColor: Colors.white,
                            child: Center(
                              child: Icon(Icons.remove,color: Colors.black,size: 14,),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Text(quantity.toString(),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        const SizedBox(width: 10,),
                        GestureDetector(
                          onTap: () => increaseQuantity(),
                          child: const CircleAvatar(radius: 9,
                            backgroundColor: Colors.white,
                            child: Center(
                              child: Icon(Icons.add,color: Colors.black,size: 14,),
                            ),
                          ),
                        )

                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('Address',style: TextStyle(
                        color: Colors.white,fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),),
                      const SizedBox(width: 10,),
                      const Icon(Icons.location_on_outlined,color: Colors.white,),
                      const Spacer(),
                      Text(widget.product.location,style: const TextStyle(color: Colors.white70,),maxLines: 2,),

                    ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(color: Colors.white70,),
                  ),
                  Row(
                    children: [
                      const Text('Delivery',style: TextStyle(
                        color: Colors.white,fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),),
                      const SizedBox(width: 10,),
                      const Icon(Icons.delivery_dining,color: Colors.white,),
                      const Spacer(),
                      Text(widget.product.delivery,style: const TextStyle(color: Colors.white70,),maxLines: 2,),

                    ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(color: Colors.white70,),
                  ),
                  const Text('Payment Method',style: TextStyle(
                    color: Colors.white,fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),),
                  const SizedBox(height: 10,),
                  const Row(
                    children: [
                      Text('Cash Only',style: TextStyle(
                        color: Colors.white,fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),),
                      Spacer(),
                      Icon(Icons.money,color: Colors.white,),

                    ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(color: Colors.white70,),
                  ),
                ],
              ),
              ),
              const SizedBox(height: 10,),
              Container(
                height: 130,
                width: MediaQuery.sizeOf(context).width,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Order Summary',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        const Text('Total Items',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                        const Spacer(),
                        Text('Rs $productPrice',style: const TextStyle(color: Colors.white70,fontWeight: FontWeight.bold,fontSize: 12),),

                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        const Text('Total Payment',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                        const Spacer(),
                        Text('Rs $price',style: const TextStyle(color: Colors.white70,fontWeight: FontWeight.bold,fontSize: 12),),

                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: SizedBox(
                  height: 45,
                  child: AccountButton(text: 'Place Order', loading: false, onTap: () {
                    showGeneralDialog(context: context, pageBuilder: (context, animation, secondaryAnimation) {
                      return AlertDialog(
                        surfaceTintColor: Colors.white,
                        title: const Text('Order Confirmation',
                        style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),
                        ),
                        content: const Text('Are you sure to place this order',style: TextStyle(
                          color: Colors.black
                        ),),
                        actions: [
                          TextButton(onPressed: () {
                            Get.back();
                          }, child: const Text('Cancel',style: TextStyle(color: Colors.black),)),
                          TextButton(onPressed: () {
                            Get.put(OrderController()).placeOrder(quantity: quantity, price: price, product: widget.product);
                          }, child: const Text('ok',style: TextStyle(color: Colors.redAccent),)),
                        ],
                      );
                    },);

                  },),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

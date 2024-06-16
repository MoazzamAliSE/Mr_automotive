import 'package:auto_motive/Data/shared%20pref/shared_pref.dart';
import 'package:auto_motive/main.dart';
import 'package:auto_motive/model/product_model.dart';
import 'package:auto_motive/model/service_model.dart';
import 'package:auto_motive/res/app_color.dart';
import 'package:auto_motive/res/app_images.dart';
import 'package:auto_motive/res/app_text_styles.dart';
import 'package:auto_motive/res/routes/routes.dart';
import 'package:auto_motive/utils/utils.dart';
import 'package:auto_motive/view%20model/controller/add_to_cart_controller.dart';
import 'package:auto_motive/view%20model/controller/bottom_nav_bar_controller.dart';
import 'package:auto_motive/view%20model/controller/fav_controller.dart';
import 'package:auto_motive/view%20model/controller/profile_controller.dart';
import 'package:auto_motive/view/available_products/available_products.dart';
import 'package:auto_motive/view/available_products/components/product_holder.dart';
import 'package:auto_motive/view/available_services/available_services.dart';
import 'package:auto_motive/view/available_services/components/services_holder.dart';
import 'package:auto_motive/view/cart/my_cart.dart';
import 'package:auto_motive/view/google_maps/google_map_screen.dart';
import 'package:auto_motive/view/my_orders/my_orders.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(FavController()).getFavouriteServices();
    Get.put(FavController()).getFavouriteSpareParts();
    Get.put(AddToCartController()).getCart();
    Get.put(ProfileController()).getAppointmentWithClient();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // backgroundColor: darkBackgroundColor,
      drawer: Drawer(
        width: 250,
        backgroundColor: Colors.black,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: darkBackgroundColor.withOpacity(.8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(() => CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white12,
                            child: Get.put(ProfileController())
                                            .user
                                            .value
                                            .profilePicture ==
                                        null ||
                                    Get.put(ProfileController())
                                        .user
                                        .value
                                        .profilePicture
                                        .toString()
                                        .isEmpty
                                ? const Center(
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white70,
                                      size: 35,
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () => Utils.showImage(
                                        context,
                                        Get.put(ProfileController())
                                            .user
                                            .value
                                            .profilePicture
                                            .toString()),
                                    child: CachedNetworkImage(
                                      imageUrl: Get.put(ProfileController())
                                          .user
                                          .value
                                          .profilePicture
                                          .toString(),
                                      fadeInDuration: Duration.zero,
                                      fadeOutDuration: Duration.zero,
                                      placeholderFadeInDuration: Duration.zero,
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
                                        return Center(
                                          child: CircleAvatar(
                                            radius: 40,
                                            backgroundImage: imageProvider,
                                          ),
                                        );
                                      },
                                      errorWidget: (context, url, error) =>
                                          const Center(
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white70,
                                          size: 35,
                                        ),
                                      ),
                                    ),
                                  ),
                          )),
                      const SizedBox(height: 8.0),
                      Text(
                        localUser!.name.toString(),
                        style: AppTextStyles.white16BoldTextStyle,
                      ),
                      Text(
                        localUser!.email.toString(),
                        style: AppTextStyles.grey12UnderLineTextStyle,
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.home, color: Colors.white),
                  title: const Text(
                    'Home',
                    style: AppTextStyles.white16BoldTextStyle,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.shopping_cart, color: Colors.white),
                  title: const Text(
                    'My Cart',
                    style: AppTextStyles.white16BoldTextStyle,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Get.to(() => MyCart());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.shopping_bag_outlined,
                      color: Colors.white),
                  title: const Text(
                    'My Orders',
                    style: AppTextStyles.white16BoldTextStyle,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Get.to(() => MyOrders());
                  },
                ),
                ListTile(
                  leading:
                      const Icon(Icons.emergency_outlined, color: Colors.white),
                  title: const Text(
                    'Emergency',
                    style: AppTextStyles.white16BoldTextStyle,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Get.to(() => const GoogleMapScreen());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings, color: Colors.white),
                  title: const Text(
                    'Settings',
                    style: AppTextStyles.white16BoldTextStyle,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Get.put(BottomNavigationBarController()).onTapBottomIcon(3);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.white),
                  title: const Text(
                    'Logout',
                    style: AppTextStyles.white16BoldTextStyle,
                  ),
                  onTap: () {
                    showGeneralDialog(
                      context: context,
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return AlertDialog(
                          surfaceTintColor: Colors.white,
                          title: const Text(
                            'Warning',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          content: const Text(
                            'Are your sure to logout from this account',
                            style: TextStyle(color: Colors.black),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () => Get.back(),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.black),
                                )),
                            TextButton(
                                onPressed: () {
                                  UserPref.removeUser();
                                },
                                child: const Text(
                                  'Ok',
                                  style: TextStyle(color: Colors.red),
                                )),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: darkBackgroundColor,
        foregroundColor: whiteColor,
        title: const Text(
          "Mr. Automotive",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(Routes.myCart);
              },
              icon: const Icon(Icons.shopping_bag_outlined)),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // const Image(
          //   image: AssetImage(
          //     AppImages.carBG,
          //   ),
          //   fit: BoxFit.fill,
          // ),
          Container(
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
              child: ListView(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  // InputField(hint: 'Search', controller: TextEditingController(), icon: Icon(Icons.search,color: Colors.white,), title: '',color: Colors.white60,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hi, ${localUser!.name}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              'Lets get started',
                              style: TextStyle(color: Colors.white70),
                            )
                          ],
                        ),
                        const Spacer(),
                        Obx(() => CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.white12,
                              child: Get.put(ProfileController())
                                              .user
                                              .value
                                              .profilePicture ==
                                          null ||
                                      Get.put(ProfileController())
                                          .user
                                          .value
                                          .profilePicture
                                          .toString()
                                          .isEmpty
                                  ? const Center(
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white70,
                                        size: 35,
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () => Utils.showImage(
                                          context,
                                          Get.put(ProfileController())
                                              .user
                                              .value
                                              .profilePicture
                                              .toString()),
                                      child: CachedNetworkImage(
                                        imageUrl: Get.put(ProfileController())
                                            .user
                                            .value
                                            .profilePicture
                                            .toString(),
                                        fadeInDuration: Duration.zero,
                                        fadeOutDuration: Duration.zero,
                                        placeholderFadeInDuration:
                                            Duration.zero,
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
                                          return Center(
                                            child: CircleAvatar(
                                              radius: 40,
                                              backgroundImage: imageProvider,
                                            ),
                                          );
                                        },
                                        errorWidget: (context, url, error) =>
                                            const Center(
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.white70,
                                            size: 35,
                                          ),
                                        ),
                                      ),
                                    ),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CarouselSlider(
                      items: [
                        ...[
                          AppImages.home1,
                          AppImages.home2,
                          AppImages.home3,
                        ].map(
                          (e) => Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: grey, width: 2)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                e,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                      ],
                      options: CarouselOptions(
                        aspectRatio: 2.3,
                        viewportFraction: 0.75,
                        enableInfiniteScroll: true,
                        enlargeCenterPage: true,

                        // enlargeFactor: 1.2,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Select Option",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17)),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () => Get.to(() => AvailableServices()),
                            child: Image.asset(
                              'assets/icons/mechanic.png',
                              height: 40,
                              width: 40,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Mechanics',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () => Get.to(() => AvailableProducts()),
                            child: Image.asset(
                              'assets/icons/tyre-40.png',
                              height: 40,
                              width: 40,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Spare Parts',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () => Get.to(() => const GoogleMapScreen()),
                            child: Image.asset(
                              'assets/icons/car service.png',
                              height: 40,
                              width: 40,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Emergency',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('services')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Services',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                Text(
                                  'See all',
                                  style: TextStyle(color: Colors.white70),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 150,
                              width: MediaQuery.sizeOf(context).width,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 6,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 150,
                                    width: 150,
                                    margin: const EdgeInsets.only(right: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white12),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }

                      List<ServiceModel>? list = snapshot.data?.docs
                          .map((e) => ServiceModel.fromFirestore(e))
                          .toList();
                      if (list == null || list.isEmpty) {
                        return const SizedBox.shrink();
                      }

                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Services',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                              GestureDetector(
                                onTap: () => Get.to(() => AvailableServices()),
                                child: const Text(
                                  'See all',
                                  style: TextStyle(color: Colors.white70),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 240,
                            width: MediaQuery.sizeOf(context).width,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: list.length > 3 ? 3 : list.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      right: 20, left: 10),
                                  child: SizedBox(
                                    height: 180,
                                    width: 140,
                                    child: ServicesHolder(service: list[index]),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('products')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Products',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                Text(
                                  'See all',
                                  style: TextStyle(color: Colors.white70),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 150,
                              width: MediaQuery.sizeOf(context).width,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 6,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 150,
                                    width: 150,
                                    margin: const EdgeInsets.only(right: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white12),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }

                      List<ProductModel>? list = snapshot.data?.docs
                          .map((e) => ProductModel.fromFirestore(e))
                          .toList();
                      if (list == null || list.isEmpty) {
                        return const SizedBox.shrink();
                      }

                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Products',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                              GestureDetector(
                                onTap: () => Get.to(() => AvailableProducts()),
                                child: const Text(
                                  'See all',
                                  style: TextStyle(color: Colors.white70),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 220,
                            width: MediaQuery.sizeOf(context).width,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: list.length > 3 ? 3 : list.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      right: 20, left: 10),
                                  child: SizedBox(
                                    height: 180,
                                    width: 140,
                                    child: ProductHolder(product: list[index]),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),

                  // BrowseCategoriesHomeComponent(),
                  // SparePartsHomeComponent(),
                  // MechanicsHomeComponent()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

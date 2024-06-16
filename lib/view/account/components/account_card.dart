import 'package:auto_motive/main.dart';
import 'package:auto_motive/res/app_text_styles.dart';
import 'package:auto_motive/utils/utils.dart';
import 'package:auto_motive/view%20model/controller/profile_controller.dart';
import 'package:auto_motive/view/common%20widgets/custom_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountCard extends StatelessWidget {
  AccountCard({
    super.key,
  });

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() => GestureDetector(
              onTap: () {
                showGeneralDialog(context: context, pageBuilder: (context, animation, secondaryAnimation){
                  return AlertDialog(
                    surfaceTintColor: Colors.white,
                    title: const Text('Profile Picture',style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                    content: SizedBox(
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                              Utils.showImage(context, Get.put(ProfileController())
                                  .user
                                  .value
                                  .profilePicture
                                  .toString());
                            },
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.view_in_ar,color: Colors.black54,),
                                SizedBox(height: 5,),
                                Text('View',style: TextStyle(color: Colors.black,fontSize: 14),),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                              controller.pickImage();
                            },
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.image,color: Colors.black54,),
                                SizedBox(height: 5,),
                                Text('Change',style: TextStyle(color: Colors.black,fontSize: 14),),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },);
              },
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white12,
                child: controller.user.value.profilePicture == null ||
                    controller.user.value.profilePicture.toString().isEmpty
                    ? const Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.white70,
                    size: 35,
                  ),
                )
                    : CachedNetworkImage(imageUrl: controller.user.value.profilePicture.toString(),
                fadeInDuration: Duration.zero,
                fadeOutDuration: Duration.zero,
                placeholderFadeInDuration: Duration.zero,
                placeholder: (context, url) {
                      return const Center(
                        child: SizedBox(height: 20,width: 20,
                        child: CircularProgressIndicator(color: Colors.white,
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
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(
                      Icons.person,
                      color: Colors.white70,
                      size: 35,
                    ),
                  ),
                ),
              ),
            )),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                localUser!.name.toString(),
                style: AppTextStyles.white16BoldTextStyle,
                overflow: TextOverflow.ellipsis,
              ),
              // SizedBox(height: 10,),
              GestureDetector(
                onTap: () {
                  showGeneralDialog(context: context, pageBuilder: (context, animation, secondaryAnimation){
                    return AlertDialog(
                      surfaceTintColor: Colors.white,
                      title: const Text('Profile Picture',style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                      content: SizedBox(
                        height: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back();
                                Utils.showImage(context, Get.put(ProfileController())
                                    .user
                                    .value
                                    .profilePicture
                                    .toString());
                              },
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.view_in_ar,color: Colors.black54,),
                                  SizedBox(height: 5,),
                                  Text('View',style: TextStyle(color: Colors.black,fontSize: 14),),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.back();
                                controller.pickImage();
                              },
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.image,color: Colors.black54,),
                                  SizedBox(height: 5,),
                                  Text('Change',style: TextStyle(color: Colors.black,fontSize: 14),),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },);
                },
                child: const Text(
                  "View and Edit",
                  style: AppTextStyles.grey12UnderLineTextStyle,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

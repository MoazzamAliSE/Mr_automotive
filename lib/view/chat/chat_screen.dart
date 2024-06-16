import 'dart:async';
import 'dart:developer';

import 'package:auto_motive/main.dart';
import 'package:auto_motive/model/user_model.dart';
import 'package:auto_motive/res/app_color.dart';
import 'package:auto_motive/view%20model/controller/chat_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key, required this.user});
  final controller = Get.put(ChatController());
  final UserModel user;
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    log(user.profilePicture ?? "");
    return Scaffold(
      backgroundColor: darkBackgroundColor,
      body: SafeArea(
          child: Column(
        children: [
          Card(
            color: darkBackgroundColor,
            surfaceTintColor: darkBackgroundColor,
            shadowColor: Colors.white,
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () => Get.back(),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white12,
                      child: user.profilePicture == null ||
                              user.profilePicture.toString().isEmpty
                          ? const Center(
                              child: Icon(
                                Icons.person,
                                color: Colors.white70,
                                size: 25,
                              ),
                            )
                          : CachedNetworkImage(
                              imageUrl: user.profilePicture.toString(),
                              imageBuilder: (context, imageProvider) {
                                return CircleAvatar(
                                  radius: 22,
                                  backgroundColor: Colors.black12,
                                  backgroundImage: imageProvider,
                                );
                              },
                              errorWidget: (context, url, error) {
                                return const CircleAvatar(
                                  radius: 22,
                                  backgroundColor: Colors.white12,
                                  child: Center(
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white70,
                                      size: 25,
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          user.email.toString(),
                          style: const TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: Container(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(localUser!.token)
                  .collection('messages')
                  .doc(user.token)
                  .collection('messages')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                } else {
                  final List<Map>? list = snapshot.data?.docs
                      .map((e) => {
                            'message': e['message'],
                            'timeStamp': e['timeStamp'],
                            'time': e['time'],
                            'sender': e['sender']
                          })
                      .toList();
                  try {
                    Timer(const Duration(milliseconds: 10), () {
                      scrollController.animateTo(
                          scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 10),
                          curve: Curves.ease);
                    });
                  } catch (_) {
                    Timer(const Duration(milliseconds: 50), () {
                      scrollController.animateTo(
                          scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 10),
                          curve: Curves.ease);
                    });
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: list == null ? 0 : list.length,
                      itemBuilder: (context, index) {
                        return Align(
                          alignment: list?[index]['sender'].toString() ==
                                  localUser!.token
                              ? Alignment.topRight
                              : Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: list?[index]['sender'].toString() ==
                                        localUser!.token
                                    ? 50
                                    : 0,
                                right: list?[index]['sender'].toString() !=
                                        localUser!.token
                                    ? 50
                                    : 0,
                                top: 20,
                                bottom: 10),
                            child: Column(
                              crossAxisAlignment: user.token == localUser!.token
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Text(
                                  list?[index]['message'],
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  list?[index]['time'],
                                  style: const TextStyle(color: Colors.white70),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          )),
          Container(
            height: 60,
            width: MediaQuery.sizeOf(context).width,
            color: Colors.white12,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: TextFormField(
                  controller: controller.chat,
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.white38, fontSize: 14),
                    hintText: 'Write your message',
                  ),
                )),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    controller.sendMessage(
                      id: user.token.toString(),
                      email: user.email.toString(),
                      name: user.name.toString(),
                      profilePicture: user.profilePicture,
                    );
                  },
                  child: const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white12,
                    child: Center(
                      child: Icon(
                        Icons.send,
                        color: Colors.white70,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}

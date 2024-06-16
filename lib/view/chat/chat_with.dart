import 'package:auto_motive/main.dart';
import 'package:auto_motive/model/user_model.dart';
import 'package:auto_motive/view/chat/chat_screen.dart';
import 'package:auto_motive/view/common%20widgets/back_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view model/controller/bottom_nav_bar_controller.dart';

class ChatWith extends StatelessWidget {
  const ChatWith({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                Row(
                  children: [
                    CustomBackButton(
                      onTap: () {
                        Get.put(BottomNavigationBarController()).onTapBottomIcon(0);

                      },
                    ),
                    const SizedBox(width: 20,),
                    const Text('Chats',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                  ],
                ),
                const SizedBox(height: 20,),
                Expanded(child: StreamBuilder(stream: FirebaseFirestore.instance.collection('chats').doc(localUser!.token).collection('chatWith').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(color: Colors.white,)),
                              SizedBox(height: 5,),
                              Text('Loading your chats...',style: TextStyle(color: Colors.white,),)
                            ],
                          ),
                        );
                      }else{
                        List<Map>? chats=snapshot.data?.docs.map((e){
                          print(e);
                          return {
                            'date' : e['date'],
                            'name' : e['name'],
                            'id' : e['id'],
                            'latestMessage' : e['latestMessage'],
                            'profilePicture' : e['profilePicture'],
                            'email' : e['email']
                          };
                        }).toList();

                        if(chats==null || chats.isEmpty){
                          return const Center(
                            child: Text('No Chat available',style: TextStyle(color: Colors.white,),),
                          );
                        }

                        return ListView.builder(
                          itemCount: chats.length,

                          itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(()=>ChatScreen(user: UserModel(
                                  name: chats[index]['name'].toString(),
                                  profilePicture: chats[index]['profilePicture'],
                                  latitude: 0,
                                  myServices: [],
                                  mySpareParts: [],
                                  longitude: 0,
                                  token: chats[index]['id'],
                                  email: chats[index]['email'],
                                  phoneNumber: '')));
                            },
                            child: Card(
                              color: Colors.black,
                              shadowColor: Colors.white,
                              child: Container(
                                height: 70,
                                width: MediaQuery.sizeOf(context).width,
                                decoration: BoxDecoration(
                                    // color: Colors.white12,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 20,),
                                    CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white12,
                                      child: chats[index]['profilePicture']==null || chats[index]['profilePicture'].toString().isEmpty ? const Center(
                                        child: Icon(Icons.person,color: Colors.white70,size: 25,),
                                      ) : CachedNetworkImage(imageUrl: chats[index]['profilePicture'].toString(),
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
                                              child: Icon(Icons.person,color: Colors.white70,size: 25,),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10,),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                        Text(chats[index]['name'].toString(),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                        Text(chats[index]['latestMessage'].toString(),style: const TextStyle(color: Colors.white70,overflow: TextOverflow.ellipsis),maxLines: 1,),
                                      ],),
                                    ),
                                    const SizedBox(width: 10,),
                                    Center(
                                      child: Text(chats[index]['date'].toString(),style: const TextStyle(color: Colors.white70),),
                                    ),
                                    const SizedBox(width: 10,),
                                    const Icon(Icons.send,size: 20,color: Colors.white,),
                                const SizedBox(width: 20,),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },);


                       }
                    },))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

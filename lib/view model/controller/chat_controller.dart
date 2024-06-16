import 'package:auto_motive/main.dart';
import 'package:auto_motive/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatController extends GetxController {
  final TextEditingController chat = TextEditingController();

  sendMessage(
      {required String id,
      required String name,
      required String email,
      String? profilePicture}) async {
    final message = chat.value.text.toString();
    if (message.isNotEmpty) {
      chat.clear();
      var now = DateTime.now();
      var formattedTime = DateFormat('h:mm a').format(now);
      final key=DateTime.now().microsecondsSinceEpoch.toString();
      FirebaseFirestore.instance
          .collection('chats')
          .doc(localUser!.token)
          .collection('messages')
          .doc(id)
          .collection('messages')
          .doc(key)
          .set({
        'timeStamp': key,
        'message': message,
        'time': formattedTime,
        'sender': localUser!.token,
      });

      FirebaseFirestore.instance
          .collection('chats')
          .doc(id)
          .collection('messages')
          .doc(localUser!.token).collection('messages').doc(key)
          .set({
        'message': message,
        'timeStamp': key,
        'time': formattedTime,
        'sender': localUser!.token,
      }
      );

      FirebaseFirestore.instance
          .collection('chats')
          .doc(localUser!.token)
          .collection('chatWith')
          .doc(id)
          .set({
        'date': Utils.formatDate(DateTime.now()),
        'id': id,
        'name': name,
        'latestMessage': message,
        'profilePicture': profilePicture,
        'email': email,
      });

      FirebaseFirestore.instance
          .collection('chats')
          .doc(id)
          .collection('chatWith')
          .doc(localUser!.token)
          .set({
        'date': Utils.formatDate(DateTime.now()),
        'id': localUser!.token,
        'name': name,
        'latestMessage': message,
        'profilePicture': profilePicture,
        'email': localUser!.email,
      });
    }
  }
}

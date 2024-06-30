import 'package:chat/core/firebase_controllers/firestore_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SendMessageService {
  static SendMessageService instance = SendMessageService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> sendMessage({
    required String message,
    required String receiverUid,
  }) async {
    var res = false;

    try {
      await FireStoreController.instance.sendMessage(
        message: message,
        userId: _auth.currentUser!.uid,
        receiverUid: receiverUid,
      );
    } catch (error) {
      debugPrint("Error while sending message: $error");
    }

    return res;
  }
}

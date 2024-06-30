import 'package:chat/core/common/models/user_model.dart';
import 'package:chat/core/firebase_controllers/firestore_controller.dart';
import 'package:flutter/material.dart';

class ChatServices {
  Future<List<UserModel>> getAllUsersData() async {
    List<UserModel> allUsers = [];

    try {
      allUsers = await FireStoreController.instance.getAllUserData();
    } catch (error) {
      debugPrint("Error while getting all users data --FIREBASE: $error");
    }

    return allUsers;
  }

  Future<bool> createChatRoom({
    required String receiverUid,
    required String receiverUsername,
    required String receiverEmail,
  }) async {
    var res = false;

    try {
      res = await FireStoreController.instance.createChatRoom(
        receiverUid: receiverUid,
        receiverUsername: receiverUsername,
        receiverEmail: receiverEmail,
      );
    } catch (error) {
      debugPrint("Error while creating chat room --FIREBASE: $error");
    }

    return res;
  }
}

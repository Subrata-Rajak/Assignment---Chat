import 'package:chat/core/common/models/chat_room_model.dart';
import 'package:chat/core/shared_preferences/local_storage.dart';
import 'package:chat/core/shared_preferences/local_storage_keys.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../src/values/strings.dart';
import '../common/models/user_model.dart';

class FireStoreController {
  static FireStoreController instance = FireStoreController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> storeUserDetails({
    required String uid,
    required String userName,
    required String email,
    required String bio,
  }) async {
    try {
      await _firebaseFirestore
          .collection(AppStrings.instance.userCollection)
          .doc(uid)
          .set(UserModel(
            uid: uid,
            userName: userName,
            email: email,
            bio: bio,
          ).toJson());
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<dynamic> getUserData(String uid) async {
    var snap;

    try {
      snap = await _firebaseFirestore
          .collection(AppStrings.instance.userCollection)
          .doc(uid)
          .get();
    } catch (error) {
      print(error.toString());
    }

    return snap;
  }

  Future<List<UserModel>> getAllUserData() async {
    final snapShot = await _firebaseFirestore
        .collection(AppStrings.instance.userCollection)
        .where('Uid', isNotEqualTo: _auth.currentUser!.uid)
        .get();

    final allUserData =
        snapShot.docs.map((e) => UserModel.fromSnapShot(e)).toList();

    return allUserData;
  }

  Future<bool> createChatRoom({
    required String receiverUid,
    required String receiverUsername,
    required String receiverEmail,
  }) async {
    bool res = false;

    try {
      var snap = await _firebaseFirestore
          .collection(AppStrings.instance.chatRoomCollection)
          .where(
            Filter.or(
              Filter(
                "userOne.uid",
                isEqualTo: receiverUid,
              ),
              Filter(
                "userTwo.uid",
                isEqualTo: receiverUid,
              ),
            ),
          )
          .get();

      if (snap.docs.isNotEmpty) {
        return false;
      }

      var currentUserEmail = await LocalStorage.instance.readStringFromLocalDb(
          key: LocalStorageKeys.instance.currentUserEmail);
      var currentUserUsername = await LocalStorage.instance
          .readStringFromLocalDb(
              key: LocalStorageKeys.instance.currentUserUsername);

      String chatroomId = _firebaseFirestore
          .collection(AppStrings.instance.chatRoomCollection)
          .doc()
          .id;
      var newChatRoom = ChatRoomModel(
        chatroomId: chatroomId,
        userOne: UserType(
          email: currentUserEmail!,
          uid: _auth.currentUser!.uid,
          username: currentUserUsername!,
        ),
        userTwo: UserType(
          email: receiverEmail,
          uid: receiverUid,
          username: receiverUsername,
        ),
        chats: [],
        createdAt: DateTime.now(),
      );

      await _firebaseFirestore
          .collection(AppStrings.instance.chatRoomCollection)
          .doc(chatroomId)
          .set(newChatRoom.toJson());
    } catch (error) {
      debugPrint("Error while creating chat room --FIREBASE: $error");
    }

    return res;
  }

  Future<bool> sendMessage({
    required String message,
    required String userId,
    required String receiverUid,
  }) async {
    bool res = false;

    try {
      // Create a new Chat object
      var newChat = Chat(
        userId: userId,
        text: message,
        timeStamp: DateTime.now(),
      );

      // Query Firestore for the chat room where receiver.uid matches receiverUid
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection(AppStrings.instance.chatRoomCollection)
              .where('userTwo.uid', isEqualTo: receiverUid)
              .get();

      // Check if any chat room exists for the receiverUid
      if (querySnapshot.docs.isNotEmpty) {
        // Get the first document found (assuming receiverUid uniquely identifies a chat room)
        DocumentSnapshot<Map<String, dynamic>> docSnapshot =
            querySnapshot.docs.first;
        var chatRoomId = docSnapshot.id;

        // Update the chats array in the existing chat room
        await _firebaseFirestore
            .collection(AppStrings.instance.chatRoomCollection)
            .doc(chatRoomId)
            .update({
          'chats': FieldValue.arrayUnion([newChat.toJson()]),
        });

        res = true; // Successfully sent message
      } else {
        debugPrint('No chat room found for receiverUid: $receiverUid');
      }
    } catch (error) {
      debugPrint("Error while sending message: $error");
    }

    return res;
  }
}

import 'package:chat/core/shared_preferences/local_storage.dart';
import 'package:chat/core/shared_preferences/local_storage_keys.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/exceptions/auth_failure.dart';
import '../../../../core/firebase_controllers/firestore_controller.dart';
import '../../../../src/values/strings.dart';

class AuthServices {
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  String registerResponse = "Success";
  String loginResponse = "Success";

  Future<bool> registerUser({
    required String email,
    required String password,
    required String confirmPassword,
    required String userName,
  }) async {
    var res = false;

    try {
      UserCredential userCred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FireStoreController.instance.storeUserDetails(
        uid: userCred.user!.uid,
        userName: userName,
        email: email,
        bio: "I am using Chat",
      );

      res = true;
    } on FirebaseAuthException catch (e) {
      registerResponse = AuthFailure.code(e.code).message;
    } catch (_) {
      registerResponse = const AuthFailure().message;
    }

    return res;
  }

  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    var res = false;

    try {
      // Sign in user with Firebase Auth
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      // Retrieve user document from Firestore
      var snap = await _firebaseFirestore
          .collection(AppStrings.instance.userCollection)
          .doc(_auth.currentUser!.uid)
          .get();

      if (snap.exists) {
        debugPrint("User Data Retrieved:");
        debugPrint("Username: ${snap.data()!['UserName']}");
        debugPrint("Email: ${snap.data()!['Email']}");

        // Store username and email locally
        await LocalStorage.instance.writeStringToLocalDb(
          key: LocalStorageKeys.instance.currentUserUsername,
          value: snap.data()!['UserName'] ?? '',
        );
        await LocalStorage.instance.writeStringToLocalDb(
          key: LocalStorageKeys.instance.currentUserEmail,
          value: snap.data()!['Email'] ?? '',
        );

        // Update local storage to indicate user is logged in
        await LocalStorage.instance.writeBoolToLocalDb(
          key: LocalStorageKeys.instance.isLoggedIn,
          value: true,
        );

        res =
            true; // Set result to true upon successful login and data retrieval
      } else {
        debugPrint("User document does not exist");
        // Handle case where user document does not exist in Firestore
      }
    } on FirebaseAuthException catch (e) {
      debugPrint("Firebase Auth Exception: ${e.message}");
      // Handle FirebaseAuthException (e.g., invalid credentials)
      // Set error message or handle failure accordingly
    } catch (error) {
      debugPrint("Error: $error");
      // Handle other errors that may occur during login or data retrieval
      // Set error message or handle failure accordingly
    }

    return res;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}

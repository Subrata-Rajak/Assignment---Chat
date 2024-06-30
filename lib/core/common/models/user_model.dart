import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../src/values/strings.dart';

class UserModel {
  final String uid;
  final String userName;
  final String email;
  final String bio;

  UserModel({
    required this.uid,
    required this.userName,
    required this.email,
    required this.bio,
  });

  Map<String, dynamic> toJson() => {
        AppStrings.instance.uidField: uid,
        AppStrings.instance.userNameField: userName,
        AppStrings.instance.bioField: bio,
        AppStrings.instance.emailField: email,
      };

  factory UserModel.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> snap) {
    final data = snap.data();

    return UserModel(
      uid: data![AppStrings.instance.uidField],
      userName: data[AppStrings.instance.userNameField],
      email: data[AppStrings.instance.emailField],
      bio: data[AppStrings.instance.bioField],
    );
  }
}

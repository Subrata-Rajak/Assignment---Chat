import 'package:chat/core/common/models/user_model.dart';

abstract class ChatRepository {
  Future<List<UserModel>> getAllUsersData();
  Future<bool> createChatRoom({
    required String receiverUid,
    required String receiverUsername,
    required String receiverEmail,
  });
}

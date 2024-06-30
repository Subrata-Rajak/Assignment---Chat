import 'package:chat/core/common/models/user_model.dart';
import 'package:chat/feature/chat/data/sources/chat_services.dart';
import 'package:chat/feature/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatServices chatServices;

  ChatRepositoryImpl({required this.chatServices});

  @override
  Future<List<UserModel>> getAllUsersData() async {
    return await chatServices.getAllUsersData();
  }

  @override
  Future<bool> createChatRoom({
    required String receiverUid,
    required String receiverUsername,
    required String receiverEmail,
  }) async {
    return await chatServices.createChatRoom(
      receiverUid: receiverUid,
      receiverUsername: receiverUsername,
      receiverEmail: receiverEmail,
    );
  }
}

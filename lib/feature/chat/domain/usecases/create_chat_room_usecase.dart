import 'package:chat/feature/chat/domain/repositories/chat_repository.dart';

class CreateChatRoomUsecase {
  final ChatRepository chatRepository;

  CreateChatRoomUsecase({required this.chatRepository});

  Future<bool> createChatRoom({
    required String receiverUid,
    required String receiverUsername,
    required String receiverEmail,
  }) async {
    return await chatRepository.createChatRoom(
      receiverUid: receiverUid,
      receiverUsername: receiverUsername,
      receiverEmail: receiverEmail,
    );
  }
}

import 'package:chat/feature/chat/domain/repositories/chat_repository.dart';

class GetAllChatRoomsUsecase {
  final ChatRepository chatRepository;

  GetAllChatRoomsUsecase({required this.chatRepository});
}

import 'package:chat/core/common/models/user_model.dart';
import 'package:chat/feature/chat/domain/repositories/chat_repository.dart';

class GetAllUsersDataUsecase {
  final ChatRepository chatRepository;

  GetAllUsersDataUsecase({required this.chatRepository});

  Future<List<UserModel>> getAllUsersData() async {
    return await chatRepository.getAllUsersData();
  }
}

import 'package:chat/feature/auth/domain/repositories/auth_repository.dart';

class LogOutUserUsecase {
  final AuthRepository authRepository;

  LogOutUserUsecase({required this.authRepository});

  Future<void> logoutUser({
    word,
    required String userName,
  }) async {
    return await authRepository.logoutUser();
  }
}

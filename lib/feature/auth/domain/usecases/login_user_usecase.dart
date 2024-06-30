import 'package:chat/feature/auth/domain/repositories/auth_repository.dart';

class LoginUserUsecase {
  final AuthRepository authRepository;

  LoginUserUsecase({required this.authRepository});

  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    return await authRepository.loginUser(
      email: email,
      password: password,
    );
  }
}

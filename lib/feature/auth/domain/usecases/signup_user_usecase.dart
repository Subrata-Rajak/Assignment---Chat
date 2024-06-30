import 'package:chat/feature/auth/domain/repositories/auth_repository.dart';

class SignUpUserUsecase {
  final AuthRepository authRepository;

  SignUpUserUsecase({required this.authRepository});

  Future<bool> registerUser({
    required String email,
    required String password,
    required String confirmPassword,
    required String userName,
  }) async {
    return await authRepository.registerUser(
      email: email,
      confirmPassword: confirmPassword,
      userName: userName,
      password: password,
    );
  }
}

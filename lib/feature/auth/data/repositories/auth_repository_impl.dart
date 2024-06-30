import 'package:chat/feature/auth/data/sources/auth_services.dart';
import 'package:chat/feature/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthServices authServices;

  AuthRepositoryImpl({required this.authServices});

  @override
  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    return await authServices.loginUser(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logoutUser() async {
    return await authServices.logout();
  }

  @override
  Future<bool> registerUser({
    required String email,
    required String password,
    required String confirmPassword,
    required String userName,
  }) async {
    return await authServices.registerUser(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      userName: userName,
    );
  }
}

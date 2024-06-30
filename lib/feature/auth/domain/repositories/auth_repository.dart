abstract class AuthRepository {
  Future<bool> registerUser({
    required String email,
    required String password,
    required String confirmPassword,
    required String userName,
  });

  Future<bool> loginUser({
    required String email,
    required String password,
  });

  Future<void> logoutUser();
}

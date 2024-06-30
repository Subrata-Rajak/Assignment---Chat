abstract class LoginScreenEvents {}

class LoginUserEvent extends LoginScreenEvents {
  final String email;
  final String password;

  LoginUserEvent({
    required this.email,
    required this.password,
  });
}

abstract class SignUpScreenEvents {}

class SignUpUserEvent extends SignUpScreenEvents {
  final String username;
  final String email;
  final String password;
  final String confirmPassword;

  SignUpUserEvent({
    required this.confirmPassword,
    required this.email,
    required this.password,
    required this.username,
  });
}

/*
* The EnvironmentVariableKeys class contains all the keys to the environment variables used in the project
* This One stop approach helps to change any env variable name in future
* Just change it here and it will reflected all over the project
*/

class EnvironmentVariableKeys {
  static EnvironmentVariableKeys instance = EnvironmentVariableKeys();

  final String baseUrl =
      "BASE_URL"; //? base url of the polymetalz mobile app api
  final String oneSignalAppId =
      "ONE_SIGNAL_APP_ID"; //? One Signal App Id used to get deviceId for push notification
  final String accessTokenKey =
      "ACCESS_TOKEN_KEY"; //? AccessToken key to verify the user
  final String refreshTokenKey =
      "REFRESH_TOKEN_KEY"; //? RefreshToken key to refresh the accessToken
  final String adminAccessToken = "ADMIN_ACCESS_TOKEN";
  final String adminBaseUrl = "ADMIN_BASE_URL";
}

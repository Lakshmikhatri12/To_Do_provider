class LoginRequest {
  final String username;
  final String password;
  final int expiresInMins;

  LoginRequest({
    required this.username,
    required this.password,
    this.expiresInMins = 30,
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
    'expiresInMins': expiresInMins,
  };
}

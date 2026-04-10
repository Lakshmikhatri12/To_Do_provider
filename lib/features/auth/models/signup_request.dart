class SignupRequest {
  final String username;
  final String password;

  SignupRequest({required this.username, required this.password});

  Map<String, dynamic> toJson() => {'username': username, 'password': password};
}

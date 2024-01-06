class RegisterParam {
  final String name;
  final String email;
  final String password;
  final String? photoUrl;

  RegisterParam({
    required this.name,
    required this.email,
    required this.password,
    this.photoUrl,
  });
}
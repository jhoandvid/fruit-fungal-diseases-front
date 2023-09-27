class User {
  final String id;
  final String email;
  final String name;
  final String role;
  final String token;

  User(
      {required this.email,
      required this.name,
      required this.role,
      required this.id,
      required this.token});

  bool get isAdmin {
    return role == 'admin';
  }
}

class UserCredentials {
  final String username;
  final String password;
  final String companyDB;

  UserCredentials({
    required this.username,
    required this.password,
    required this.companyDB,
  }) {
    if (username.trim().isEmpty) {
      throw ArgumentError('Username cannot be empty.');
    }
    if (password.isEmpty) {
      throw ArgumentError('Password cannot be empty.');
    }
    if (password.length < 4) {
      throw ArgumentError('Password must be at least 4 characters long.');
    }
  }
  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
    'companyDb': companyDB,
  };
}

class UserCredentials {
  final String dbName;
  final String username;
  final String password;

  UserCredentials({
    required this.dbName,
    required this.username,
    required this.password,
  }) {
    if (dbName.trim().isEmpty) {
      throw ArgumentError('Database name cannot be empty.');
    }
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
}

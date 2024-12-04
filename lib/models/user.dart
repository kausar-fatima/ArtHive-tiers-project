class User {
  String name;
  String email;
  String password;
  String? imageUrl; // Optional image URL
  bool isLoggedIn;

  User({
    required this.name,
    required this.email,
    required this.password,
    this.isLoggedIn = false,
    this.imageUrl,
  });

  // Convert User to a map for Firebase storage
  Map<String, dynamic> toFirebaseMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'imageUrl': imageUrl,
      'isLoggedIn': isLoggedIn,
    };
  }

  // Create a User from Firebase data
  factory User.fromFirebaseMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      email: map['email'],
      password: map['password'],
      imageUrl: map['imageUrl'],
      isLoggedIn: map['isLoggedIn'] ?? false,
    );
  }

  // Convert User to a map for SQLite storage (handling booleans as 1 or 0)
  Map<String, dynamic> toSQLiteMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'imageUrl': imageUrl,
      'isLoggedIn': isLoggedIn ? 1 : 0, // Store boolean as 1 or 0 in SQLite
    };
  }

  // Create a User from SQLite data (handling 1 or 0 as boolean)
  factory User.fromSQLiteMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      email: map['email'],
      password: map['password'],
      imageUrl: map['imageUrl'],
      isLoggedIn: map['isLoggedIn'] == 1, // Convert 1/0 back to boolean
    );
  }
}

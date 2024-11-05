class User {
  String name;
  String email;
  String password;
  String? imageUrl; // Image is optional, so nullable
  bool isLoggedIn = false;

  User({
    required this.name,
    required this.email,
    required this.password,
    this.isLoggedIn = false,
    this.imageUrl,
  });

  // Convert User to a map for storage
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'imageUrl': imageUrl,
      'isLoggedIn': isLoggedIn,
    };
  }

  // Create a User from a map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      email: map['email'],
      password: map['password'],
      imageUrl: map['imageUrl'],
      isLoggedIn: map['isLoggedIn'] ?? false,
    );
  }
}

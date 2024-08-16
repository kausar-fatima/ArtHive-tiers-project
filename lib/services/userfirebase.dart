import 'package:art_hive_app/headers.dart';

class FirebaseService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  Future<void> saveUser(User user) async {
    try {
      await _dbRef
          .child('users')
          .child(user.email.replaceAll('.', '_'))
          .set(user.toMap());
      debugPrint("+++++++++ Added user on firebase: $user");
    } catch (e) {
      print("*********** Error saving user: $e ***********");
    }
  }

  // Update a specific field in Firebase
  Future<void> updateUserField(
      String email, String fieldName, dynamic value) async {
    try {
      await _dbRef
          .child('users')
          .child(email.replaceAll('.', '_'))
          .update({fieldName: value});
    } catch (e) {
      print("*********** Error updating user field: $e ***********");
    }
  }

  Future<User?> getUser(String email) async {
    try {
      final snapshot =
          await _dbRef.child('users').child(email.replaceAll('.', '_')).get();

      if (snapshot.exists) {
        final data = snapshot.value
            as Map<dynamic, dynamic>; // Cast to Map<dynamic, dynamic>
        return User.fromMap(
            data.cast<String, dynamic>()); // Cast to Map<String, dynamic>
      } else {
        print("*********** User not found for email: $email ***********");
        return null;
      }
    } catch (e) {
      print("*********** Error retrieving user: $e ***********");
      return null;
    }
  }
}

import 'package:art_hive_app/models/user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FirebaseService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  Future<void> saveUser(User user) async {
    try {
      await _dbRef
          .child('users')
          .child(user.email.replaceAll('.', '_'))
          .set(user.toFirebaseMap());
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

  Future<void> copyUserData({
    required String oldEmail,
    required String newEmail,
  }) async {
    try {
      // Fetch the old user data
      DataSnapshot snapshot = await _dbRef
          .child('users')
          .child(oldEmail.replaceAll('.', '_'))
          .get();

      if (snapshot.exists) {
        // Copy the data to the new email
        await _dbRef
            .child('users')
            .child(newEmail.replaceAll('.', '_'))
            .set(snapshot.value);
      }
    } catch (e) {
      print("*********** Error copying user data: $e ***********");
    }
  }

  Future<bool> checkIfEmailExists(String email) async {
    try {
      final snapshot = await _dbRef.child('users').once();

      if (snapshot.snapshot.exists) {
        Map<dynamic, dynamic> users =
            snapshot.snapshot.value as Map<dynamic, dynamic>;

        // Check if any user has the same email (replace '.' with '_')
        String formattedEmail = email.replaceAll('.', '_');
        return users.containsKey(formattedEmail);
      }
    } catch (e) {
      print("*********** Error checking if email exists: $e ***********");
    }

    return false;
  }

  Future<void> deleteUser(String email) async {
    try {
      await _dbRef.child('users').child(email.replaceAll('.', '_')).remove();
      debugPrint("+++++++++ Deleted user with email: $email");
    } catch (e) {
      print("*********** Error deleting user: $e ***********");
    }
  }

  Future<User?> getUser(String email) async {
    try {
      final snapshot =
          await _dbRef.child('users').child(email.replaceAll('.', '_')).get();

      if (snapshot.exists) {
        final data = snapshot.value
            as Map<dynamic, dynamic>; // Cast to Map<dynamic, dynamic>
        return User.fromFirebaseMap(
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

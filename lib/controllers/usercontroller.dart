import 'dart:io';

import 'package:art_hive_app/headers.dart';

class UserController extends GetxController {
  final LocalStorageService localStorageService;
  final FirebaseService firebaseService;

  var user = Rxn<User>();

  UserController(this.localStorageService, this.firebaseService);

  void loadUser() async {
    user.value = await localStorageService.getUser();
    //localStorageService.clearUser();
  }

  Future<bool> saveUser(User newUser) async {
    try {
      // Check if the email is already in use by another user
      bool emailExists =
          await firebaseService.checkIfEmailExists(newUser.email);
      if (emailExists) {
        // If the email already exists, don't allow the save
        Get.snackbar("Sign up Error", "Email already registered",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.white,
            colorText: Colors.green);
        return false;
      } else {
        // Only save the user locally and remotely if the email is unique
        await firebaseService.saveUser(newUser);
        saveUserOnLocalSt(newUser);
        user.value = newUser;
        return true;
      }
    } catch (e) {
      // Handle any errors (e.g., network or Firebase issues)
      Get.snackbar(
          "Sign up Error", "An error occurred while saving the user: $e",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.white,
          colorText: Colors.red);
      return false;
    }
  }

  Future<void> saveUserOnLocalSt(User newUser) async {
    await localStorageService.saveUser(newUser);
  }

  // Method to update user information with email uniqueness check
  Future<bool> updateUser({
    required String name,
    required String email,
    required String password,
  }) async {
    if (user.value != null) {
      // Check if the email is being changed
      if (user.value!.email != email) {
        // Check if the new email is already in use by another user
        bool emailExists = await firebaseService.checkIfEmailExists(email);

        if (emailExists) {
          // If the email already exists, don't allow the update
          print(
              "*********** Email already in use by another user: $email ***********");
          return false; // Optionally, throw an exception or show an error message to the user here
        }
        // Copy existing user data to the new email
        await firebaseService.copyUserData(
            oldEmail: user.value!.email, newEmail: email);

        // Delete old email entry
        await firebaseService.deleteUser(user.value!.email);
      }

      // Update user fields in Firebase
      await firebaseService.updateUserField(email, 'name', name);
      await firebaseService.updateUserField(email, 'email', email);
      await firebaseService.updateUserField(email, 'password', password);

      // Update the in-memory user object
      user.value!.name = name;
      user.value!.email = email;
      user.value!.password = password;

      // Save updated user data to local storage
      await localStorageService.saveUser(user.value!);

      return true;
    }
    return false;
  }

  // Method to update user profile Image
  Future<void> updateUserImage(File imageFile) async {
    if (user.value != null) {
      // Update the in-memory user object
      user.value!.imageUrl = imageFile.path;

      // Save updated user data to local storage
      await localStorageService.saveUser(user.value!);

      // Update user fields in Firebase
      await firebaseService.updateUserField(
          user.value!.email, 'imageUrl', imageFile.path);
    }
  }

  // New method to update only the isLoggedIn field
  Future<void> updateIsLoggedIn(bool isLoggedIn) async {
    if (user.value != null) {
      // Update the in-memory user object
      user.value!.isLoggedIn = isLoggedIn;

      // Update the user data in local storage
      await localStorageService.saveUser(user.value!);

      // Update the isLoggedIn field in Firebase
      await firebaseService.updateUserField(
          user.value!.email, 'isLoggedIn', isLoggedIn);
    }
  }

  Future<void> clearUser(String email) async {
    // Clear the user data from local storage
    await localStorageService.clearUser();

    // Clear the user data from Firebase
    await firebaseService.deleteUser(email);

    // Clear the in-memory user object
    user.value = null;
  }
}

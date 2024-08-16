import 'package:art_hive_app/headers.dart';

class UserController extends GetxController {
  final LocalStorageService localStorageService;
  final FirebaseService firebaseService;

  var user = Rxn<User>();

  UserController(this.localStorageService, this.firebaseService);

  void loadUser() {
    user.value = localStorageService.getUser();
  }

  Future<void> saveUser(User newUser) async {
    await localStorageService.saveUser(newUser);
    await firebaseService.saveUser(newUser);
    user.value = newUser;
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

  Future<void> clearUser() async {
    await localStorageService.clearUser();
    user.value = null;
  }
}

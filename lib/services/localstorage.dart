import 'package:art_hive_app/headers.dart';

class LocalStorageService {
  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  Future<void> saveUser(User user) async {
    try {
      await _prefs.setString('userName', user.name);
      await _prefs.setString('userEmail', user.email);
      await _prefs.setString('userPassword', user.password);
      await _prefs.setBool('isLoggedIn', user.isLoggedIn);
      if (user.imageUrl != null) {
        await _prefs.setString('userImageUrl', user.imageUrl!);
      }
    } catch (e) {
      print("*********** Error saving user to local storage: $e ***********");
    }
  }

  User? getUser() {
    try {
      final name = _prefs.getString('userName');
      final email = _prefs.getString('userEmail');
      final password = _prefs.getString('userPassword');
      final imageUrl = _prefs.getString('userImageUrl');
      final isLoggedIn = _prefs.getBool('isLoggedIn') ?? false;

      if (name != null && email != null && password != null) {
        return User(
          name: name,
          email: email,
          password: password,
          imageUrl: imageUrl,
          isLoggedIn: isLoggedIn,
        );
      }
      return null;
    } catch (e) {
      print(
          "*********** Error retrieving user from local storage: $e ***********");
      return null;
    }
  }

  Future<void> clearUser() async {
    try {
      await _prefs.remove('userName');
      await _prefs.remove('userEmail');
      await _prefs.remove('userPassword');
      await _prefs.remove('userImageUrl');
      await _prefs.remove('isLoggedIn');
    } catch (e) {
      print(
          "*********** Error clearing user from local storage: $e ***********");
    }
  }
}

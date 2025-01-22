import 'package:art_hive_app/headers.dart';
import 'database_helper.dart';
export 'package:sqflite/sqflite.dart';
export 'package:path/path.dart';

class LocalStorageService {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  Future<void> initialize() async {
    await DatabaseHelper.instance.database;
  }

  Future<void> saveUser(User user) async {
    try {
      await _dbHelper.saveUser(user);
    } catch (e) {
      print("*********** Error saving user to SQLite: $e ***********");
    }
  }

  Future<User?> getUser() async {
    try {
      return await _dbHelper.getUser();
    } catch (e) {
      print("*********** Error retrieving user from SQLite: $e ***********");
      return null;
    }
  }

  Future<void> clearUser() async {
    try {
      await _dbHelper.clearUser();
    } catch (e) {
      print("*********** Error clearing user from SQLite: $e ***********");
    }
  }
}

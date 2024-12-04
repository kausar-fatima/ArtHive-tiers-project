import 'package:art_hive_app/headers.dart';

class DatabaseHelper {
  static const _databaseName = "user_database.db";
  static const _databaseVersion = 1;
  static const table = 'user_table';

  static const columnId = '_id';
  static const columnName = 'name';
  static const columnEmail = 'email';
  static const columnPassword = 'password';
  static const columnImageUrl = 'imageUrl';
  static const columnIsLoggedIn = 'isLoggedIn';

  // Singleton pattern
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // Creating the table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnName TEXT NOT NULL,
        $columnEmail TEXT NOT NULL,
        $columnPassword TEXT NOT NULL,
        $columnImageUrl TEXT,
        $columnIsLoggedIn INTEGER NOT NULL
      )
    ''');
  }

  // Insert or update a user
  Future<void> saveUser(User user) async {
    Database db = await database;

    try {
      // Clear existing entries (ensure only one user is saved)
      await db.delete(table);

      // Insert the new user
      await db.insert(
        table,
        user.toSQLiteMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print("User saved successfully: ${user.toSQLiteMap()}");
    } catch (e) {
      print("Error saving user: $e");
    }
  }

  Future<void> updateUser(User user) async {
    Database db = await database;

    // Define the values to update
    Map<String, dynamic> updatedUser = {
      'name': user.name,
      'email': user.email,
      'password': user.password,
      'imageUrl': user.imageUrl,
      'isLoggedIn':
          user.isLoggedIn ? 1 : 0, // Store boolean as integer (1 or 0)
    };

    // Update the user where email is used as the identifier
    await db.update(
      table,
      updatedUser,
      where: 'email = ?', // assuming email is unique for each user
      whereArgs: [user.email], // passing email as the value for the placeholder
    );
  }

  // Get the user data
  Future<User?> getUser() async {
    Database db = await database;

    try {
      List<Map<String, dynamic>> result = await db.query(
        table,
        limit: 1,
      );

      if (result.isNotEmpty) {
        print("User loaded successfully: ${result.first}");
        return User.fromSQLiteMap(
            result.first); // Return the first (and only) user
      } else {
        print("No user found in the database.");
      }
    } catch (e) {
      print("Error while loading user: $e");
    }

    return null; // No user found
  }

  // Delete the user data
  Future<void> clearUser() async {
    Database db = await database;
    await db.delete(table);
  }
}

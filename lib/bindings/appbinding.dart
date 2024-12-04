import 'package:art_hive_app/headers.dart';
import 'package:art_hive_app/services/database_helper.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    print("AppBinding dependencies are being initialized."); // Debugging line

    // Initialize the SQLite database instance
    Database db = await DatabaseHelper.instance.database;

    // Using Get.put for immediate initialization
    Get.put<LocalStorageService>(LocalStorageService(db), permanent: true);
    Get.put<FirebaseService>(FirebaseService(), permanent: true);

    Get.put<UserController>(
        UserController(
            Get.find<LocalStorageService>(), Get.find<FirebaseService>()),
        permanent: true);
    Get.put<ArtworkController>(ArtworkController(), permanent: true);
  }
}

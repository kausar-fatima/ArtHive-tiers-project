import 'package:art_hive_app/headers.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    print("AppBinding dependencies are being initialized."); // Debugging line

    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Using Get.put for immediate initialization
    Get.put<LocalStorageService>(LocalStorageService(prefs));
    Get.put<FirebaseService>(FirebaseService());
    Get.put<UserController>(UserController(
        Get.find<LocalStorageService>(), Get.find<FirebaseService>()));
  }
}

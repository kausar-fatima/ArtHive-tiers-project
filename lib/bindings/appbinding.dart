import 'package:art_hive_app/headers.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put<FirebaseService>(FirebaseService(), permanent: true);
    Get.put<UserController>(UserController(), permanent: true);
    Get.put<ArtworkController>(ArtworkController(), permanent: true);
    Get.put<LocalStorageService>(LocalStorageService(), permanent: true);
  }
}

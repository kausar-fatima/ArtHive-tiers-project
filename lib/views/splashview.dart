import 'package:art_hive_app/headers.dart';
import 'package:art_hive_app/services/database_helper.dart';
import 'package:art_hive_app/views/components/bg.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  changeScreen() async {
    // Change 01: Async Functions are initilized in SPlash Screen not App Bindings
    await Get.find<LocalStorageService>().initialize();

    final UserController userController = Get.find<UserController>();
    await userController.loadUser();
    //userController.clearUser(userController.user.value!.email);
    debugPrint("After loadUser: ${userController.user.value}");
    if (userController.user.value == null ||
        userController.user.value!.isLoggedIn != true) {
      Get.offAllNamed(MyGet.login);
    } else {
      debugPrint("********${userController.user.value!.email}**********");
      debugPrint("********${userController.user.value!.name}**********");
      debugPrint("********${userController.user.value!.password}**********");
      Get.offAllNamed(MyGet.home);
    }
  }

  @override
  void initState() {
    super.initState();
    changeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Expanded(
              child: Container(
            decoration: kAppBg,
          )),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.gamepad_outlined,
                  weight: 50,
                  size: 50,
                  color: primarycolor,
                ),
                const SizedBox(height: 10),
                Text(
                  'Pak Artisan',
                  style: AppFonts.logoText,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

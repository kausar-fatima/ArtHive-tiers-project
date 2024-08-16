import 'package:art_hive_app/headers.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  changeScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      final UserController userController = Get.find<UserController>();
      userController.loadUser();
      if (userController.user.value == null ||
          userController.user.value!.isLoggedIn != true) {
        Get.offAndToNamed(MyGet.login);
      } else {
        Get.offAndToNamed(MyGet.home);
      }
    });
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
          Image.asset(
            'assets/background(3).jpg',
            fit: BoxFit.cover, // Ensures the image covers the entire screen
            width: double.infinity,
            height: double.infinity,
          ),
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
                  'ArtHive',
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
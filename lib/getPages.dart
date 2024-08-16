// ignore: file_names
import './headers.dart';

class MyGet {
  static const bool isFirstTime = true;
  static const bool isLogedIn = false;

  // names for all pages
  static const String splash = '/splash';
  static const String login = '/login';
  static const String singup = '/signup';
  static const String otp = '/otp';
  static const String forgotPassword = '/forgotPassword';
  static const String home = '/home';
  static const String myarts = '/myarts';
  // ignore: constant_identifier_names
  static const String add_editart = '/add_editart';
  static const String favorite = '/favorite';
  static const String profile = '/profile';

  static const String inital_ = splash;

  static List<GetPage> pages() => [
        GetPage(
          name: splash,
          page: () => const SplashView(),
          // binding: splashBinding(),
        ),
        GetPage(
          name: login,
          page: () => LoginView(),
          // binding: LoginBinding(),
        ),

        GetPage(
          name: singup,
          page: () => SignUpView(),
          // binding: SignupBinding(),
        ),
        GetPage(
          name: forgotPassword,
          page: () => ForgotPasswordView(),
          // binding: ForgotPassBinding(),
        ),
        GetPage(
          name: home,
          page: () => HomeView(),
          // binding: HomeBinding(),
        ),
        GetPage(
          name: myarts,
          page: () => MyArtsView(),
          // binding: MyArtsBinding(),
        ),
        // GetPage(
        //   name: add_editart,
        //   page: () => Add_EditArtView(),
        //   binding: Add_EditArtBinding(),
        // ),
        GetPage(
          name: favorite,
          page: () => FavoriteView(),
          // binding: FavoriteBinding(),
        ),
        GetPage(
          name: profile,
          page: () => ProfileView(),
          // binding: ProfileBinding(),
        ),
      ];
}

// ignore: file_names
import './headers.dart';

class MyGet {
  // names for all pages
  static const String splash = '/splash';
  static const String login = '/login';
  static const String singup = '/signup';
  static const String otp = '/otp';
  static const String forgotPassword = '/forgotPassword';
  static const String home = '/home';
  static const String myarts = '/myarts';
  static const String favorite = '/favorite';
  static const String profile = '/profile';

  static const String inital_ = splash;

  static List<GetPage> pages() => [
        GetPage(
          name: splash,
          page: () => const SplashView(),
        ),
        GetPage(
          name: login,
          page: () => LoginView(),
        ),
        GetPage(
          name: singup,
          page: () => SignUpView(),
        ),
        GetPage(
          name: forgotPassword,
          page: () => ForgotPasswordView(),
        ),
        GetPage(
          name: home,
          page: () => HomeView(),
        ),
        GetPage(
          name: myarts,
          page: () => MyArtsView(),
        ),
        GetPage(
          name: favorite,
          page: () => FavoriteView(),
        ),
        GetPage(
          name: profile,
          page: () => ProfileView(),
        ),
      ];
}

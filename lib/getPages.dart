import './headers.dart';

class MyGet {
  // names for all pages
  static const String splash = '/splash';
  static const String login = '/login';
  static const String singup = '/signup';
  static const String otp = '/otp';
  static const String forgotPassword = '/forgotPassword';
  static const String home = '/home';

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
          page: () => const HomeView(),
        ),
      ];
}

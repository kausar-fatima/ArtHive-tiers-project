import 'package:art_hive_app/headers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
      initialRoute: MyGet.inital_,
      getPages: MyGet.pages(),
      theme: ThemeData(
        cardTheme: CardTheme(
          color: Colors.white,
        ),
      ),
    );
  }
}

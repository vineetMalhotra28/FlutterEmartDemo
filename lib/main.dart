import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'consts/consts.dart';
import 'controllers/homeScreen_controller.dart';
import 'routes/routes.dart';
import 'views/auth_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var homeController = Get.put(HomeScreenController(), permanent: true);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      getPages: Routes().route,
      title: appname,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: darkFontGrey)),
        fontFamily: regular,
      ),
      home: SplashScreen(),
    );
  }
}

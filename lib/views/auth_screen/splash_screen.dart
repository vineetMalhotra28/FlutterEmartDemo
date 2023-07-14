import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

import '../../common_widget/app_logo.dart';
import '../../controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  var controller = Get.put(SpashController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  icSplashBg,
                  width: 300,
                )),
            const SizedBox(
              height: 20,
            ),
            ApplogoWidget(),
            const SizedBox(
              height: 20,
            ),
            const Text(
              appname,
              style: textStyleCommon,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              appversion,
              style: textStyleCommon,
            ),
            const Spacer(),
            Text(
              credits,
              style: textStyleCommon.copyWith(fontSize: 16),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

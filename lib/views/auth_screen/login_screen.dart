import 'package:emart_app/common_widget/app_logo.dart';
import 'package:emart_app/common_widget/custom_button.dart';
import 'package:emart_app/common_widget/custom_textfield.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

import '../../common_widget/background_widget.dart';
import '../../controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  var controller = Get.put(LoginController());
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BackGroundWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.1,
            ),
            ApplogoWidget(),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Log in to $appname',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              width: screenWidth - 70,
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                    ),
                  ],
                  color: whiteColor,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextField(
                      title: email,
                      hint: emailHint,
                      controller: emailController,
                      isPass: false),
                  CustomTextField(
                      title: password,
                      hint: passwordHint,
                      controller: passwordController,
                      isPass: true),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {}, child: const Text(forgetPasss))),
                  const SizedBox(
                    height: 5,
                  ),
                  Obx(() => Container(
                        width: screenWidth - 50,
                        child: controller.isLoading.value
                            ? Center(
                                child: const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(redColor),
                                ),
                              )
                            : CustomButton(
                                color: redColor,
                                textColor: whiteColor,
                                title: login,
                                onPress: () async {
                                  controller.isLoading.value = true;
                                  try {
                                    await controller
                                        .loginMethod(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            context: context)
                                        .then((value) {
                                      if (value != null) {
                                        Get.offAllNamed('/homeScreen');
                                      } else {
                                        controller.isLoading.value = false;
                                      }
                                      // Get.offAllNamed('/homeScreen')
                                    });
                                  } catch (e) {
                                    VxToast.show(context, msg: e.toString());
                                  }
                                },
                              ),
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    createNewAcc,
                    style: TextStyle(color: fontGrey),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: screenWidth - 50,
                    child: CustomButton(
                        onPress: () {
                          Get.toNamed('/signup');
                        },
                        color: lightGrey,
                        textColor: redColor,
                        title: signup),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'or sign in with',
                    style: TextStyle(color: fontGrey),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 50),
                    width: screenWidth - 90,
                    // color: Colors.amber,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(
                            controller.socialIconList.length,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    backgroundColor: lightGrey,
                                    radius: 25,
                                    child: Image.asset(
                                      controller.socialIconList[index],
                                      width: 30,
                                    ),
                                  ),
                                ))),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}

import 'package:emart_app/common_widget/app_logo.dart';
import 'package:emart_app/common_widget/custom_button.dart';
import 'package:emart_app/common_widget/custom_textfield.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';

import '../../common_widget/background_widget.dart';
import '../../controllers/login_controller.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  var controller = Get.put(LoginController());
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var reTypeController = TextEditingController();
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
              'join in to $appname',
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
                      title: name,
                      hint: nameHint,
                      controller: nameController,
                      isPass: false),
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
                  CustomTextField(
                    title: retypePassword,
                    hint: passwordHint,
                    controller: reTypeController,
                    isPass: true,
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {}, child: const Text(forgetPasss))),
                  Row(
                    children: [
                      Obx(
                        () => Checkbox(
                            checkColor: whiteColor,
                            activeColor: redColor,
                            value: controller.isCheck.value,
                            onChanged: (newValue) {
                              controller.isCheck.value = newValue!;
                            }),
                      ),
                      Expanded(
                        child: RichText(
                            text: const TextSpan(children: [
                          TextSpan(
                            text: 'I agreed to the',
                            style: TextStyle(color: fontGrey),
                          ),
                          TextSpan(
                            text: 'Terms and Conditions & Privacy policy',
                            style: TextStyle(color: redColor),
                          ),
                        ])),
                      ),
                    ],
                  ),
                  Container(
                      width: screenWidth - 50,
                      child: Obx(() => controller.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(redColor),
                              ),
                            )
                          : CustomButton(
                              color: controller.isCheck.value
                                  ? redColor
                                  : lightGrey,
                              textColor: whiteColor,
                              title: signup,
                              onPress: () async {
                                if (controller.isCheck.value) {
                                  controller.isLoading.value = true;
                                  try {
                                    await controller
                                        .signupMethod(emailController.text,
                                            passwordController.text, context)
                                        .then((value) {
                                      return controller.storeUserData(
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }).then((value) {
                                      VxToast.show(context, msg: loggedin);
                                      Get.offAllNamed('/homeScreen');
                                    });
                                  } catch (e) {
                                    controller.isLoading.value = false;
                                    auth.signOut();
                                    VxToast.show(context, msg: e.toString());
                                  }
                                }
                              },
                            ))),
                  const SizedBox(
                    height: 5,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    const TextSpan(
                      text: alreadyAcc,
                      style: TextStyle(color: fontGrey),
                    ),
                    TextSpan(
                        text: 'sign in',
                        style: TextStyle(color: redColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.back();
                          }),
                  ])),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}

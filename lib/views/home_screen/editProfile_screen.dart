import 'dart:io';

import 'package:emart_app/common_widget/custom_button.dart';
import 'package:emart_app/common_widget/custom_textfield.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

import '../../common_widget/background_widget.dart';
import '../../controllers/profile_controller.dart';

class EditprofileScreen extends StatelessWidget {
  EditprofileScreen({super.key});

  final controller = Get.find<PrfoileControleller>();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return BackGroundWidget(
        child: Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Container(
        color: whiteColor,
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(12),
        // margin: EdgeInsets.only(top: 100),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Obx(() => controller.profileImgLink.isEmpty
                      ? controller.profileImgPath.isEmpty
                          ? Image.asset(
                              imgProfile2,
                              width: 80,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(
                                controller.profileImgPath.value,
                              ),
                              width: 80,
                              fit: BoxFit.cover,
                            )
                      : Image.network(
                          controller.profileImgLink.value,
                          width: 80,
                          fit: BoxFit.cover,
                        ))),
              SizedBox(
                height: 10,
              ),
              CustomButton(
                  onPress: () {
                    controller.changeImage(context);
                  },
                  color: redColor,
                  textColor: whiteColor,
                  title: 'change'),
              CustomTextField(
                  title: name,
                  hint: nameHint,
                  controller: controller.nameController,
                  isPass: false),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                  title: oldPass,
                  hint: oldPass,
                  controller: controller.oldpasswordController,
                  isPass: true),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                  title: newPass,
                  hint: newPass,
                  controller: controller.newpasswordController,
                  isPass: true),
              SizedBox(
                height: 20,
              ),
              Obx(
                () => controller.isLoading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    : SizedBox(
                        width: screenWidth - 40,
                        child: CustomButton(
                            onPress: () async {
                              if (controller.oldpasswordController.text ==
                                  Get.parameters['password'].toString()) {
                                controller.isLoading(true);
                                if (controller.profileImgPath != '') {
                                  await controller.uploadProfileImage();
                                }
                                await controller.updateProfile(
                                    imageUrl: controller.profileImgLink.value,
                                    name: controller.nameController.text,
                                    password:
                                        controller.newpasswordController.text);
                                await controller.changeAuthPassword(
                                    email: controller.email,
                                    password:
                                        controller.oldpasswordController.text,
                                    newpassword:
                                        controller.newpasswordController.text);
                                VxToast.show(context, msg: 'Updated');
                              } else {
                                print(controller.oldpasswordController.text);
                                print(Get.parameters['password'].toString());
                                VxToast.show(context,
                                    msg: 'Password not match');
                              }
                            },
                            color: redColor,
                            textColor: whiteColor,
                            title: 'Save'),
                      ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

import 'package:emart_app/common_widget/custom_textfield.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../common_widget/custom_button.dart';

class ShippingScreen extends StatelessWidget {
  const ShippingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text(
          'Shipping Info',
          style: TextStyle(color: Colors.black),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: CustomButton(
            title: 'Confirm',
            color: redColor,
            textColor: whiteColor,
            onPress: () {
              Get.toNamed('PaymentScreen');
            }),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(children: [
          CustomTextField(
              title: 'Address',
              hint: 'Adsress',
              isPass: false,
              controller: controller.adressController),
          CustomTextField(
              title: 'city',
              hint: 'city',
              isPass: false,
              controller: controller.cityController),
          CustomTextField(
              title: 'state',
              hint: 'state',
              isPass: false,
              controller: controller.stateController),
          CustomTextField(
              title: 'postal',
              hint: 'postal',
              isPass: false,
              controller: controller.postalController),
          CustomTextField(
              title: 'phone',
              hint: 'phone',
              isPass: false,
              controller: controller.phoneController),
        ]),
      ),
    );
  }
}

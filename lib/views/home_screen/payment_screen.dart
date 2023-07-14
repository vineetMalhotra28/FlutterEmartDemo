import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../common_widget/custom_button.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          'Payment Screen',
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
              controller.placeMyOrder('COD', controller.totalPrice.value);
              Get.offAllNamed('/homeScreen');
              // Get.toNamed('PaymentScreen');
            }),
      ),
      body: Padding(
          padding: EdgeInsets.all(8),
          child: Obx(() => controller.orderLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: List.generate(paymentImages.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        controller.paymentIndex.value = index;
                      },
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                            border: controller.paymentIndex == index
                                ? Border.all(color: Colors.red, width: 4)
                                : null,
                            borderRadius: BorderRadius.circular(12)),
                        clipBehavior: Clip.antiAlias,
                        child: Stack(alignment: Alignment.topRight, children: [
                          Image.asset(
                            paymentImages[index],
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Transform.scale(
                              scale: 1.1,
                              child: controller.paymentIndex == index
                                  ? Checkbox(
                                      activeColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      value: true,
                                      onChanged: (Value) {})
                                  : null),
                          // Text('data')
                        ]),
                      ),
                    );
                  }),
                ))),
    );
  }
}

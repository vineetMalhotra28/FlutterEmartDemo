import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/common_widget/custom_button.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:get/get.dart';
import 'package:emart_app/services/firestore_services.dart';

import '../../common_widget/bottomBar_widget.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Shoping Cart',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: StreamBuilder(
            stream: firestoreServices.getUserCart(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return (Center(
                  child: Text('wait for data'),
                ));
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text('Cart is Empty'),
                );
              } else {
                controller.calculatePrice(snapshot.data!.docs);
                var data = snapshot.data!.docs;
                controller.productSnapshot = data;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  tileColor: darkFontGrey.withOpacity(0.1),
                                  leading: ClipRect(
                                    // clipBehavior: ,
                                    child: Image.network(
                                      data[index]['image'],
                                      width: 70,
                                    ),
                                  ),
                                  title: Text(
                                    data[index]['title'],
                                    style: TextStyle(fontSize: 20),
                                    textAlign: TextAlign.center,
                                  ),
                                  subtitle: Text(
                                    "" +
                                        data[index]['price'] +
                                        "*" +
                                        data[index]['qty'].toString() +
                                        "",
                                    textAlign: TextAlign.center,
                                  ),
                                  trailing: InkWell(
                                    child: Icon(
                                      Icons.delete,
                                      color: redColor,
                                      size: 30,
                                    ),
                                    onTap: () {
                                      controller
                                          .deleteCartProduct(data[index].id);
                                    },
                                  ),
                                );
                              })),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Price',
                              style: textStyleCart,
                            ),
                            Obx(
                              () => Text(controller.totalPrice.value.toString(),
                                  style:
                                      textStyleCart.copyWith(color: redColor)),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                                  onPressed: () {
                                    Get.toNamed('ShippingScreen');
                                  },
                                  child: Text(
                                    'Process for shipping',
                                    style: textStyleCommon,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: redColor,
                                      padding: EdgeInsets.all(8.0))))
                        ],
                      )
                    ],
                  ),
                );
              }
            }),
        bottomNavigationBar: const BottomBar(index: 3),
      ),
    );
  }
}

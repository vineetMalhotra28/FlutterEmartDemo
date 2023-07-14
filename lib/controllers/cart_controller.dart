import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/homeScreen_controller.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var totalPrice = 0.obs;
  var adressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postalController = TextEditingController();
  var phoneController = TextEditingController();

  var paymentIndex = 0.obs;

  dynamic productSnapshot;
  var products = [];
  var orderLoading = false.obs;

  calculatePrice(data) {
    Future.delayed(Duration(milliseconds: 100), () {
      totalPrice.value = 0;
      for (var i = 0; i < data.length; i++) {
        totalPrice.value +=
            (int.parse(data[i]['price']) * data[i]['qty']).toInt();
      }
      print(totalPrice.value);
    });
  }

  deleteCartProduct(cart_id) {
    FirebaseFirestore.instance.collection('carts').doc(cart_id).delete();
  }

  placeMyOrder(paymentMethod, totalAmount) async {
    orderLoading(true);
    await allProducts();
    await firestore.collection(emartorders).doc().set({
      'order_code': '22277732i',
      'order_date': FieldValue.serverTimestamp(),
      'order_by': currentUser!.uid,
      'order_by_name': Get.find<HomeScreenController>().username,
      'order_by_email': currentUser!.email,
      'order_by_address': adressController.text,
      'order_by_state': stateController.text,
      'order_by_city': cityController.text,
      'order_by_phone': phoneController.text,
      'order_by_postalcode': postalController.text,
      'shipping_method': paymentMethod,
      'order_placed': true,
      'total_amount': totalAmount,
      'order_confirmed': false,
      'order_delivered': false,
      'order_on_deliver': false,
      'orders': FieldValue.arrayUnion(products)
    });
    await clearCart();
    orderLoading(false);
  }

  allProducts() {
    products.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        'color': productSnapshot[i]['color'],
        'image': productSnapshot[i]['image'],
        'price': productSnapshot[i]['price'],
        'product_id': productSnapshot[i]['product_id'],
        'qty': productSnapshot[i]['qty'],
        'title': productSnapshot[i]['title'],
        'vendor_id': productSnapshot[i]['vendor_id'],
        'total_price': productSnapshot[i]['total_price'],
      });
    }

    // print(products);
  }

  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      // print(productSnapshot[i].id);
      firestore
          .collection(emartproductCart)
          .doc(productSnapshot[i].id)
          .delete();
    }
  }
}

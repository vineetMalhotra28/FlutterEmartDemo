import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../consts/fireBase_const.dart';

class ProductController extends GetxController {
  // late StreamController catController;

  StreamController<List> catController = StreamController<List>.broadcast();
  var subcat = [];
  // QueryDocumentSnapshot product = {} as QueryDocumentSnapshot<Object?>;
  Map productData = {};
  var qty = 0.obs;
  var total_price = 0.obs;
  var colorIndex = 0.obs;
  var wishlist = false.obs;
  var ProductdocId = ''.obs;
  // var color = ''.obs;
  @override
  void onInit() {
    // language Prefernce
    // CheckUserConnection();
    catController = new StreamController();
    // getCategoriesLaravel();

    super.onInit();
  }

  @override
  void onReady() {
    print('readyyyyyyyyyyyyy');
    qty.value = 0;
    total_price.value = 0;
  }

  @override
  void onClose() {
    // closeStream();
    // ProductController.dispose();
    print('endClose');
    super.onClose();
  }

  Future<void> closeStream() => catController.close();

  getSubCategories(title) async {
    subcat.clear();
    var data = await rootBundle.loadString('lib/services/category_model.json');
    var decoded = categoryModelFromJson(data);
    var s =
        decoded.categories.where((element) => element.name == title).toList();
    if (s.isEmpty) {
      subcat = ['cars', 'bikes', 'parent'];
    } else {
      for (var e in s[0].subcategory) {
        subcat.add(e);
      }
    }
  }

  getCategoriesLaravel() async {
    // print('start');
    var jsonResponse;
    try {
      var jsonResponse;
      var response = await http.get(
          Uri.parse('http://192.168.29.245:80/api/getCategories'),
          headers: {"Accept": "application/json"});
      jsonResponse = json.decode(response.body);
      var message = jsonResponse["message"];
      // print(jsonResponse);
      if (response.statusCode == 200) {
        catController.add(jsonResponse['data']);
        print(jsonResponse['data']);
        return jsonResponse['data'];
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        print(message);
        // return jsonResponse['data'];
      } else {
        print('server_error');
        // return jsonResponse['data'];
      }
    } catch (err) {
      print(err.toString());
      print('server_errosssr');
      // return null
    }
  }

  changeQty(
      {required prod_price, required int prod_qty, required int avail_qty}) {
    if (qty.value < 1 && prod_qty < 1) {
    } else {
      int checkqty = qty.value + prod_qty;
      if (checkqty > avail_qty) {
        print('stock not avaialble');
      } else {
        qty.value += prod_qty;
        total_price.value = int.parse(prod_price) * qty.value;
      }
    }
  }

  addToCart({product_id, image, color, price, title, vendor_id}) {
    FirebaseFirestore.instance
        .collection(emartproductCart)
        .where('product_id', isEqualTo: product_id)
        .where('user_id', isEqualTo: currentUser!.uid)
        .where('color', isEqualTo: color)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        print('blank');
        var firestore = FirebaseFirestore.instance.collection('carts').doc();
        // var store = firestore.doc();

        // saving data in users->1234->
        firestore.set({
          'product_id': product_id,
          'user_id': currentUser!.uid,
          'color': color,
          'image': image,
          'qty': qty.value,
          'price': price,
          'title': title,
          'vendor_id': vendor_id,
          'total_price': (int.parse(price) * qty.value)
        });
      } else {
        // value.docs;
        // print(value.docs[0].id);
        print('Not blank');
        var firestore = FirebaseFirestore.instance
            .collection('carts')
            .doc(value.docs[0].id);
        // var store = firestore.doc();

        // saving data in users->1234->
        firestore.update({
          'product_id': product_id,
          'user_id': currentUser!.uid,
          'color': color,
          'image': image,
          'qty': qty.value,
          'price': price,
          'title': title,
          'vendor_id': vendor_id,
          'total_price': (int.parse(price) * qty.value)
        });
        // print(value);
      }
    });
  }

  addToWishlist(docId) async {
    wishlist.value = true;
    await firestore.collection(emartproductList).doc(docId).set({
      'product_wishlist': FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
  }

  removeToWishlist(docId) async {
    wishlist.value = false;
    await firestore.collection(emartproductList).doc(docId).set({
      'product_wishlist': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
  }

  changeWidhList() {
    var docId = ProductdocId.value;
    if (!wishlist.value) {
      addToWishlist(docId);
      wishlist.value = true;
    } else {
      removeToWishlist(docId);
      wishlist.value = false;
    }
  }

  checkWishList(data) {
    Future.delayed(Duration(milliseconds: 100), () {
      // totalPrice.value = 0;
      for (var i = 0; i < data.length; i++) {
        if (data[i] == currentUser!.uid) {
          wishlist.value = true;
        }
      }
      // print(totalPrice.value);
    });
  }
}

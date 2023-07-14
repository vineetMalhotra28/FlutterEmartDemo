import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:emart_app/services/firestore_services.dart';

class PrfoileControleller extends GetxController {
  var profileImgPath = ''.obs;
  var profileImgLink = ''.obs;
  var isLoading = false.obs;
  var email = '';
  var nameController = TextEditingController();
  var oldpasswordController = TextEditingController();
  var newpasswordController = TextEditingController();
  var cartTotal = 0.obs;
  var orderTotal = 0.obs;
  var wishlistTotal = 0.obs;
  @override
  void onInit() {
    getCartTotal();
    getOrderTotal();
    getWishlistTotal();
    super.onInit();
  }

  changeImage(context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) return;
      profileImgPath.value = img.path;
      print('image-----$profileImgPath');
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadProfileImage() async {
    var fileName = basename(profileImgPath.value);
    var destination = "images/${currentUser!.uid}/$fileName";
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImgPath.value));
    profileImgLink.value = await ref.getDownloadURL();
  }

  updateProfile({name, password, imageUrl}) async {
    var store = firestore.collection(usersCollection).doc(currentUser!.uid);
    await store.set({'name': name, 'password': password, 'imageUrl': imageUrl},
        SetOptions(merge: true));
    isLoading.value = false;
  }

  changeAuthPassword({email, password, newpassword}) async {
    final cred = EmailAuthProvider.credential(email: email, password: password);

    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newpassword);
    }).catchError((onError) {
      print('error$onError');
    });
  }

  getCartTotal() async {
    var cart = await firestore
        .collection(emartproductCart)
        .where('user_id', isEqualTo: currentUser!.uid)
        .get();

    if (cart.docs.isEmpty) {
      // print(cart.docs.length);
    } else {
      cartTotal.value = cart.docs.length;
      // print('cart');
      // print(cartTotal.value);
    }
  }

  getOrderTotal() async {
    var order = await firestore
        .collection(emartorders)
        .where('order_by', isEqualTo: currentUser!.uid)
        .get();

    if (order.docs.isEmpty) {
      // print(cart.docs.length);
    } else {
      orderTotal.value = order.docs.length;
      // print('order');
      // print(orderTotal.value);
    }
  }

  getWishlistTotal() async {
    var widhlist = await firestore
        .collection(emartproductList)
        .where('product_wishlist', arrayContains: currentUser!.uid)
        .get();

    if (widhlist.docs.isEmpty) {
      // print(cart.docs.length);
    } else {
      wishlistTotal.value = widhlist.docs.length;
      // print('wishlist');
      // print(wishlistTotal.value);
    }
  }
}

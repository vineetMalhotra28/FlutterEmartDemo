import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../consts/consts.dart';
import '../consts/get_storage_strings.dart';

class LoginController extends GetxController {
  var login = '';
  var isCheck = false.obs;
  var isLoading = false.obs;
  var socialIconList = [icGoogleLogo, icFacebookLogo, icTwitterLogo];
  final _getStorage = GetStorage();
  @override
  void onInit() {
    super.onInit();
  }

  Future<UserCredential?> loginMethod({email, password, context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  Future<UserCredential?> signupMethod(email, password, context) async {
    UserCredential? userCredential;

    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  // Storing data in cloud
  storeUserData({name, email, password}) async {
    DocumentReference store =
        firestore.collection(usersCollection).doc(currentUser?.uid);
    store.set({
      'name': name,
      'email': email,
      'password': password,
      'imageUrl': '',
      'id': currentUser?.uid,
      'cart_count': '0',
      'order_count': '0',
      'wishlist_count': '0',
    });
  }

  signoutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}

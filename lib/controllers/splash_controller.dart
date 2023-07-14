import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../consts/get_storage_strings.dart';
import 'package:emart_app/consts/consts.dart';

class SpashController extends GetxController {
  var login = '';
  final _getStorage = GetStorage();
  @override
  void onInit() {
    transferUser();

    super.onInit();
  }

  Future<bool> getUserDetails() async =>
      _getStorage.read(GetStorageKey.login) ?? false;

  transferUser() {
    Future.delayed(const Duration(seconds: 2), () async {
      // await getUserDetails() ? Get.toNamed("/login") : Get.toNamed("/login");
      await auth.authStateChanges().listen((user) {
        if (user == null) {
          Get.toNamed("/login");
        } else {
          Get.toNamed("/homeScreen");
        }
      });

      // Do something
    });
  }
}

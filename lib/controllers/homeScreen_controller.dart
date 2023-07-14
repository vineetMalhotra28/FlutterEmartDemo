import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:emart_app/consts/consts.dart';

class HomeScreenController extends GetxController {
  var username = '';
  var searchText = TextEditingController();
  var searchdata = [].obs;
  dynamic searchSnapshot;
  @override
  void onInit() {
    getUsername();

    super.onInit();
  }

  getUsername() async {
    await auth.authStateChanges().listen((user) {
      if (user == null) {
        username = 'User';
      } else {
        var firestore = FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser!.uid);
        // var data = await firestore.get();
        // print(data.data()!['name']);
        firestore.get().then((value) {
          username = value.data()!['name'];
        });
      }
    });
  }
}

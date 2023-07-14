import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/homeScreen_controller.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  var chats = firestore.collection(emartchats);

  var friendName = Get.parameters['friendName'].toString();
  var friendId = Get.parameters['friendId'].toString();

  var currentName = Get.find<HomeScreenController>().username;
  var currentId = currentUser!.uid;

  var msgController = TextEditingController();

  dynamic chatDocId;

  var isLoading = false.obs;
  @override
  void onInit() {
    getChatId();
    super.onInit();
  }

  getChatId() async {
    isLoading(true);
    await chats
        .where('users', isEqualTo: {friendId: null, currentId: null})
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) {
          if (snapshot.docs.isNotEmpty) {
            // chatDocId = snapshot.docs[0].id;
            chatDocId = snapshot.docs.single.id;
          } else {
            chats.add({
              'created_on': null,
              'last_msg': '',
              'users': {friendId: null, currentId: null},
              'toId': '',
              'friendName': friendName,
              'sender_name': currentName
            }).then((value) => chatDocId = value.id);
          }
        });
    isLoading(false);
  }

  sendMessage(String msg) async {
    if (msg.trim().isNotEmpty) {
      chats.doc(chatDocId).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'toId': friendId,
        'fromId': currentId
      });
      chats.doc(chatDocId).collection(emartmessages).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': currentId
      });
    }
  }
}

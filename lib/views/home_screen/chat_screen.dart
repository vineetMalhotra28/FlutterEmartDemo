import 'package:emart_app/consts/consts.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../components/sendMessage.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../controllers/chat_controller.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text('Username'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: Container(
                    // color: Colors.teal,
                    child: Obx(
              () => controller.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : StreamBuilder(
                      stream: firestoreServices
                          .getChatMessage(controller.chatDocId),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(redColor),
                            ),
                          );
                        } else {
                          return ListView(
                            children: snapshot.data!.docs
                                .mapIndexed((currentValue, index) {
                              var data = snapshot.data!.docs[index];
                              return Align(
                                alignment: data['uid'] == currentUser!.uid
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: SendMessage(data),
                              );
                            }).toList(),
                          );
                        }
                      }),
            ))),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    TextFormField(
                      controller: controller.msgController,
                      decoration: const InputDecoration(
                        hintText: "Type a message",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: textfieldGrey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: textfieldGrey)),
                      ),
                    )
                  ],
                )),
                IconButton(
                    onPressed: () {
                      controller.sendMessage(controller.msgController.text);
                      controller.msgController.clear();
                    },
                    icon: Icon(Icons.send))
              ],
            )
          ],
        ),
      ),
    );
  }
}

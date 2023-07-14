import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class MessagingScreen extends StatelessWidget {
  const MessagingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(title: Text('Seller chat')),
        body: StreamBuilder(
            stream: firestoreServices.getUserMessages(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return (Center(
                  child: Text('wait for data'),
                ));
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text('chat is Empty'),
                );
              } else {
                // controller.calculatePrice(snapshot.data!.docs);
                var data = snapshot.data!.docs;
                // print(data[0]);
                // controller.productSnapshot = data;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return Divider(
                          thickness: 4,
                          color: Colors.black,
                        );
                      },
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Get.toNamed('ChatScreen', parameters: {
                              "friendName": data[index]['sender_name'],
                              "friendId": data[index]['toId']
                            });
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: whiteColor,
                              child: Image.asset(
                                'assets/images/user.png',
                                width: 80,
                                height: 80,
                              ),
                            ),
                            title: Text(data[index]['sender_name']),
                            subtitle: Text(data[index]['last_msg']),
                            trailing: Text(intl.DateFormat()
                                .add_yMd()
                                .format(data[index]['created_on'].toDate())),
                          ),
                        );
                      }),
                );
              }
            }));
  }
}

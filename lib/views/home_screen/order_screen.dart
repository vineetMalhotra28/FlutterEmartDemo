import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:get/get.dart';

class UserOrderScreen extends StatelessWidget {
  const UserOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: Text('My Orders'),
        ),
        body: StreamBuilder(
            stream: firestoreServices.getUserOrders(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  ),
                );
              } else if (snapshot.data!.docs.length < 1) {
                return const Center(child: Text('No Products in orders'));
              } else {
                var data = snapshot.data!.docs;
                return Container(
                  padding: EdgeInsets.all(8.0),
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          tileColor: lightGrey,
                          leading: Text(
                            index.toString(),
                            style: textStyleCart.copyWith(fontFamily: regular),
                          ),
                          title: Text(
                            data[index]['order_code'],
                            style: textStyleCart,
                            textAlign: TextAlign.center,
                          ),
                          // subtitle: data[index]['total_price'],
                          trailing: IconButton(
                            onPressed: () {
                              Get.toNamed('OrderDetails',
                                  parameters: {"order_id": data[index].id});
                            },
                            icon: Icon(Icons.arrow_forward_ios_rounded),
                            tooltip: data[index]['order_code'],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          color: darkFontGrey,
                        );
                      },
                      itemCount: data.length),
                );
              }
            }));
  }
}

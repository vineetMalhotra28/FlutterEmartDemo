import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:get/get.dart';

class userWishlistScreen extends StatelessWidget {
  const userWishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: Text('My Wishlist'),
        ),
        body: StreamBuilder(
            stream: firestoreServices.getUserWishlistt(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  ),
                );
              } else if (snapshot.data!.docs.length < 1) {
                return const Center(child: Text('No Products in wishlist'));
              } else {
                var data = snapshot.data!.docs;
                return Container(
                  padding: EdgeInsets.all(8.0),
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          tileColor: lightGrey,
                          leading: Image.network(
                            data[index]['product_images'][0],
                            width: 50,
                          ),
                          title: Text(
                            data[index]['product_name'],
                            style: textStyleCart,
                            textAlign: TextAlign.center,
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                Get.toNamed('productDetailScreen', parameters: {
                                  "title": data[index]['product_name'],
                                  "product_id":
                                      data[index]['category_id'].toString(),
                                });
                              },
                              icon: Icon(Icons.arrow_forward_ios_rounded)),
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

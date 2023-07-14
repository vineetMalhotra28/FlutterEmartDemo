import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/common_widget/background_widget.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:get/get.dart';

import '../../common_widget/bottomBar_widget.dart';
import '../../components/cartItem_button.dart';
import '../../controllers/login_controller.dart';
import '../../controllers/profile_controller.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});
  final controller = Get.put(PrfoileControleller());
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BackGroundWidget(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text('Acoount'),
        // ),
        body: StreamBuilder(
          stream: firestoreServices.getUser(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else {
              var data = snapshot.data!.docs[0];
              return SafeArea(
                child: Column(children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        child: const Icon(
                          Icons.edit,
                          color: whiteColor,
                        ),
                        onTap: () {
                          controller.nameController.text = data['name'];
                          controller.email = data['email'];
                          controller.profileImgLink.value = data['imageUrl'];
                          Get.toNamed('editProfileScreen', parameters: {
                            "name": data['name'],
                            "password": data['password']
                          });
                        },
                      )),
                  Row(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: data['imageUrl'] == ''
                              ? Image.asset(
                                  imgProfile2,
                                  width: 80,
                                )
                              : Image.network(
                                  data['imageUrl'],
                                  width: 80,
                                )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            '${data['name']}',
                            style: const TextStyle(
                                color: whiteColor, fontFamily: semibold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text('${data['email']}',
                              style: const TextStyle(
                                  color: whiteColor, fontFamily: semibold)),
                        ],
                      )),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(color: whiteColor)),
                          onPressed: () async {
                            await Get.put(
                                LoginController().signoutMethod(context));
                            Get.offAllNamed('/login');
                          },
                          child: const Text(logout,
                              style: TextStyle(
                                  color: whiteColor, fontFamily: semibold)))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.toNamed('userCartScreen');
                              },
                              child: CartItemButton(
                                  contextWidth: screenWidth,
                                  itemCount: '${controller.cartTotal}',
                                  title: 'in your cart'),
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed('userOrderScreen');
                              },
                              child: CartItemButton(
                                  contextWidth: screenWidth,
                                  itemCount: '${controller.orderTotal}',
                                  title: 'your orders'),
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed('userWishlistScreen');
                              },
                              child: CartItemButton(
                                  contextWidth: screenWidth,
                                  itemCount: '${controller.wishlistTotal}',
                                  title: 'in your wishlist'),
                            ),
                          ])),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    color: redColor,
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2.0,
                          ),
                        ],
                      ),
                      child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: profileButtonList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              if (index == 0) {
                                Get.toNamed('userWishlistScreen');
                              } else if (index == 1) {
                                Get.toNamed('userOrderScreen');
                              } else {
                                Get.toNamed('userMessageScreen');
                              }
                            },
                            leading: Image.asset(
                              profileButtonIcons[index],
                              width: 20,
                            ),
                            title: Text(profileButtonList[index],
                                style: TextStyle(
                                    color: darkFontGrey, fontFamily: bold)),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            // height: 7,
                            color: darkFontGrey,
                          );
                        },
                      ),
                    ),
                  ),
                  // Buttons sections
                ]),
              );
            }
          },
        ),
        bottomNavigationBar: const BottomBar(index: 2),
      ),
    );
  }
}

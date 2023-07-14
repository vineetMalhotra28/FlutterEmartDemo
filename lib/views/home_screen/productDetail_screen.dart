import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/common_widget/custom_button.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:get/get.dart';
import 'package:emart_app/services/firestore_services.dart';

class ProductdetailScreen extends StatelessWidget {
  ProductdetailScreen({super.key});
  var controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    controller.qty.value = 0;
    controller.total_price.value = 0;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          Get.parameters['title'].toString(),
          style: const TextStyle(color: darkFontGrey),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share),
          ),
          Obx(() => IconButton(
                onPressed: () {
                  controller.changeWidhList();
                },
                icon: controller.wishlist.value
                    ? Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.red,
                      ),
              ))
        ],
      ),
      body: StreamBuilder(
          stream:
              firestoreServices.getProductDetails(Get.parameters['product_id']),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return (Center(
                child: Text('wait for data'),
              ));
            } else {
              // print(snapshot.data!.docs);
              var data = snapshot.data!.docs[0];

              controller.ProductdocId.value = data.id;
              controller.checkWishList(data['product_wishlist']);
              // print(Colors.pink.value);
              return Column(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          VxSwiper.builder(
                              aspectRatio: 16 / 9,
                              autoPlay: true,
                              height: 350,
                              enlargeCenterPage: true,
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              autoPlayInterval: const Duration(seconds: 2),
                              itemCount: data['product_images'].length,
                              itemBuilder: (context, index) {
                                return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(
                                        data['product_images'][index],
                                        fit: BoxFit.cover,
                                      ),
                                    ));
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            data['product_name'],
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          VxRating(
                            isSelectable: false,
                            onRatingUpdate: (ValueKey) {},
                            normalColor: textfieldGrey,
                            selectionColor: golden,
                            value: double.parse(data['product_rating']),
                            size: 25,
                            maxRating: 5,
                            stepInt: false,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "\$" + data['product_price'] + "",
                            style: TextStyle(color: redColor, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            color: textfieldGrey,
                            height: 60,
                            child: Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    const Text(
                                      'Seller',
                                      style: TextStyle(color: whiteColor),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      data['seller_name'].toString(),
                                      style: TextStyle(
                                          color: darkFontGrey, fontSize: 20),
                                    ),
                                  ],
                                )),
                                InkWell(
                                  child: const CircleAvatar(
                                    backgroundColor: whiteColor,
                                    child: Icon(
                                      Icons.message_rounded,
                                      color: darkFontGrey,
                                    ),
                                  ),
                                  onTap: () {
                                    Get.toNamed('ChatScreen', parameters: {
                                      "friendName": data['seller_name'],
                                      "friendId": data['seller_id']
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          // color section
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            color: whiteColor,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                        child: Text(
                                          'Color',
                                          style: TextStyle(
                                              color: darkFontGrey,
                                              fontSize: 15),
                                        ),
                                      ),
                                      Obx(() => Row(
                                            children: List.generate(
                                                data['product_colors'].length,
                                                (index) => Stack(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            controller
                                                                .colorIndex
                                                                .value = index;
                                                          },
                                                          child: Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        4),
                                                            height: 40,
                                                            width: 40,
                                                            decoration: BoxDecoration(
                                                                color: Color(data[
                                                                            'product_colors']
                                                                        [index])
                                                                    .withOpacity(
                                                                        1.0),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            20))),
                                                            child: Center(
                                                                child:
                                                                    Visibility(
                                                              visible: index ==
                                                                  controller
                                                                      .colorIndex
                                                                      .value,
                                                              child: Icon(
                                                                Icons.done,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            )),
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                          )),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                        child: Text(
                                          'Quantity',
                                          style: TextStyle(
                                              color: darkFontGrey,
                                              fontSize: 15),
                                        ),
                                      ),
                                      Obx(() => Row(children: [
                                            IconButton(
                                                onPressed: () {
                                                  controller.changeQty(
                                                      prod_price:
                                                          data['product_price'],
                                                      prod_qty: -1,
                                                      avail_qty:
                                                          data['productQty']);
                                                },
                                                icon: const Icon(Icons.remove)),
                                            Text(controller.qty.value
                                                .toString()),
                                            IconButton(
                                                onPressed: () {
                                                  controller.changeQty(
                                                      prod_price:
                                                          data['product_price'],
                                                      prod_qty: 1,
                                                      avail_qty:
                                                          data['productQty']);
                                                },
                                                icon: const Icon(Icons.add)),
                                            Text("" +
                                                controller.qty.value
                                                    .toString() +
                                                " Selected"),
                                          ])),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                        child: Text(
                                          'Total Price',
                                          style: TextStyle(
                                              color: darkFontGrey,
                                              fontSize: 15),
                                        ),
                                      ),
                                      // ignore: prefer_const_literals_to_create_immutables
                                      Row(children: [
                                        Obx(() => Text(
                                              "\$" +
                                                  controller.total_price.value
                                                      .toString() +
                                                  "",
                                              style: TextStyle(
                                                  color: redColor,
                                                  fontSize: 16),
                                            )),
                                      ]),
                                    ],
                                  ),
                                ),

                                // description
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                        child: Text(
                                          'Description',
                                          style: TextStyle(
                                              color: darkFontGrey,
                                              fontSize: 15),
                                        ),
                                      ),
                                      // ignore: prefer_const_literals_to_create_immutables
                                      Expanded(
                                        // ignore: prefer_const_literals_to_create_immutables
                                        child: Column(children: [
                                          Text(
                                            data['product_desc'].toString(),
                                            style: TextStyle(
                                                color: fontGrey, fontSize: 16),
                                          ),
                                        ]),
                                      ),
                                    ],
                                  ),
                                ),
                                ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: productTiles.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(productTiles[index]),
                                      trailing: const Icon(Icons.arrow_forward),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const Divider(
                                      // height: 7,
                                      color: darkFontGrey,
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(
                                        5,
                                        (index) => Container(
                                              margin: EdgeInsets.all(5),
                                              decoration: const BoxDecoration(
                                                  color: whiteColor,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              padding: const EdgeInsets.all(4),
                                              // height: 100,
                                              // width: 100,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    imgP1,
                                                    width: 150,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  const SizedBox(width: 10),
                                                  const Text(
                                                    "Laptop 4GB/64GB",
                                                    style: TextStyle(
                                                        fontFamily: semibold,
                                                        color: darkFontGrey),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  const Text(
                                                    "\$100",
                                                    style: TextStyle(
                                                        fontFamily: semibold,
                                                        color: redColor),
                                                  ),
                                                ],
                                              ),
                                            )),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
                  Container(
                    width: double.infinity,
                    color: redColor,
                    // ignore: sort_child_properties_last
                    child: Align(
                        alignment: Alignment.center,
                        child: CustomButton(
                            onPress: () {
                              if (controller.qty > 0) {
                                controller.addToCart(
                                    product_id: data.id,
                                    image: data['product_images'][0],
                                    color: data['product_colors']
                                        [controller.colorIndex.value],
                                    price: data['product_price'],
                                    title: data['product_name'],
                                    vendor_id: data['seller_id']);
                              }
                            },
                            color: redColor,
                            title: add_to_cart,
                            textColor: whiteColor)),
                    height: 50,
                  )
                ],
              );
            }
          }),
    );
  }
}

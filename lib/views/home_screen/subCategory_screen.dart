import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:get/get.dart';

import '../../common_widget/background_widget.dart';

class SubCategoryScreen extends StatelessWidget {
  SubCategoryScreen({super.key});
  var controller = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return BackGroundWidget(
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                Get.parameters['title'].toString(),
              ),
            ),
            body: Container(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          controller.subcat.length,
                          (index) => Container(
                                decoration: const BoxDecoration(
                                    color: whiteColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                width: 120,
                                height: 60,
                                child: Center(
                                  child: Text(controller.subcat[index]),
                                ),
                              )),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                      child: StreamBuilder(
                          stream: firestoreServices
                              .getProductList(Get.parameters['category_id']),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return (Center(
                                child: Text('wait for data'),
                              ));
                            } else {
                              var data = snapshot.data!.docs;
                              // print(snapshot.data!.docs);
                              return GridView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: BouncingScrollPhysics(),
                                  // physics: const NeverScrollableScrollPhysics(),
                                  itemCount: data.length,
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 8,
                                          crossAxisSpacing: 1,
                                          mainAxisExtent: 250),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      child: Container(
                                        margin: const EdgeInsets.all(8),
                                        color: whiteColor,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.network(
                                              data[index]['product_images'][0],
                                              width: 200,
                                              height: 150,
                                              fit: BoxFit.cover,
                                            ),
                                            Text(
                                              data[index]['product_name']
                                                  .toString(),
                                              style: TextStyle(
                                                  fontFamily: semibold,
                                                  color: darkFontGrey),
                                            ),
                                            // const SizedBox(height: 10),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        Get.toNamed('productDetailScreen',
                                            parameters: {
                                              "title": 'Laptop 4GB/64GB',
                                              "product_id": data[index]
                                                      ['category_id']
                                                  .toString(),
                                            });
                                      },
                                    );
                                  });
                            }
                          }))
                ],
              ),
            )));
  }
}

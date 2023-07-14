import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:get/get.dart';
import 'package:emart_app/services/firestore_services.dart';

import '../../common_widget/background_widget.dart';
import '../../common_widget/bottomBar_widget.dart';

class Caetegoryscreen extends StatelessWidget {
  Caetegoryscreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return BackGroundWidget(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Category'),
      ),
      body: StreamBuilder(
        stream: firestoreServices.getCategories(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return (Center(
              child: Text('wait for data'),
            ));
          } else {
            var data = snapshot.data!.docs;
            // print(snapshot.data!.docs);
            return SafeArea(
              child: Container(
                padding: EdgeInsets.all(8),
                child: GridView.builder(
                    itemCount: data.length,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            mainAxisExtent: 250),
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          color: whiteColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                data[index]['category_image'],
                                width: 200,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  data[index]['category_name'],
                                  style: const TextStyle(
                                    fontFamily: semibold,
                                    color: darkFontGrey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          //  rint(data[index].id);
                          //   return; p
                          controller.getSubCategories(categoryString[index]);
                          Get.toNamed('subcategoryScreen', parameters: {
                            "title": categoryString[index],
                            "category_id": data[index].id.toString()
                          });
                        },
                      );
                    }),
              ),
            );
          }
        },
      ),
      bottomNavigationBar: const BottomBar(index: 1),
    ));
  }
}

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:get/get.dart';

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
          stream: controller.catController.stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // if (!snapshot.hasData) {
            //   return (Center(
            //     child: Text('wait for data'),
            //   ));
            // } else {
            return SafeArea(
              // child: Container(
              //   padding: EdgeInsets.all(8),
              //   child: GridView.builder(
              //       itemCount: snapshot.data.length,
              //       shrinkWrap: true,
              //       gridDelegate:
              //           const SliverGridDelegateWithFixedCrossAxisCount(
              //               crossAxisCount: 3,
              //               mainAxisSpacing: 8,
              //               crossAxisSpacing: 8,
              //               mainAxisExtent: 250),
              //       itemBuilder: (context, index) {
              //         return InkWell(
              //           child: Container(
              //             padding: EdgeInsets.all(8),
              //             color: whiteColor,
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Image.asset(
              //                   categoryImages[index],
              //                   width: 200,
              //                   height: 150,
              //                   fit: BoxFit.cover,
              //                 ),
              //                 const SizedBox(height: 10),
              //                 Align(
              //                   alignment: Alignment.center,
              //                   child: Text(
              //                     snapshot.data[index]['name'],
              //                     style: const TextStyle(
              //                       fontFamily: semibold,
              //                       color: darkFontGrey,
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //           onTap: () {
              //             controller.getSubCategories(categoryString[index]);
              //             Get.toNamed('subcategoryScreen', parameters: {
              //               "title": categoryString[index],
              //             });
              //           },
              //         );
              //       }),
              // ),
              child: Container(
                padding: EdgeInsets.all(8),
                child: GridView.builder(
                    itemCount: 9,
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
                              Image.asset(
                                categoryImages[index],
                                width: 200,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  categoryString[index],
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
                          controller.getSubCategories(categoryString[index]);
                          Get.toNamed('subcategoryScreen', parameters: {
                            "title": categoryString[index],
                          });
                        },
                      );
                    }),
              ),
            );
          }
          // },
          ),
      bottomNavigationBar: const BottomBar(index: 1),
    ));
  }
}

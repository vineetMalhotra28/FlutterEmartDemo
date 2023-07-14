import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../common_widget/custom_textfield.dart';
import '../../controllers/homeScreen_controller.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeScreenController>();
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
          child: Container(
        child: Column(children: [
          TextFormField(
              decoration: const InputDecoration(
                  hintStyle:
                      TextStyle(fontFamily: semibold, color: textfieldGrey),
                  hintText: 'Mens Fashion',
                  isDense: true,
                  fillColor: lightGrey,
                  filled: true,
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: redColor))),
              onChanged: (value) {
                if (value.length > 0) {
                  firestoreServices
                      .getSearchProduct(value)
                      .then((value_product) {
                    if (value_product.docs.isEmpty) {
                      controller.searchdata.clear();
                    } else {
                      controller.searchdata.clear();
                      for (var i = 0; i < value_product.docs.length; i++) {
                        controller.searchdata.value.add({
                          'image': value_product.docs[i]['product_images'][0],
                          'product_name': value_product.docs[i]['product_name'],
                          'category_id': value_product.docs[i]['category_id'],
                          'product_id': value_product.docs[i].id,
                        });
                      }
                      print(controller.searchdata.value);
                      print('length');
                      print(controller.searchdata.length);
                    }
                    print('length');
                    print(controller.searchdata.length);
                  });
                }
              }),
          Obx(() => controller.searchdata.length > 0
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.searchdata.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Get.toNamed('productDetailScreen', parameters: {
                          "title": controller.searchdata[index]['product_name'],
                          "product_id": controller.searchdata[index]
                              ['category_id'],
                        });
                      },
                      leading: Image.network(
                          controller.searchdata.value[index]['image']),
                      title: Text(controller.searchdata[index]['product_name']),
                      // leading: Image.network(
                      //     controller.searchdata.value[index]['product_image']),
                      // title: Text(
                      //     controller.searchdata.value[index]['product_name']),
                    );
                  })
              : ListTile(
                  // isThreeLine: true,
                  leading: Image.asset('assets/images/s5.jpg'),
                  title: Text('No data found'),
                ))
        ]),
      )),
    );
  }
}

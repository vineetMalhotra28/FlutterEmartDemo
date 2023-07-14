import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/components/featured_button.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

import '../../common_widget/bottomBar_widget.dart';
import '../../common_widget/home_button.dart';
import 'package:emart_app/services/firestore_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(12),
          height: screenHeight,
          width: screenWidth,
          color: lightGrey,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 60,
                color: lightGrey,
                child: InkWell(
                    onTap: () {
                      Get.toNamed('searchScreen');
                    },
                    child: ListTile(
                      title: Text('Search here'),
                      leading: Icon(Icons.search),
                    )),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      VxSwiper.builder(
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          height: 150,
                          enlargeCenterPage: true,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayInterval: const Duration(seconds: 2),
                          itemCount: homeBanner1.length,
                          itemBuilder: (context, index) {
                            return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.asset(
                                    homeBanner1[index],
                                    fit: BoxFit.fill,
                                  ),
                                ));
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                            2,
                            (index) => HomeButton(
                                height: screenHeight * 0.15,
                                width: screenWidth / 2.5,
                                icon: index == 0 ? icTodaysDeal : icFlashDeal,
                                title: index == 0 ? todatdeal : flashsale,
                                onPress: () {})),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      VxSwiper.builder(
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          height: 150,
                          enlargeCenterPage: true,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayInterval: const Duration(seconds: 2),
                          itemCount: homeBanner2.length,
                          itemBuilder: (context, index) {
                            return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.asset(
                                    homeBanner2[index],
                                    fit: BoxFit.fill,
                                  ),
                                ));
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                            3,
                            (index) => HomeButton(
                                height: screenHeight * 0.12,
                                width: screenWidth / 3.5,
                                icon: index == 0
                                    ? icTopCategories
                                    : index == 1
                                        ? icBrands
                                        : icTopSeller,
                                title: index == 0
                                    ? topCaetgories
                                    : index == 1
                                        ? brand
                                        : topSellers,
                                onPress: () {})),
                      ),
                      const SizedBox(height: 10),
                      Container(
                          height: 30,
                          color: whiteColor,
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              featuredCatgories,
                              style: TextStyle(fontSize: 20),
                            ),
                          )),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              3,
                              (index) => Column(
                                    children: [
                                      FeaturedButton(homeSliderImaages1[index],
                                          homeSliderStrings1[index]),
                                      const SizedBox(height: 10),
                                      FeaturedButton(homeSliderImaages2[index],
                                          homeSliderStrings2[index])
                                    ],
                                  )).toList(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        // height: 600,
                        decoration: const BoxDecoration(
                          color: redColor,
                          // image: DecorationImage(
                          //     image: AssetImage(imgBackground),
                          //     fit: BoxFit.fill)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              featuredProducts,
                              style: TextStyle(
                                  color: whiteColor,
                                  fontFamily: bold,
                                  fontSize: 20),
                            ),
                            SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: FutureBuilder(
                                    future:
                                        firestoreServices.getFeaturedProducts(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (!snapshot.hasData) {
                                        return (Center(
                                          child: Text('wait for data'),
                                        ));
                                      } else {
                                        // print(snapshot.data!.docs);
                                        var data = snapshot.data!.docs;
                                        return Row(
                                          children: List.generate(
                                              data.length,
                                              (index) => InkWell(
                                                    onTap: () {
                                                      Get.toNamed(
                                                          'productDetailScreen',
                                                          parameters: {
                                                            "title": data[index]
                                                                [
                                                                'product_name'],
                                                            "product_id": data[
                                                                        index][
                                                                    'category_id']
                                                                .toString(),
                                                          });
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.all(5),
                                                      decoration:
                                                          const BoxDecoration(
                                                              color: whiteColor,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey,
                                                                  blurRadius:
                                                                      5.0,
                                                                ),
                                                              ],
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10))),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4),
                                                      // height: 100,
                                                      // width: 100,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Image.network(
                                                            data[index][
                                                                'product_images'][0],
                                                            width: 150,
                                                            height: 150,
                                                            fit: BoxFit.cover,
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          Text(
                                                            data[index][
                                                                'product_name'],
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    semibold,
                                                                color:
                                                                    darkFontGrey),
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          Text(
                                                            "\$" +
                                                                data[index][
                                                                    'product_price'] +
                                                                "",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    semibold,
                                                                color:
                                                                    redColor),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                        );
                                      }
                                    }))
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 6,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  mainAxisExtent: 300),
                          itemBuilder: (context, index) {
                            return Container(
                              color: whiteColor,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    imgP5,
                                    width: 200,
                                    height: 200,
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
                                        fontFamily: semibold, color: redColor),
                                  ),
                                ],
                              ),
                            );
                          })
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(index: 0),
    );
  }
}

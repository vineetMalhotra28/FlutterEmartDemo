import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:get/get.dart';

import '../../components/orderDetails.dart';
import '../../components/order_status.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: StreamBuilder(
          stream:
              firestoreServices.getUserOrderDetails(Get.parameters['order_id']),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else {
              var data = snapshot.data;

              return SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      OrderStatus(
                          icon: Icons.done,
                          color: Colors.blue,
                          title: 'order Placed',
                          showDone: data!['order_placed']),
                      OrderStatus(
                          icon: Icons.thumb_up,
                          color: Colors.blue,
                          title: 'order',
                          showDone: data['order_confirmed']),
                      OrderStatus(
                          icon: Icons.car_rental,
                          color: Colors.blue,
                          title: 'order on delivery',
                          showDone: data['order_on_deliver']),
                      OrderStatus(
                          icon: Icons.done_all_rounded,
                          color: Colors.blue,
                          title: 'order delivered',
                          showDone: data['order_delivered']),
                      Divider(
                        thickness: 5,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration:
                            const BoxDecoration(color: whiteColor, boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 15.0,
                          ),
                        ]),
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Column(
                          children: [
                            orderDetails(
                                'Order code',
                                data['order_code'],
                                Colors.red,
                                'Shopping method',
                                data['shipping_method'],
                                darkFontGrey),
                            orderDetails(
                                'Order date',
                                intl.DateFormat()
                                    .add_yMd()
                                    .format((data['order_date'].toDate())),
                                darkFontGrey,
                                'Payment method',
                                'card',
                                darkFontGrey),
                            orderDetails(
                                'Payment status',
                                'Pending',
                                darkFontGrey,
                                'Delivery status',
                                'Pending',
                                darkFontGrey),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Shipping Address',
                                        style: textStyleCart.copyWith(
                                            fontFamily: semibold, fontSize: 15),
                                      ),
                                      Text(data['order_by_address']),
                                      Text(data['order_by_city']),
                                      Text(data['order_by_email']),
                                      Text(data['order_by_phone']),
                                      Text(data['order_by_postalcode']),
                                      Text(data['order_by_state']),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 100,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total Amount',
                                          style: textStyleCart.copyWith(
                                              fontFamily: semibold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          data['total_amount'].toString(),
                                          style: textStyleCart.copyWith(
                                              fontFamily: semibold,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration:
                            const BoxDecoration(color: whiteColor, boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 15.0,
                          ),
                        ]),
                        child: Column(
                          children: [
                            const Center(
                              child: Text('Ordered Product'),
                            ),
                            ListView(
                              shrinkWrap: true,
                              children:
                                  List.generate(data['orders'].length, (index) {
                                return orderDetails(
                                    data['orders'][index]['title'],
                                    '' +
                                        data['orders'][index]['qty']
                                            .toString() +
                                        ' X ' +
                                        data['orders'][index]['price'] +
                                        '',
                                    darkFontGrey,
                                    'Price',
                                    (int.parse(data['orders'][index]['price']) *
                                            data['orders'][index]['qty'])
                                        .toString(),
                                    darkFontGrey);
                              }).toList(),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}

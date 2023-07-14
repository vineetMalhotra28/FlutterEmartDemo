import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:intl/intl.dart' as intl;

Widget SendMessage(QueryDocumentSnapshot data) {
  var t =
      data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
  var time = intl.DateFormat("h:ma").format(t);
  return Container(
    padding: EdgeInsets.all(8),
    margin: EdgeInsets.only(bottom: 8),
    decoration: data['uid'] == currentUser!.uid
        ? const BoxDecoration(
            color: redColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ))
        : const BoxDecoration(
            color: redColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            )),
    child: Column(
      children: [
        Text(
          data['msg'],
          style: textStyleCommon.copyWith(fontSize: 15, fontFamily: regular),
        ),
        SizedBox(
          height: 5,
        ),
        Text(time.toString(),
            style: textStyleCommon.copyWith(fontSize: 12, fontFamily: regular)),
      ],
    ),
  );
}

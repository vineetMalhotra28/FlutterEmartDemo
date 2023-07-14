import 'package:emart_app/consts/consts.dart';

Widget orderDetails(str1, data1, data1color, str2, data2, data2color) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // ist column
          children: [
            Text(
              str1,
              style: textStyleCart.copyWith(fontFamily: semibold, fontSize: 15),
            ),
            Text(
              data1,
              style: textStyleCart.copyWith(
                  color: data1color, fontFamily: semibold, fontSize: 12),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),

        // 2nd end
        SizedBox(
          width: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                str2,
                style:
                    textStyleCart.copyWith(fontFamily: semibold, fontSize: 15),
              ),
              Text(
                data2,
                style: textStyleCart.copyWith(
                    color: data2color, fontFamily: semibold, fontSize: 12),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

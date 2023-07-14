import 'package:emart_app/consts/consts.dart';

Widget FeaturedButton(image, title) {
  return Container(
    margin: const EdgeInsets.only(left: 4, right: 4),
    color: whiteColor,
    width: 200,
    child: Row(
      children: [
        Image.asset(
          image,
          width: 60,
          fit: BoxFit.fill,
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(fontFamily: semibold, color: darkFontGrey),
        )
      ],
    ),
  );
}

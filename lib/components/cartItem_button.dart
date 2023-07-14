import 'package:emart_app/consts/consts.dart';

Widget CartItemButton({contextWidth, String? itemCount, String? title}) {
  return Container(
    decoration: const BoxDecoration(
        color: whiteColor, borderRadius: BorderRadius.all(Radius.circular(10))),
    height: 70,
    width: contextWidth / 3.5,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Text("$itemCount",
            style: const TextStyle(color: darkFontGrey, fontFamily: semibold)),
        Text("$title",
            style: const TextStyle(color: darkFontGrey, fontFamily: semibold))
      ],
    ),
  );
}

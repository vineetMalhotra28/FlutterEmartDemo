import 'package:emart_app/consts/consts.dart';

Widget HomeButton({width, height, icon, title, onPress}) {
  return Container(
    width: width,
    height: height,
    decoration: const BoxDecoration(
        color: whiteColor, borderRadius: BorderRadius.all(Radius.circular(20))),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          icon,
          width: 26,
        ),
        const SizedBox(
          height: 15,
        ),
        Text(title)
      ],
    ),
  );
}

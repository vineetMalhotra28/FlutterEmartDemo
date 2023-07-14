import 'package:emart_app/consts/consts.dart';

Widget ApplogoWidget() {
  return (Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20))),
    child: Image.asset(
      icAppLogo,
      height: 77,
      width: 77,
    ),
  ));
}

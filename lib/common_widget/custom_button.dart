import 'package:emart_app/consts/consts.dart';

Widget CustomButton({onPress, color, textColor, String? title}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: color, padding: const EdgeInsets.all(12)),
      onPressed: onPress,
      child: Text(
        title!,
        style: TextStyle(fontFamily: bold, color: textColor),
      ));
}

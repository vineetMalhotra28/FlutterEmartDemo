import 'package:emart_app/consts/consts.dart';

Widget CustomTextField(
    {String? title, String? hint, controller, bool? isPass}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title!,
        style: const TextStyle(
            fontFamily: semibold, color: redColor, fontSize: 16),
      ),
      const SizedBox(height: 5),
      TextFormField(
        obscureText: isPass!,
        controller: controller,
        decoration: InputDecoration(
            hintStyle:
                const TextStyle(fontFamily: semibold, color: textfieldGrey),
            hintText: hint,
            isDense: true,
            fillColor: lightGrey,
            filled: true,
            border: InputBorder.none,
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: redColor))),
      )
    ],
  );
}

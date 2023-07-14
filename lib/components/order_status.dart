import 'package:emart_app/consts/consts.dart';

Widget OrderStatus({icon, color, title, showDone}) {
  return ListTile(
    leading: Container(
        decoration: BoxDecoration(border: Border.all(color: color)),
        padding: EdgeInsets.all(4),
        child: Icon(
          icon,
          color: color,
        )),
    title: Text('----------------------'),
    trailing: Container(
      // color: redColor,
      width: 120,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [Text('$title'), showDone ? Icon(Icons.done) : Container()],
      ),
    ),
  );
}

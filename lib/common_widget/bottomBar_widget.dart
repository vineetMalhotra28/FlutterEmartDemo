import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BottomBar();
  }
}

class _BottomBar extends State<BottomBar> {
  int selectedItem = 0;
  List<String> menus = [
    '/homeScreen',
    '/categoryScreen',
    '/accountScreen',
    '/userCartScreen'
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.defaultDialog(
          barrierDismissible: false,
          title: 'Are you sure',
          onConfirm: () {
            SystemNavigator.pop();
          },
          onCancel: () {
            // Navigator.pop(context);
          },
        );
        return false;
      },
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: whiteColor,
        selectedItemColor: redColor,
        selectedLabelStyle: TextStyle(fontFamily: semibold),
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                icHome,
                width: 26,
              ),
              label: home),
          BottomNavigationBarItem(
              icon: Image.asset(
                icCategories,
                width: 26,
              ),
              label: categories),
          BottomNavigationBarItem(
              icon: Image.asset(
                icProfile,
                width: 26,
              ),
              label: account),
          BottomNavigationBarItem(
              icon: Image.asset(
                icCart,
                width: 26,
              ),
              label: cart),
        ],
        currentIndex: widget.index,
        onTap: (value) {
          setState(() {
            selectedItem = value;
            Get.toNamed(menus[selectedItem]);
            // Get.toNamed("/userNotifications");
            // print('' + menus[selectedItem] + '');
          });
        },
      ),
    );
  }
}

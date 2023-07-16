import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waist_app/screens/AboutUs.dart';
import 'package:waist_app/screens/home_page/HomePage.dart';
import 'package:waist_app/screens/new_order/newOrder.dart';
import 'package:waist_app/widgets/myDrawer.dart';

import '../../constants/colors.dart';

class BottomNavigationExample extends StatefulWidget {
  const BottomNavigationExample({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavigationExampleState createState() =>
      _BottomNavigationExampleState();
}

class _BottomNavigationExampleState extends State {
  int _selectedTab = 2;

  final List _pages = [
    AboutUs(),
    NewOrder(),
    const HomePage(),
  ];

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MyDrawer(),
      key: _scaffold,
      body: _pages[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: BC.appColor,
        currentIndex: _selectedTab,
        onTap: (index) => _changeTab(index),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/Icon material-share.png',
                color: Colors.white,
                height: 22.h,
              ),
              label: "مشاركة"),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/Icon awesome-plus-circle.png',
                color: Colors.white,
                height: 22.h,
              ),
              label: "طلب جديد"),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/Icon ionic-ios-home.png',
                color: Colors.white,
                height: 22.h,
              ),
              label: "الرئيسية"),
        ],
      ),
    );
  }
}

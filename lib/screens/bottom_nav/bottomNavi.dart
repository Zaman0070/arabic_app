import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:waist_app/constants/colors.dart';
import 'package:waist_app/screens/home_page/HomePage.dart';
import 'package:waist_app/screens/new_order/newOrder.dart';
import 'package:waist_app/widgets/myDrawer.dart';

class BottomNavigationExample extends StatefulWidget {
  const BottomNavigationExample({
    super.key,
  });

  @override
  State<BottomNavigationExample> createState() =>
      _BottomNavigationExampleState();
}

class _BottomNavigationExampleState extends State<BottomNavigationExample> {
  int index = 0;

  final PageStorageBucket _bucket = PageStorageBucket();
  Widget currentScreen = const HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: const MyDrawer(),
        resizeToAvoidBottomInset: false,
        body: WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: ScrollConfiguration(
            behavior: const ScrollBehavior(),
            child: GlowingOverscrollIndicator(
              axisDirection: AxisDirection.down,
              color: const Color(0xff675492),
              child: PageStorage(
                bucket: _bucket,
                child: currentScreen,
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: Theme.of(context).canvasColor,
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          child: Container(
            height: 65.h,
            decoration: BoxDecoration(color: BC.appColor),
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(builder: (context) {
                    return InkWell(
                        onTap: () {
                          Share.share(
                              'check out my website https://example.com',
                              subject: 'Look what I made!');
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/Icon material-share.png',
                              height: 22.h,
                            ),
                            Text(
                              'مشاركة',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ));
                  }),
                  InkWell(
                      onTap: () {
                        setState(() {
                          index = 0;
                          currentScreen = NewOrder();
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/Icon awesome-plus-circle.png',
                            height: 22.h,
                          ),
                          Text(
                            "طلب جديد",
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      )),
                  InkWell(
                      onTap: () {
                        setState(() {
                          index = 1;
                          currentScreen = const HomePage();
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/Icon ionic-ios-home.png',
                            height: 22.h,
                          ),
                          Text(
                            'الرئيسية',
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:waist_app/screens/AboutUs.dart';
// import 'package:waist_app/screens/home_page/HomePage.dart';
// import 'package:waist_app/screens/new_order/newOrder.dart';
// import 'package:waist_app/widgets/myDrawer.dart';

// import '../../constants/colors.dart';

// class BottomNavigationExample extends StatefulWidget {
//   const BottomNavigationExample({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _BottomNavigationExampleState createState() =>
//       _BottomNavigationExampleState();
// }

// class _BottomNavigationExampleState extends State {
//   int _selectedTab = 2;

//   final List _pages = [
//     AboutUs(),
//     NewOrder(),
//     const HomePage(),
//   ];

//   _changeTab(int index) {
//     setState(() {
//       _selectedTab = index;
//     });
//   }

//   final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       endDrawer: MyDrawer(),
//       key: _scaffold,
//       body: _pages[_selectedTab],
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: BC.appColor,
//         currentIndex: _selectedTab,
//         onTap: (index) => _changeTab(index),
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.white,
//         items: [
//           BottomNavigationBarItem(
//               icon: Image.asset(
//                 'assets/Icon material-share.png',
//                 color: Colors.white,
//                 height: 22.h,
//               ),
//               label: "مشاركة"),
//           BottomNavigationBarItem(
//               icon: Image.asset(
//                 'assets/Icon awesome-plus-circle.png',
//                 color: Colors.white,
//                 height: 22.h,
//               ),
//               label: "طلب جديد"),
//           BottomNavigationBarItem(
//               icon: Image.asset(
//                 'assets/Icon ionic-ios-home.png',
//                 color: Colors.white,
//                 height: 22.h,
//               ),
//               label: "الرئيسية"),
//         ],
//       ),
//     );
//   }
// }

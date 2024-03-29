import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';
import 'package:waist_app/Helper/payment_api.dart';
import 'package:waist_app/controller/mishtri_controller.dart';
import 'package:waist_app/screens/AboutUs.dart';
import 'package:waist_app/screens/Safty.dart';
import 'package:waist_app/screens/home_page/widget/order_button.dart';
import 'package:waist_app/screens/howToUse.dart';
import 'package:waist_app/screens/chat/messages.dart';
import 'package:waist_app/screens/new_order/newOrder.dart';
import 'package:waist_app/screens/notification.dart';
import 'package:waist_app/widgets/myDrawer.dart';
import '../../constants/colors.dart';
import 'package:badges/badges.dart' as badges;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> documentID = [];
  getOrderNumber() async {
    await FirebaseFirestore.instance
        .collection('MishtariProducts')
        .where('uid', arrayContains: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      for (var element in value.docs) {
        documentID.add(element.id);
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    getOrderNumber();
    super.initState();
  }

  MishtariController mishtariController = Get.put(MishtariController());
  List<String> imageBanner = [
    'assets/banner2.jpg',
    'assets/banner1.jpg',
  ];

  List images = [
    'assets/slider/Message.png',
    'assets/slider/How to use.png',
    'assets/slider/Add.png',
    'assets/slider/Verified.png',
    'assets/slider/Info.png',
  ];
  List names = [
    'آراء العملاء',
    'دليل الاستخدام',
    'طلب جديد',
    'الضمانات',
    'عن التطبيق',
  ];
  int _current = 0;
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  List pages = [
    ['Messages', const Messages()],
    ['HowtoUse', HowToUse()],
    ['NewOrder', NewOrder()],
    ['NewOrder', safty()],
    // ['NewOrder', const AboutUs()],
    ['HistoryEmpty', const AboutUs()],
  ];
  final PageController _pageController =
      PageController(viewportFraction: 0.25, keepPage: true, initialPage: 2);
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  int _index = 2;

  @override
  Widget build(BuildContext context) {
    log('$documentID jjjjj');

    return Scaffold(
      key: _scaffold,
      endDrawer: const MyDrawer(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              'assets/background.png',
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 40.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('notification')
                          .where('uid',
                              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .where('read', isEqualTo: false)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return badges.Badge(
                          badgeStyle:
                              badges.BadgeStyle(badgeColor: BC.appColor),
                          badgeContent: Text(
                            snapshot.data!.docs.length.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          child: IconButton(
                              onPressed: () async {
                                Get.to(() => const NotificationsPage());
                                await FirebaseFirestore.instance
                                    .collection('notification')
                                    .where('uid',
                                        isEqualTo: FirebaseAuth
                                            .instance.currentUser!.uid)
                                    .where('read', isEqualTo: false)
                                    .get()
                                    .then((value) {
                                  for (var element in value.docs) {
                                    FirebaseFirestore.instance
                                        .collection('notification')
                                        .doc(element.id)
                                        .update({'read': true});
                                  }
                                });
                              },
                              icon: Icon(
                                Icons.notifications,
                                size: 30.h,
                                color: BC.appColor,
                              )),
                        );
                      }),
                  Container(
                      width: 50.h,
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: BC.logo_clr,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: const Color(0xff707070))),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.asset(
                          'assets/logo.jpeg',
                          fit: BoxFit.cover,
                        ),
                      )),
                  IconButton(
                      onPressed: () {
                        _scaffold.currentState!.openEndDrawer();
                      },
                      icon: Icon(
                        Icons.menu_rounded,
                        size: 30.h,
                        color: BC.appColor,
                      ))
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.18,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Swiper(
                        autoplay: true,
                        outer: false,
                        indicatorLayout: PageIndicatorLayout.NONE,
                        itemBuilder: (context, index) {
                          return Image.asset(imageBanner[index],
                              fit: BoxFit.fill);
                        },
                        onIndexChanged: (value) {
                          setState(() {
                            _current = value;
                          });
                        },
                        layout: SwiperLayout.DEFAULT,
                        itemCount: imageBanner.length,
                        pagination: const SwiperPagination(
                            builder: SwiperPagination(
                          builder: DotSwiperPaginationBuilder(
                              color: Colors.transparent,
                              activeColor: Colors.transparent,
                              size: 10,
                              activeSize: 10),
                        )),
                        control: SwiperControl(
                          color: Colors.black.withOpacity(0.0),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: map<Widget>(imageBanner, (value, url) {
                          return Container(
                            width: _current == value ? 5.0 : 5,
                            height: _current == value ? 20.0 : 20,
                            margin: const EdgeInsets.symmetric(horizontal: 1),
                            decoration: BoxDecoration(
                              borderRadius: _current == value
                                  ? BorderRadius.circular(20)
                                  : BorderRadius.circular(20),
                              color: _current == value
                                  ? BC.appColor
                                  : Colors.grey[400],
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 150.h,
                // card height
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: images.length,
                    controller: _pageController,
                    onPageChanged: (int index) =>
                        setState(() => _index = index),
                    itemBuilder: (_, i) {
                      return Transform.scale(
                        scale: i == _index ? 1.5 : 0.7,
                        //scaleX: 20,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 27,
                            // left: 12,
                            // right: 12,
                          ),
                          child: Column(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                pages[_index][1]));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: CircleAvatar(
                                      radius: 35.h,
                                      backgroundColor: BC.appColor,
                                      child: Image.asset(
                                        images[i],
                                        height: 20.h,
                                      ),
                                    ),
                                  )),
                              Text(
                                names[i],
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: BC.appColor),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 35.h,
                      height: 35.h,
                      decoration: BoxDecoration(
                          color: BC.appColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            previousPage();
                          },
                          icon: Center(
                            child: Padding(
                              padding: EdgeInsets.only(left: 5.w),
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      )),
                  Container(
                      width: 35.h,
                      height: 35.h,
                      decoration: BoxDecoration(
                          color: BC.appColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            nextPage();
                          },
                          icon: const Center(
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
            
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'الطلبات النشطة',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const OrderButtonHome(),
            ],
          ),
        ),
      ),
    );
  }

  void nextPage() {
    _pageController.animateToPage(_pageController.page!.toInt() + 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutSine);
  }

  void previousPage() {
    _pageController.animateToPage(_pageController.page!.toInt() - 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutSine);
  }
}

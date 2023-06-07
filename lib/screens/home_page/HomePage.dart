import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:waist_app/screens/howToUse.dart';
import 'package:waist_app/screens/messages.dart';
import 'package:waist_app/screens/new_order/newOrder.dart';
import 'package:waist_app/screens/order/order.dart';
import 'package:waist_app/widgets/myDrawer.dart';

import '../../constants/colors.dart';

import '../../widgets/button.dart';
import '../histroy_page/historyEmpty.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Color> colors = [Colors.white, Colors.yellow, Colors.red, Colors.white];

  List images = [
    'assets/slider/Message.png',
    'assets/slider/How to use.png',
    'assets/slider/Add.png',
    'assets/slider/Delivery.png',
    'assets/slider/Verified.png',
    'assets/slider/Info.png',
  ];
  List names = [
    'اراء العملاء',
    'دليل الأستخدام',
    'طلب جديد',
    'الضمانات',
    'عن التطبيق',
    'وسيط مواقع التسوق',
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
    ['Messages', Messages()],
    ['HowtoUse', HowToUse()],
    ['NewOrder', NewOrder()],
    ['NewOrder', NewOrder()],
    ['NewOrder', NewOrder()],
    ['HistoryEmpty', HistoryEmpty()],
  ];
  final PageController _pageController =
      PageController(viewportFraction: 0.25, keepPage: true, initialPage: 0);
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      endDrawer: MyDrawer(),
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
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.notifications,
                        size: 30.h,
                        color: BC.appColor,
                      )),
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
                        outer: false,
                        indicatorLayout: PageIndicatorLayout.NONE,
                        itemBuilder: (context, index) {
                          return Container(
                            color: colors[index],
                          );
                        },
                        onIndexChanged: (value) {
                          setState(() {
                            _current = value;
                          });
                        },
                        layout: SwiperLayout.DEFAULT,
                        itemCount: colors.length,
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
                        children: map<Widget>(colors, (value, url) {
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
                height: 140.h, // card height
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: 6,
                    controller: _pageController,
                    onPageChanged: (int index) =>
                        setState(() => _index = index),
                    itemBuilder: (_, i) {
                      return Transform.scale(
                        scale: i == _index ? 1.3 : 0.5,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                pages[_index][1]));
                                  },
                                  child: CircleAvatar(
                                    radius: 35.h,
                                    backgroundColor: BC.appColor,
                                    child: Image.asset(images[i]),
                                  )),
                            ),
                            Text(
                              names[i],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: BC.appColor),
                            ),
                          ],
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
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: BC.appColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: BC.appColor,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 4),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: BC.appColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            const Text(
                              'تحويل المبلغ',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 4),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: BC.appColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            const Text(
                              'قيد التنفيذ',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 4),
                              decoration: BoxDecoration(
                                  color: BC.appColor,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            const Text(
                              'استلام المبلغ',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 4),
                              decoration: BoxDecoration(
                                  color: BC.appColor,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            const Text(
                              'تقديم الطلب',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    MyButton(
                      name: 'تفاصيل الطلب',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Orders(),
                            ));
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void nextPage() {
    _pageController.animateToPage(_pageController.page!.toInt() + 1,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  void previousPage() {
    _pageController.animateToPage(_pageController.page!.toInt() - 1,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }
}

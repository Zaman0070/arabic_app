import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:waist_app/screens/onBoarding.dart';
import 'package:waist_app/screens/bottom_nav/bottomNavi.dart';
import 'package:waist_app/screens/order/order.dart';

import 'constants/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId('6afde054-dff9-45b9-a470-27d56d798ea2');
  OneSignal.shared
      .promptUserForPushNotificationPermission(fallbackToSettings: true)
      .then((accepted) {
    debugPrint('Accepted permission: $accepted');
  });
  OneSignal.shared
      .setNotificationOpenedHandler((OSNotificationOpenedResult result) async {
    debugPrint('OneSignal: notification opened: ${result.notification.body}');
    if (result.notification.additionalData!['type'] == 'mishtri') {
      Get.to(() => Orders(
            title: 'طلباتي',
          ));
    } else if (result.notification.additionalData!['type'] == 'comment') {
    } else if (result.notification.additionalData!['type'] == 'chat') {
      // Get.to(() => ChatConversation(
      //       chatId: result.notification.additionalData!['chatId'],
      //       image: result.notification.additionalData!['img'],
      //       name: result.notification.additionalData!['reciverName'],
      //       reciverId: result.notification.additionalData!['reciverId'],
      //       token: result.notification.additionalData!['token'],
      //       senderName: result.notification.additionalData!['senderName'],
      //       timeLeft: result.notification.additionalData!['timeLeft'],
      //     ));
    } else if (result.notification.additionalData!['type'] == 'admin') {
      // Get.to(() => CustomSupport(
      //       name: result.notification.additionalData!['reciverName'],
      //       chatId: result.notification.additionalData!['chatId'],
      //       image: result.notification.additionalData!['img'],
      //       reciverId: result.notification.additionalData!['reciverId'],
      //       token: result.notification.additionalData!['token'],
      //       senderName: result.notification.additionalData!['senderName'],

      //     ));
    }
  });
  OneSignal.shared.setNotificationWillShowInForegroundHandler(
      (OSNotificationReceivedEvent event) {
    debugPrint('FOREGROUND HANDLER CALLED WITH: ${event}');
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          navigatorObservers: [FlutterSmartDialog.observer],
          builder: FlutterSmartDialog.init(),
          debugShowCheckedModeBanner: false,
          title: 'First Method',
          theme: ThemeData(
            colorScheme: ThemeData().colorScheme.copyWith(primary: BC.appColor),
            primarySwatch: Colors.blue,
          ),
          home: child,
        );
      },
      child: FirebaseAuth.instance.currentUser != null
          ?  BottomNavigationExample()
          : OnBaording(),
    );
  }
}

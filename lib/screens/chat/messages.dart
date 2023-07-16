import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:waist_app/controller/user_controller.dart';
import 'package:waist_app/screens/new_order/newOrder.dart';

import '../../constants/colors.dart';

import '../../widgets/arrowButton.dart';

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  UserController userController = Get.put(UserController());
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  Timer? timer;
  @override
  void initState() {
    startTimer();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        seconds++;
      });
      if (seconds == 2) {
        stopTimer();
      }
    });
  }

  void stopTimer() {
    timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
            child: Column(children: [
              SizedBox(
                height: 12.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => NewOrder());
                    },
                    child: Image(
                      image: const AssetImage(
                        'assets/Icon awesome-plus-circle.png',
                      ),
                      height: 25.h,
                      color: BC.appColor,
                    ),
                  ),
                  const Text(
                    'الرسائل',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ArrowButton(
                    onPressed: () {
                      Get.back();
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Chats')
                      .where('chatMap',
                          arrayContains: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.data == null) {
                      return const Text('');
                    }
                    return ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var data = snapshot.data!.docs[index];
                          userController.getSpecificUser(data['chatMap'][0] ==
                                  userController.currentUser.value.uid
                              ? data['chatMap'][0]
                              : data['chatMap'][1]);
                          DateTime dateTime =
                              DateTime.fromMillisecondsSinceEpoch(
                                  data['lastMsgTime']);

                          return userController.specificUser.value.name != null
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 0),
                                  decoration: BoxDecoration(
                                      color: BC.appColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: BC.appColor)),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      DateFormat(
                                                              'dd/MM/yyyy  hh:mm ')
                                                          .format(dateTime),
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    Text(
                                                      userController
                                                          .specificUser
                                                          .value
                                                          .name!,
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      data['lastMsg'],
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 26.h,
                                              child: userController.specificUser
                                                          .value.profileImage ==
                                                      ''
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Image.asset(
                                                          'assets/team.png'),
                                                    )
                                                  : ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      child: Image.network(
                                                        userController
                                                            .specificUser
                                                            .value
                                                            .profileImage!,
                                                      ),
                                                    ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox();
                        });
                  }),
            ]),
          ),
        ),
      ),
    );
  }
}

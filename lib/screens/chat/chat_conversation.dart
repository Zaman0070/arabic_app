import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waist_app/constants/colors.dart';
import 'package:waist_app/screens/chat/widget/input_field.dart';
import 'package:waist_app/widgets/arrowButton.dart';

// ignore: must_be_immutable
class ChatConversation extends StatefulWidget {
  String image;
  String? chatId;
  String name;
  String reciverId;
  ChatConversation({
    super.key,
    required this.image,
    this.chatId,
    required this.name,
    required this.reciverId,
  });

  @override
  State<ChatConversation> createState() => _ChatConversationState();
}

class _ChatConversationState extends State<ChatConversation>
    with WidgetsBindingObserver {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late var msgController = TextEditingController();
  // ignore: unused_field
  final ScrollController _controller = ScrollController();

  bool istrue = false;
  File? file;
  String? type;
  String statues = '';
  File? imageFile;

  void onSendMessage() async {
    if (msgController.text.isNotEmpty) {
      Map<String, dynamic> chatData = {
        'senderId': FirebaseAuth.instance.currentUser!.uid,
        "message": msgController.text,
        'receiverId': widget.reciverId,
        "type": "text",
        "time": DateTime.now().microsecondsSinceEpoch,
        'readby': [FirebaseAuth.instance.currentUser!.uid],
        'date': DateFormat('dd-MM-yyyy').format(DateTime.now())
      };
      _firestore.collection('Chats').doc(widget.chatId).update({
        'read': false,
        'show': true,
        'lastMsg': msgController.text,
        'lastMsgTime': DateTime.now().microsecondsSinceEpoch,
        'chatMap': [FirebaseAuth.instance.currentUser!.uid, widget.reciverId],
        'time': DateFormat("dd - MMM - yyyy").format(DateTime.now()),
        'userToken': '',
      });

      await _firestore
          .collection('Chats')
          .doc(widget.chatId)
          .collection('Messages')
          .add(chatData);
      msgController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: 100.sh,
          width: 100.sw,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                'assets/background.png',
              ),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 12.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 34,
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
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: _firestore
                        .collection('Chats')
                        .doc(widget.chatId)
                        .collection('Messages')
                        .orderBy('time')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return GroupedListView<
                            QueryDocumentSnapshot<Map<String, dynamic>>,
                            String>(
                          stickyHeaderBackgroundColor: Colors.transparent,
                          reverse: true,
                          elements: snapshot.data!.docs,
                          groupBy: (element) => element['date'],
                          groupComparator: (value1, value2) =>
                              value2.compareTo(value1),
                          itemComparator: (item1, item2) =>
                              DateTime.fromMillisecondsSinceEpoch(item2['time'])
                                  .compareTo(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          item1['time'])),
                          order: GroupedListOrder.ASC,
                          useStickyGroupSeparators: true,
                          groupSeparatorBuilder: (String value) {
                            return Container(
                              height: 40.h,
                              color: Colors.white.withOpacity(0.1),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Container(
                                    height: 28.h,
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: BC.appColor),
                                    child: Center(
                                      child: Text(
                                        value ==
                                                DateFormat('dd-MM-yyyy')
                                                    .format(DateTime.now())
                                            ? "Today"
                                            : value,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          itemBuilder: (c, data) {
                            return messageTile(size, data);
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ),
              Container(
                height: 100.h,
                alignment: Alignment.bottomCenter,
                decoration: const BoxDecoration(),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15.0, left: 15),
                  child: Row(
                    children: [
                      InputFields(
                        onTap: () async {
                          onSendMessage();
                        },
                        controller: msgController,
                        hintText: 'اكتب رسالة',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  readBy() async {
    QuerySnapshot snapshot = await _firestore
        .collection('Chats')
        .doc(widget.chatId)
        .collection('Messages')
        .get();
    for (int i = 0; i < snapshot.docs.length; i++) {
      _firestore
          .collection('Chats')
          .doc(widget.chatId)
          .collection('Messages')
          .doc(snapshot.docs[i].id)
          .update({
        "readby": FieldValue.arrayUnion([widget.reciverId]),
      });
    }
  }

  Widget messageTile(
      Size size, QueryDocumentSnapshot<Map<String, dynamic>> chatMap) {
    String lastChatDate;
    var date = DateFormat('yyyy-MM-dd')
        .format(DateTime.fromMicrosecondsSinceEpoch(chatMap['time']));
    zoomMeeting() async {
      var url = chatMap['message'];
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    var today = DateFormat('yyyy-MM-dd').format(
        DateTime.fromMicrosecondsSinceEpoch(
            DateTime.now().microsecondsSinceEpoch));
    if (date == today) {
      lastChatDate = DateFormat('hh:mm a')
          .format(DateTime.fromMicrosecondsSinceEpoch(chatMap['time']));
    } else {
      lastChatDate = date.toString();
    }

    List readby = chatMap['readby'];
    if (!readby.contains(FirebaseAuth.instance.currentUser!.uid)) {
      readby.add(FirebaseAuth.instance.currentUser!.uid);
      chatMap.reference.update({'readby': readby}).then((value) {
        setState(() {});
      });
    }
    return Builder(builder: (_) {
      if (chatMap['type'] == "text") {
        return InkWell(
          onTap: () => zoomMeeting(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: chatMap['senderId'] ==
                          FirebaseAuth.instance.currentUser!.uid
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 1.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        chatMap['message'].length >= 40
                            ? Container(
                                width: 0.7.sw,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: chatMap['senderId'] ==
                                              FirebaseAuth
                                                  .instance.currentUser!.uid
                                          ? const Radius.circular(8)
                                          : const Radius.circular(0),
                                      topRight: const Radius.circular(8),
                                      bottomLeft: const Radius.circular(8),
                                      bottomRight: chatMap['senderId'] ==
                                              FirebaseAuth
                                                  .instance.currentUser!.uid
                                          ? const Radius.circular(0)
                                          : const Radius.circular(8),
                                    ),
                                    color: chatMap['senderId'] ==
                                            FirebaseAuth
                                                .instance.currentUser!.uid
                                        ? BC.appColor
                                        : BC.grey.withOpacity(0.2)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 10),
                                  child: Text(
                                    '${chatMap['message']}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: chatMap['senderId'] ==
                                              FirebaseAuth
                                                  .instance.currentUser!.uid
                                          ? const Radius.circular(8)
                                          : const Radius.circular(0),
                                      topRight: const Radius.circular(8),
                                      bottomLeft: const Radius.circular(8),
                                      bottomRight: chatMap['senderId'] ==
                                              FirebaseAuth
                                                  .instance.currentUser!.uid
                                          ? const Radius.circular(0)
                                          : const Radius.circular(8),
                                    ),
                                    color: chatMap['senderId'] ==
                                            FirebaseAuth
                                                .instance.currentUser!.uid
                                        ? BC.appColor
                                        : BC.grey),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 10),
                                  child: Text(
                                    '${chatMap['message']}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  mainAxisAlignment: chatMap['senderId'] ==
                          FirebaseAuth.instance.currentUser!.uid
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    Text(
                      lastChatDate,
                      style: TextStyle(fontSize: 10, color: BC.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      } else if (chatMap['type'] == "notify") {
        return Container(
          width: size.width,
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(0),
              ),
              color: Colors.black38,
            ),
            child: Text(
              chatMap['message'],
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }
}

import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_model_list/drop_down/model.dart';
import 'package:dropdown_model_list/drop_down/select_drop_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waist_app/Services/firebase_services.dart';
import 'package:waist_app/Services/onsignal.dart';
import 'package:waist_app/controller/image_controller.dart';
import 'package:waist_app/controller/mishtri_controller.dart';
import 'package:waist_app/controller/user_controller.dart';
import 'package:waist_app/model/buyer.dart';
import 'package:waist_app/screens/privacy_policy/privacy_policy.dart';
import 'package:waist_app/widgets/textFormfield.dart';
import '../../constants/colors.dart';
import '../../widgets/UploadImageButton.dart';
import '../../widgets/arrowButton.dart';
import '../../widgets/button.dart';

// ignore: must_be_immutable
class TheSeller extends StatefulWidget {
  String? id;
  BuyerModel? buyerModel;

  TheSeller({super.key, this.buyerModel, this.id});

  @override
  State<TheSeller> createState() => _TheSellerState();
}

class _TheSellerState extends State<TheSeller> {
  List<String> uids = [];
  OneSignals oneSignals = OneSignals();

  MishtariController mishtariController = Get.put(MishtariController());
  ImagePickerController imagePickerController =
      Get.put(ImagePickerController());
  UserController userController = Get.put(UserController());
  late var priceController = TextEditingController(
      text: widget.id == '' ? null : widget.buyerModel!.price);
  late var desController = TextEditingController(
      text: widget.id == '' ? null : widget.buyerModel!.description);
  late var daysController = TextEditingController(
      text: widget.id == '' ? null : widget.buyerModel!.days);
  late var secondPartyMobileController = TextEditingController(
      text: widget.id == '' ? null : widget.buyerModel!.phoneNumber);
  List<String> images = [];
  String ayamDate = '';
  bool second = false;
  bool isSwitched = false;
  bool isSwitched2 = false;
  String countryCode = '+966';
  int result = 0;

  DropListModel dropListModeldays = DropListModel([
    OptionItem(id: "1", title: "     ايام"),
    OptionItem(id: "2", title: "     شهر"),
  ]);
  DropListModel dropListModeldays1 = DropListModel([
    OptionItem(id: "1", title: "     1"),
    OptionItem(id: "2", title: "     2"),
    OptionItem(id: "3", title: "     3"),
    OptionItem(id: "4", title: "     4"),
    OptionItem(id: "5", title: "     5"),
    OptionItem(id: "6", title: "     6"),
    OptionItem(id: "7", title: "     7"),
    OptionItem(id: "8", title: "     10"),
    OptionItem(id: "9", title: "     14"),
    OptionItem(id: "10", title: "     21"),
    OptionItem(id: "11", title: "     30"),
  ]);
  ScrollController textFieldScrollController = ScrollController();
  late OptionItem optionItemSelectedday = OptionItem(
      title: widget.id == '' ? 'ايام' : "    ${widget.buyerModel!.ayam!}");
  late OptionItem optionItemSelectedday1 =
      OptionItem(title: widget.id == '' ? '1' : widget.buyerModel!.ayamNumber!);
  String? ayam;
  String? ayamNumber;
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
                  const SizedBox(
                    width: 30,
                  ),
                  const Text(
                    'البائع',
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
              SizedBox(
                height: 20.h,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                    color: BC.appColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: BC.appColor)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.id == ''
                              ? userController.currentUser.value.name!
                              : widget.buyerModel!.name!,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'اسم الطرف الأول ثلاثي',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 16,
                            color: BC.lightGrey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.id == ''
                              ? '+${userController.currentUser.value.phoneNumber!}'
                              : '+${widget.buyerModel!.phoneNumber!}',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'الجوال',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 16,
                            color: BC.lightGrey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.id == ''
                              ? userController.currentUser.value.location!
                              : widget.buyerModel!.address!.trim(),
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'المدينة',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 16,
                            color: BC.lightGrey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              UploadButton(
                image: widget.id == ''
                    ? imagePickerController.selectedImages.isEmpty
                        ? Container()
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              File(
                                  imagePickerController.selectedImages[0].path),
                              height: 40.h,
                              width: 40.h,
                              fit: BoxFit.cover,
                            ),
                          )
                    : imagePickerController.selectedImages.isEmpty
                        ? Container()
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: widget.buyerModel!.images == null
                                ? Image.file(
                                    File(imagePickerController
                                        .selectedImages[0].path),
                                    height: 40.h,
                                    width: 40.h,
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    widget.buyerModel!.images!,
                                    height: 40.h,
                                    width: 40.h,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                press: () {
                  Get.bottomSheet(
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
                      child: Padding(
                        padding: const EdgeInsets.all(22.0),
                        child: Column(
                          textDirection: TextDirection.rtl,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () async {
                                images = await imagePickerController
                                    .pickImage(ImageSource.camera)
                                    .whenComplete(() {
                                  Get.back();
                                });
                              },
                              child: Text(
                                'اختر صورة من الكاميرا',
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ),
                            Divider(
                              color: BC.appColor,
                            ),
                            InkWell(
                              onTap: () async {
                                images = await imagePickerController
                                    .pickImage(ImageSource.gallery)
                                    .whenComplete(() {
                                  Get.back();
                                });
                              },
                              child: Text('اختر صورة من المعرض',
                                  style: TextStyle(fontSize: 16.sp)),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              MytextField(
                type: TextInputType.number,
                controller: priceController,
                text: 'قيمة السلعة',
                hint: 'قيمة السلعة',
              ),
              SizedBox(
                height: 15.h,
              ),
              MytextField(
                type: TextInputType.name,
                controller: desController,
                text: 'وصف السلعة(اختياري)',
                hint: 'وصف السلعة(اختياري)',
              ),

              //   TextField(
              // controller: desController,
              // textDirection: TextDirection.rtl,
              //     scrollController: textFieldScrollController,
              //     keyboardType: TextInputType.multiline,
              //     minLines: null,
              //     maxLines: null,
              //     onChanged: (value) {
              //       textFieldScrollController.jumpTo(textFieldScrollController.position.maxScrollExtent);
              //     },
              //     decoration: InputDecoration(
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(10),
              //           borderSide: const BorderSide(width: 0.1)),
              //       labelText: 'وصف السلعة(اختياري)',
              //       hintText: 'وصف السلعة(اختياري)',
              //       alignLabelWithHint: true,
              //       hintTextDirection: TextDirection.rtl,
              //       contentPadding: const EdgeInsets.only(top: 0, right: 15),
              //     ),
              //   ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                decoration: BoxDecoration(
                    color: BC.appColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: BC.grey)),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: SelectDropList(
                          height: 40.h,
                          containerDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.transparent),
                              color: Colors.transparent),
                          containerPadding: const EdgeInsets.only(left: 10),
                          containerMargin: EdgeInsets.zero,
                          itemSelected: optionItemSelectedday1,
                          dropListModel: dropListModeldays1,
                          showIcon: false, // Show Icon in DropDown Title
                          showArrowIcon: false, // Show Arrow Icon in DropDown
                          showBorder: true,
                          paddingTop: 0,
                          paddingBottom: 0,
                          paddingLeft: 0,
                          paddingRight: 0,
                          borderColor: BC.grey,
                          icon: Icon(Icons.person, color: BC.appColor),
                          onOptionSelected: (optionItem) {
                            optionItemSelectedday1 = optionItem;
                            ayamNumber = optionItem.title;
                            daysController.text = optionItem.title;
                            daysController.text = DateTime.now()
                                .add(Duration(days: int.parse(optionItem.id!)))
                                .toString();
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: SelectDropList(
                          height: 40.h,
                          containerDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.transparent),
                              color: Colors.transparent),
                          containerPadding: const EdgeInsets.only(left: 10),
                          containerMargin: EdgeInsets.zero,
                          itemSelected: optionItemSelectedday,
                          dropListModel: dropListModeldays,
                          showIcon: false, // Show Icon in DropDown Title
                          showArrowIcon: true, // Show Arrow Icon in DropDown
                          showBorder: true,
                          paddingTop: 0,
                          paddingBottom: 0,
                          paddingLeft: 0,
                          paddingRight: 0,
                          borderColor: BC.grey,
                          icon: Icon(Icons.person, color: BC.appColor),
                          onOptionSelected: (optionItem) {
                            optionItemSelectedday = optionItem;
                            ayam = optionItem.title;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  // maxLength: 12,
                  keyboardType: TextInputType.phone,
                  controller: secondPartyMobileController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(width: 0.1)),
                    labelText: 'رقم هاتف المشتري',
                    hintText: 'XX-XXX-XXXX',
                    contentPadding: const EdgeInsets.only(top: 0, right: 15),
                    suffixIcon: widget.id == ''
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: BC.appColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6.6),
                                child: Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Text(
                                    countryCode,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : null,
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 290.w,
                    child: Text(
                      'أتعهد بأن تكون السلعة حسب المتفق عليها وفي خلاف ذلك سيتم استرجاع المبلغ للطرف الأول',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ),
                  SizedBox(
                    width: 25.w,
                  ),
                  InkWell(
                    onTap: () {
                      FirebaseFirestore.instance
                          .collection('users')
                          .where('phoneNumber',
                              isEqualTo:
                                  '${countryCode.replaceAll('+', "")}${secondPartyMobileController.text}')
                          .get()
                          .then((value) {
                        List<String> uid = value.docs.map((e) => e.id).toList();
                        uids = uid;

                        userController.getSpecificUser(uid[0]);
                        print(uids[0]);
                      });
                      setState(() {
                        result = int.parse(priceController.text) + 20;
                        isSwitched = !isSwitched;
                      });
                    },
                    child: Container(
                      width: 20.h,
                      height: 20.h,
                      decoration: BoxDecoration(
                          border: Border.all(color: BC.appColor),
                          borderRadius: BorderRadius.circular(5)),
                      child: Icon(
                        Icons.check,
                        color: isSwitched ? BC.appColor : Colors.transparent,
                        size: 15.h,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 290.w,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        children: [
                          Text(
                            "أوافق على  ",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(fontSize: 11.sp),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => const PrivacyPolicy());
                            },
                            child: Text(
                              'شروط و أحكام',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  fontSize: 11.sp,
                                  color: BC.appColor,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Text(
                            'تطبيق وسيط ',
                            style: TextStyle(fontSize: 11.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25.w,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isSwitched2 = !isSwitched2;
                      });
                    },
                    child: Container(
                      width: 20.h,
                      height: 20.h,
                      decoration: BoxDecoration(
                          border: Border.all(color: BC.appColor),
                          borderRadius: BorderRadius.circular(5)),
                      child: Icon(
                        Icons.check,
                        color: isSwitched2 ? BC.appColor : Colors.transparent,
                        size: 15.h,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              MyButton(
                name: 'تأكيد الطلب',
                onPressed: () async {
                  var random = Random();
                  int randomNumber = random.nextInt(100000000);
                  priceController.text.trim() == '' ||
                          daysController.text.trim() == '' ||
                          secondPartyMobileController.text.trim() == '' ||
                          isSwitched == false ||
                          isSwitched2 == false
                      ? Fluttertoast.showToast(msg: 'جميع الحقول مطلوبة')
                      : widget.id == ''
                          ? await FirebaseServices().addMishtriDetails(
                              timeExtandRequest: '',
                              timeExtandRequestAccepted: false,
                              serviceCompleted: false,
                              orderCompleted: false,
                              orderNumber: randomNumber,
                              review: '',
                              formfillby: 'seller',
                              formType: 'تفاصيل الطلب للمشتري',
                              uid: [
                                userController.currentUser.value.uid!,
                                userController.specificUser.value.uid!
                              ],
                              name: userController.currentUser.value.name!,
                              phoneNumber:
                                  userController.currentUser.value.phoneNumber!,
                              purpose: '',
                              days: daysController.text,
                              secondPartyMobile:
                                  '${countryCode.replaceAll('+', '')}${secondPartyMobileController.text}',
                              description: desController.text,
                              address:
                                  userController.currentUser.value.location!,
                              price: result.toString(),
                              agree1: isSwitched,
                              agree2: isSwitched2,
                              images: images[0],
                              isAccepted: '',
                              ayam: ayam!,
                              ayamNumber: ayamNumber!,
                              byerUid: userController.specificUser.value.uid!,
                              sellerUid: userController.currentUser.value.uid!,
                            )
                          : await mishtariController.updateMistryData(
                              BuyerModel(
                                review: '',
                                price: priceController.text.trim(),
                                days: daysController.text.trim(),
                                secondPartyMobile:
                                    widget.buyerModel!.secondPartyMobile,
                                agree1: isSwitched,
                                agree2: isSwitched2,
                                description: desController.text.trim(),
                                images: widget.buyerModel!.images,
                                name: widget.buyerModel!.name,
                                phoneNumber: widget.buyerModel!.phoneNumber,
                                address: widget.buyerModel!.address,
                                isAccepted: 'sellerAccepted',
                                ayam: widget.buyerModel!.ayam,
                                ayamNumber: widget.buyerModel!.ayamNumber,
                                uid: widget.buyerModel!.uid,
                                purpose: widget.buyerModel!.purpose,
                                orderNumber: widget.buyerModel!.orderNumber,
                                formType: widget.buyerModel!.formType,
                                formfillby: widget.buyerModel!.formfillby,
                                byerUid: widget.buyerModel!.byerUid,
                                sellerUid: widget.buyerModel!.sellerUid,
                              ),
                              widget.id!);
                  await oneSignals.sendNotification(
                      userController.specificUser.value.token!,
                      '${userController.currentUser.value.name!} Send the Request',
                      'مرحبا بك في تطبيق وسيط: يوجد لديك طلب (order detail) يرجى إكمال الطلب',
                      'assets/logo/jpeg',
                      token: userController.specificUser.value.token!,
                      senderName: userController.currentUser.value.name!,
                      type: 'mishtri');
                  // setState(() {
                  //   isSwitched = !isSwitched;
                  //   isSwitched2 = !isSwitched2;
                  // });
                },
              ),
              SizedBox(
                height: 20.h,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

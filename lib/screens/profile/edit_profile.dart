import 'dart:io';

import 'package:dropdown_model_list/drop_down/model.dart';
import 'package:dropdown_model_list/drop_down/select_drop_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waist_app/controller/user_controller.dart';
import 'package:waist_app/model/user.dart';
import 'package:waist_app/widgets/textFormfield.dart';

import '../../constants/colors.dart';

import '../../controller/image_controller.dart';
import '../../widgets/arrowButton.dart';

// ignore: must_be_immutable
class EditProfile extends StatefulWidget {
  UserModel userModel;
  EditProfile({super.key, required this.userModel});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  UserController userController = Get.put(UserController());
  ImagePickerController imagePickerController =
      Get.put(ImagePickerController());
  late var nameController = TextEditingController(text: widget.userModel.name);
  late var phoneController = TextEditingController(
      text: widget.userModel.phoneNumber!.replaceAll("+", ""));
  late var cityController =
      TextEditingController(text: widget.userModel.location);
  late var emailController =
      TextEditingController(text: widget.userModel.email);
  List<String> imageUrl = [];
  DropListModel dropListModel = DropListModel([
    OptionItem(id: "1", title: "     الرياض"),
    OptionItem(id: "2", title: "     جدة"),
    OptionItem(id: "3", title: "     مكة المدينة"),
    OptionItem(id: "4", title: "     الدمام"),
    OptionItem(id: "5", title: "     الهفوف"),
    OptionItem(id: "5", title: "     الطائف"),
    OptionItem(id: "5", title: "     بريدة"),
    OptionItem(id: "5", title: "     الخبر"),
    OptionItem(id: "5", title: "     تبوك"),
    OptionItem(id: "5", title: "     أبها"),
    OptionItem(id: "5", title: "     نجران"),
    OptionItem(id: "5", title: "     حائل"),
    OptionItem(id: "5", title: "     الجبيل"),
    OptionItem(id: "5", title: "     الخرج"),
    OptionItem(id: "5", title: "     ينبع"),
    OptionItem(id: "5", title: "     القطيف"),
    OptionItem(id: "5", title: "     الأحساء"),
    OptionItem(id: "5", title: "     صبيا"),
    OptionItem(id: "5", title: "     جيزان"),
    OptionItem(id: "5", title: "     عرعر"),
  ]);
  OptionItem optionItemSelected = OptionItem(title: "    المدينة");

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
                    onTap: () async {
                      await userController.updateUser(
                        UserModel(
                            token: widget.userModel.token,
                            name: nameController.text,
                            phoneNumber: phoneController.text,
                            location: cityController.text,
                            email: emailController.text,
                            profileImage:
                                // ignore: unnecessary_null_comparison
                                imageUrl.isEmpty
                                    ? widget.userModel.profileImage
                                    : imageUrl[0],
                            uid: widget.userModel.uid,
                            walletBalance: widget.userModel.walletBalance),
                      );
                      Get.back();
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.save,
                          color: BC.appColor,
                          size: 24.h,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          'حفظ',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  const Text(
                    'الملف الشخصي',
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
                height: 50.h,
              ),
              CircleAvatar(
                radius: 46.5.h,
                backgroundColor: BC.appColor,
                child: CircleAvatar(
                  radius: 45.h,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(
                    widget.userModel.profileImage ?? '',
                  ),
                  child: InkWell(
                    onTap: () {
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
                                    imageUrl = await imagePickerController
                                        .pickImage(ImageSource.camera)
                                        .whenComplete(() => Get.back());
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
                                    imageUrl = await imagePickerController
                                        .pickImage(ImageSource.gallery)
                                        .whenComplete(() => Get.back());
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
                    child: CircleAvatar(
                      radius: 45.h,
                      backgroundColor: Colors.transparent,
                      backgroundImage: imagePickerController.pickedFile != null
                          ? FileImage(
                              File(imagePickerController.pickedFile!.path),
                            )
                          : null,
                      child: Padding(
                        padding: const EdgeInsets.all(35.0),
                        child: Image.asset(
                          'assets/camera.png',
                          color: widget.userModel.profileImage == ''
                              ? imagePickerController.pickedFile == null
                                  ? BC.appColor
                                  : Colors.transparent
                              : Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              widget.userModel.profileImage != ''
                  ? InkWell(
                      onTap: () async {
                        await userController.updateUser(
                          UserModel(
                            name: nameController.text,
                            phoneNumber: phoneController.text,
                            location: cityController.text,
                            email: emailController.text,
                            profileImage: '',
                            uid: widget.userModel.uid,
                          ),
                        );
                        Get.back();
                      },
                      child: Container(
                        height: 35.h,
                        width: 135.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: BC.appColor,
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/delete.png',
                                color: Colors.white,
                                height: 20.h,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                'حذف الصورة',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                ),
                              )
                            ]),
                      ),
                    )
                  : Container(),
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
                    MytextField(
                      enable: true,
                      controller: nameController,
                      text: 'الأسم',
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    MytextField(
                      enable: true,
                      controller: phoneController,
                      text: 'رقم الهاتف',
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: SelectDropList(
                        containerDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: BC.grey),
                            color: Colors.transparent),
                        containerPadding: const EdgeInsets.only(left: 10),
                        containerMargin: EdgeInsets.zero,
                        itemSelected: optionItemSelected,
                        dropListModel: dropListModel,
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
                          optionItemSelected = optionItem;
                          cityController.text = optionItem.title;
                          print(optionItem.title);
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    MytextField(
                      enable: true,
                      controller: emailController,
                      text: 'البريد الألكتروني(اختياري)',
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

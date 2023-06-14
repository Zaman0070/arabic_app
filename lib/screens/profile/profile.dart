import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:waist_app/Services/firebase_services.dart';
import 'package:waist_app/controller/user_controller.dart';
import 'package:waist_app/screens/profile/edit_profile.dart';
import 'package:waist_app/widgets/textFormfield.dart';

import '../../constants/colors.dart';

import '../../widgets/arrowButton.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<UserController>(
            init: UserController(),
            builder: (controller) {
              late var nameController = TextEditingController(
                  text: controller.currentUser.value.name ?? '');
              late var phoneController = TextEditingController(
                  text: controller.currentUser.value.phoneNumber ?? '');
              late var locationController = TextEditingController(
                  text: controller.currentUser.value.location != null
                      ? controller.currentUser.value.location!.trim()
                      : '');
              late var emailController = TextEditingController(
                  text: controller.currentUser.value.email ?? '');
              return SafeArea(
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                    onTap: () {
                                      Get.to(() => EditProfile(
                                            userModel: userController
                                                .currentUser.value,
                                          ));
                                    },
                                    child: Image.asset('assets/Edit.png')),
                                SizedBox(
                                  width: 5.w,
                                ),
                                const Text(
                                  'تعديل',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
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
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      CircleAvatar(
                        radius: 45.h,
                        backgroundColor: BC.appColor,
                        child: CircleAvatar(
                            radius: 43.5.h,
                            backgroundColor: Colors.white,
                            child:
                                userController.currentUser.value.profileImage !=
                                            null &&
                                        userController.currentUser.value
                                                .profileImage !=
                                            ''
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.network(
                                          userController
                                              .currentUser.value.profileImage!,
                                          fit: BoxFit.cover,
                                          width: 100.w,
                                          height: 100.h,
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(35.0),
                                        child: Image.asset(
                                          'assets/camera.png',
                                          color: BC.appColor,
                                        ),
                                      )),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        decoration: BoxDecoration(
                            color: BC.appColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: BC.appColor)),
                        child: Column(
                          children: [
                            MytextField(
                                enable: false,
                                controller: nameController,
                                text: 'الأسم'),
                            SizedBox(
                              height: 10.h,
                            ),
                            MytextField(
                              enable: false,
                              controller: phoneController,
                              text: 'رقم الهاتف',
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            MytextField(
                                enable: false,
                                controller: locationController,
                                text: 'المدينة'),
                            SizedBox(
                              height: 10.h,
                            ),
                            MytextField(
                                enable: false,
                                controller: emailController,
                                text: 'البريد الألكتروني(اختياري)'),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextButton(
                          onPressed: () async {
                            await FirebaseServices().logout();
                          },
                          child: Text(
                            'Log out',
                            style: TextStyle(fontSize: 16.sp),
                          ))
                    ]),
                  ),
                ),
              );
            }));
  }
}

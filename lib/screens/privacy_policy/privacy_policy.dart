import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:waist_app/constants/colors.dart';
import 'package:waist_app/screens/bottom_nav/bottomNavi.dart';
import 'package:waist_app/widgets/arrowButton.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => const BottomNavigationExample());
        return true;
      },
      child: Scaffold(
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
              child: Column(
                children: [
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
                        'الشروط والأحكام',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ArrowButton(
                        onPressed: () {
                          Get.offAll(() => const BottomNavigationExample());
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'عند استخدامك لهذا التطبيق فأنت ملزم بالالتزام بشروط هذه الاتفاقية',
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          color: BC.appColor.withOpacity(0.2),
                          thickness: 1,
                        ),
                        Text(
                          'يلتزم تطبيق ( وسيط ) باتخاذ المعايير اللازمة لحماية البيانات الخاصة للمسجل وحفظها ، علما بأن شبكة الانترنت ليست وسيلة آمنه بنسبة 100 % لحفظ المعلومات السرية ',
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          color: BC.appColor.withOpacity(0.2),
                          thickness: 1,
                        ),
                        Text(
                          'لا يقدم تطبيق ( وسيط ) أي ضمان لأي تعاملات بين العملاء ',
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          color: BC.appColor.withOpacity(0.2),
                          thickness: 1,
                        ),
                        Text(
                          'يمنع استخدام التطبيق للتعامل في بيع الأشياء الممنوعة حسب قوانين المملكة العربية السعودية  وأي مبيعات مخالفة سوف تعرض صاحبها للمسائلة القانونية من خلال السلطات المحلية',
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          color: BC.appColor.withOpacity(0.2),
                          thickness: 1,
                        ),
                        Text(
                          'يجب التقيد بأنظمة وزارة التجارة حيث نخلي مسؤوليتنا عن أي ',
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          color: BC.appColor.withOpacity(0.2),
                          thickness: 1,
                        ),
                        Text(
                          'في حالة رفض العميل استلام الشحنة تخصم عمولة التطبيق  إضافة الي  تكاليف الشحن كاملة',
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          color: BC.appColor.withOpacity(0.2),
                          thickness: 1,
                        ),
                        Text(
                          'لو تأخر ( البائع / مقدم الخدمة ) بالموافقة على الطلب يعطى مهلة  48',
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          color: BC.appColor.withOpacity(0.2),
                          thickness: 1,
                        ),
                        Text(
                          'في حال تأخر ( المشتري أو البائع ) من تأكيد انتهاء الطلب يعطى مهلة  24  ساعة وبعدها يتم تحويل المبلغ للمستفيد',
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          color: BC.appColor.withOpacity(0.2),
                          thickness: 1,
                        ),
                        Text(
                          'يتم تحويل المبلغ للمستفيد بحد أقصى 24 ساعة',
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          color: BC.appColor.withOpacity(0.2),
                          thickness: 1,
                        ),
                        Text(
                          '   تُحدد طريقة الشحن من طرف المشتري',
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          color: BC.appColor.withOpacity(0.2),
                          thickness: 1,
                        ),
                        Text(
                          'يجب على المشتري التأكد من السلعة قبل استلامها',
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          color: BC.appColor.withOpacity(0.2),
                          thickness: 1,
                        ),
                        //
                        Text(
                          'في حال حدوث خلاف بين الطرفين فيتم تعبئة (طلب اعتراض)',
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          color: BC.appColor.withOpacity(0.2),
                          thickness: 1,
                        ),
                        Text(
                          'في حال تم انتهاء المدة المحددة بين الطرفين سيتم إعادة المبلغ للمشتري بعد خصم جميع التكاليف إذا لم يتفق الطرفان على حل ',
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          color: BC.appColor.withOpacity(0.2),
                          thickness: 1,
                        ),
                        Text(
                          'في حال رفض البائع الطلب يتم الغائه ',
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          color: BC.appColor.withOpacity(0.2),
                          thickness: 1,
                        ),
                        //
                        Text(
                          'في حال عدم ُطلب استرجاع المبلغ يتم خصم العمولة ',
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          color: BC.appColor.withOpacity(0.2),
                          thickness: 1,
                        ),
                        //
                        Text(
                          'رسوم التحويل من بنك للآخر يتحملها البائع إذا كان ليس لديه حساب في أحد بنوك التطبيق  ',
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

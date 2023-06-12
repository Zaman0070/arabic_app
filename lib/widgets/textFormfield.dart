import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waist_app/constants/colors.dart';

// ignore: must_be_immutable
class MytextField extends StatelessWidget {
  String? text;
  String? hint;
  bool? enable;
  TextInputType? type;
  TextEditingController? controller;
  MytextField({this.text, this.controller, this.enable, this.hint, this.type});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        keyboardType: type,
        enabled: enable,
        controller: controller,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 0.1)),
          labelText: text,
          hintText: hint,
          contentPadding: const EdgeInsets.only(top: 0, right: 15),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MytextField1 extends StatelessWidget {
  String? text;
  String? hint;
  bool? enable;
  TextInputType? type;
  TextEditingController? controller;
  MytextField1({this.text, this.controller, this.enable, this.hint, this.type});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        keyboardType: type,
        enabled: enable,
        controller: controller,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 0.1)),
          labelText: text,
          hintText: hint,
          contentPadding: const EdgeInsets.only(top: 0, right: 15),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class AppTextField extends StatefulWidget {
  String hint, label;
  bool showLabel;
  bool? isDropDown;
  bool? isSearch;
  List<String>? list;
  TextEditingController controller;
  Function()? dropDownOnTap;
  AppTextField({
    Key? key,
    required this.controller,
    this.isDropDown,
    required this.hint,
    required this.label,
    this.showLabel = false,
    this.dropDownOnTap,
    this.list,
    this.isSearch,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.showLabel = true;
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 5, left: 10.h),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              focusColor: BC.appColor,
              prefixIcon:
                  widget.isSearch == true ? const Icon(Icons.search) : null,
              suffixIcon: widget.isDropDown == true
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 11),
                      child: DropDown(
                        hint: Text(widget.hint),
                        showUnderline: false,
                        isExpanded: true,
                        items: widget.list!,
                        icon: Icon(
                          Icons.expand_more,
                          color: BC.appColor,
                        ),
                        onChanged: (value) {
                          setState(() {
                            widget.controller.text = value!;
                          });
                        },
                      ),
                    )
                  : null,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 0.1)),
              hintText: widget.hint,
              floatingLabelStyle: TextStyle(color: BC.appColor),
              label: Text(widget.label)),
        ),
      ),
    );
  }
}

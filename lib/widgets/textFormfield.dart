import 'package:flutter/material.dart';

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

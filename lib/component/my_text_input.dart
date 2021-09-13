import 'package:flutter/material.dart';
import 'package:tbs_app/config/constant.dart';

class MyTextInput extends StatelessWidget {
  MyTextInput(
      {Key? key,
      required this.controller,
      required this.icon,
      required this.hint,
      this.inputType,
      this.inputAction,
      this.obsecure = false,
      this.suffix})
      : super(key: key);

  final IconData icon;
  final String hint;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final TextEditingController controller;
  Widget? suffix;
  bool obsecure;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
        elevation: kElevation,
        child: Container(
            margin: EdgeInsets.only(top: 4),
            width: size.width * 0.8,
            child: TextFormField(
                controller: controller,
                obscureText: this.obsecure,
                onTap: () {},
                decoration: InputDecoration(
                    suffix: this.suffix,
                    contentPadding: EdgeInsets.only(right: 16, top: 12),
                    hintText: hint,
                    hintStyle: TextStyle(
                      color: Colors.black26,
                      fontStyle: FontStyle.italic,
                      fontSize: kFontSize,
                    ),
                    prefixIcon: Padding(
                        padding: EdgeInsets.only(right: kBaseMargin, left: 8),
                        child: Icon(
                          icon,
                          color: Colors.black26,
                        )),
                    border: InputBorder.none),
                style: TextStyle(fontSize: kFontSize),
                keyboardType: inputType,
                textInputAction: inputAction)));
  }
}

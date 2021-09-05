import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tbs_app/config/constant.dart';

class MyButton extends StatelessWidget {
  final Function onPress;
  final String text;
  Color? color;
  MyButton({Key? key, required this.onPress, required this.text, this.color})
      : super(key: key);

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (color == null) {
      color = Color(kPrimaryColor);
    }
    final height = size.height * 0.08;
    final width = size.width * 0.8;
    return MaterialButton(
      child: Container(
          child: Text(
        this.text.toUpperCase(),
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Arial',
            letterSpacing: 1.2),
      )),
      onPressed: () async {
        this.onPress();
      },
      elevation: 5,
      color: Color(kPrimaryColor),
      height: height,
      minWidth: width,
    );
  }
}

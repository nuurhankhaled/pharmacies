import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  dynamic color = Colors.deepOrange;
  dynamic fontColor = Colors.deepOrange;
  final VoidCallback ontap ;
  double width=0;
  double height=0;
  double fontSize=0;

  String text = "";
  CustomButton(this.text,this.color,this.fontColor, this.ontap,this.height,this.width,this.fontSize);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      height: height,
      minWidth: MediaQuery.of(context).size.width * width,
      color: color,
      textColor: fontColor,
      child: Text(
        text,
        style: TextStyle(
            fontSize: fontSize, fontWeight: FontWeight.bold, fontFamily: "title"),
      ),
      onPressed: ontap,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:soundscape/myhelper/colors/colors.dart';

class MyButtons {
  static Widget myMainButton({required String buttonText, Function? callback,EdgeInsetsGeometry? padding,Gradient? gradient,Color? textColor}) {
    return GestureDetector(
      onTap: () {
        callback!();
      },
      child: Padding(
        padding: padding ?? const EdgeInsets.only(left: 30, right: 30, bottom: 65),
        child: Container(
          width: 330,
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: gradient?? const LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [
                Color(0xFFA692CA),
                Color(0xFF5B5F97),
              ],
              stops: [0.0, 0.9697],
            ),
          ),
          child: Center(child: Text(buttonText,style: TextStyle(color: textColor??MyColors.headingTextColor),)),
        ),
      ),
    );
  }
}

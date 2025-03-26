import 'package:flutter/material.dart';

class CustomTextStyle {
  static  const baseTextStyle = TextStyle(
    // fontFamily: ''
    color: Colors.black
  );

  static TextStyle text_600({double fontSize = 22}) => baseTextStyle.copyWith(
    fontWeight: FontWeight.w600,
    fontSize: fontSize,
  );

  static TextStyle text_300({double fontSize = 22}) => baseTextStyle.copyWith(
    fontWeight: FontWeight.w300,
    fontSize: fontSize,
  );

    static TextStyle text_400({double fontSize = 22}) => baseTextStyle.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: fontSize,
  );

  static TextStyle text_500({double fontSize = 22}) => baseTextStyle.copyWith(
    fontWeight: FontWeight.w300,
    fontSize: fontSize,
  );

    static TextStyle text({double fontSize = 22}) => baseTextStyle.copyWith(
    fontSize: fontSize,
  );
  
}
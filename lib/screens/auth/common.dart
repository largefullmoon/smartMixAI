import 'package:flutter/material.dart';
import 'package:sample/utils.dart';

class CustomInputDecoration {
  static InputDecoration inputBoxDecoration({ required IconData icon, hint = "Enter", password = false }) => InputDecoration(
    filled: true,
    fillColor: Colors.white,
    hintText: hint,
    prefixIcon: Icon(icon, color: hexToColor("#C58346") , size: 20,),
    suffixIcon: password ? Icon(Icons.visibility_off, color: Colors.grey) : null,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  );
}

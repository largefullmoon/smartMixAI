import 'package:flutter/material.dart';

class Indicators {
  static const progressIndicator = Center(
    child: SizedBox(
      height: 50,
      width: 50,
      child: CircularProgressIndicator.adaptive(),
    ),
  );
}

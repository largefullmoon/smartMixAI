import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonBottomBar extends StatelessWidget {
  const CommonBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        height: 60,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () => Get.toNamed('/home'),
              child: Image.asset(
                'assets/btm-1.png',
                height: 20,
                width: 20,
              ),
            ),
            InkWell(
              onTap: () => Get.toNamed('/chat'),
              child: Image.asset(
                'assets/Group-321.png',
                height: 20,
                width: 20,
              ),
            ),
            InkWell(
              onTap: () => Get.toNamed('/home'),
              child: Image.asset(
                'assets/btm-3.png',
                height: 20,
                width: 20,
              ),
            ),
            InkWell(
              onTap: () => Get.toNamed('/favorites'),
              child: Image.asset(
                'assets/btm-4.png',
                height: 20,
                width: 20,
              ),
            ),
            InkWell(
              onTap: () => Get.toNamed('/profile'),
              child: Image.asset(
                'assets/btm-5.png',
                height: 20,
                width: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 
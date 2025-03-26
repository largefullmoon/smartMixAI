import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/screens/questionnare/questionnare.dart';
import 'package:sample/screens/home/view.dart';
import 'package:sample/styles.dart';
import 'package:sample/utils.dart';

class OnBoardScreen extends StatelessWidget {
  const OnBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/bg.png', // Replace with your image asset
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black
                .withValues(alpha: 0.3), // Dark overlay for better contrast
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/logo.png",
                      width: 200,
                      height: 200,
                    ),
                  ),

                  SizedBox(height: 20),
                  Text(
                    "WELCOME TO",
                    style: CustomTextStyle.text_300(),
                  ),

                  Text(
                    "MA CANBANE EN VILLE",
                    style: CustomTextStyle.text_600(),
                  ),
                  SizedBox(height: 40),

                  // Sign In Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed('/taste_preference');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: hexToColor("#C58346"),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "START A QUESTIONNARE",
                          style: CustomTextStyle.text_600(fontSize: 18)
                              .copyWith(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to the next page when the button is pressed
                        Get.toNamed('/dashboard');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "SKIP",
                        style: CustomTextStyle.text_600(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

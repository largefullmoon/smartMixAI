import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sample/screens/auths/auth.controller.dart';
import 'package:sample/screens/auths/register.dart';
import 'package:sample/styles.dart';
import 'package:sample/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController(text: "kumar1@yopmail.com");
  final passwordController = TextEditingController(text: "123456");

  final AuthController _controller = Get.find<AuthController>();

  void _signIn() async {
    final email = emailController.text;
    final password = passwordController.text;
    await _controller.login(email, password);
  }

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
                .withOpacity(0.3), // Dark overlay for better contrast
          ),
          Center(
            child: SingleChildScrollView(
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
                    "Sign In",
                    style: CustomTextStyle.text_600(),
                  ),
                  SizedBox(height: 20),

                  // Username Field
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Username",
                      prefixIcon:
                          Icon(Icons.person, color: hexToColor("#C58346")),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),

                  // Password Field
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Password",
                      prefixIcon:
                          Icon(Icons.lock, color: hexToColor("#C58346")),
                      suffixIcon:
                          Icon(Icons.visibility_off, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Sign In Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _signIn,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: hexToColor("#C58346"),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Sign In",
                        style: CustomTextStyle.text_600(fontSize: 18)
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),

                  // Create Account & Forgotten Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.offAndToNamed('/register');
                        },
                        child: Text("Create An Account",
                            style: CustomTextStyle.text_600(fontSize: 12)),
                      ),
                      Text("|", style: TextStyle(color: hexToColor("#A68774"))),
                      TextButton(
                        onPressed: () {},
                        child: Text("Forgotten Password?",
                            style: CustomTextStyle.text_600(fontSize: 12)),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),

                  // Continue with Google
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon:
                          FaIcon(FontAwesomeIcons.google, color: Colors.black),
                      label: Text(
                        "CONTINUE WITH GOOGLE",
                        style: TextStyle(color: Colors.black),
                      ),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        side: BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  // Continue with Apple
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: FaIcon(FontAwesomeIcons.apple, color: Colors.black),
                      label: Text(
                        "CONTINUE WITH APPLE",
                        style: TextStyle(color: Colors.black),
                      ),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        side: BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
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

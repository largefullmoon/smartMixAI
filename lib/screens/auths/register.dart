import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/screens/auth/common.dart';
import 'package:sample/screens/auths/auth.controller.dart';
import 'package:sample/screens/auths/login.dart';
import 'package:sample/services/auth_service.dart';
import 'package:sample/styles.dart';
import 'package:sample/utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthController _controller = Get.find<AuthController>();

  void _signUp() async {
    final name = nameController.text;
    final email = emailController.text;
    final phone = phoneController.text;
    final password = passwordController.text;

    await _controller.register(
     name,
     password,
     email,
     phone
    );
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
                .withValues(alpha: .3), // Dark overlay for better contrast
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
                    "Create Your Account",
                    style: CustomTextStyle.text_600(),
                  ),
                  SizedBox(height: 20),

                  // name Field
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      controller: nameController,
                      decoration: CustomInputDecoration.inputBoxDecoration(
                          icon: Icons.person, hint: "Enter Name"),
                    ),
                  ),
                  // email Field
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      controller: emailController,
                      decoration: CustomInputDecoration.inputBoxDecoration(
                          icon: Icons.email, hint: "Enter Valid Email"),
                    ),
                  ),
                  // phone Field
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      controller: phoneController,
                      decoration: CustomInputDecoration.inputBoxDecoration(
                          icon: Icons.phone, hint: "Enter Phone Number"),
                    ),
                  ),

                  // Password Field
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: CustomInputDecoration.inputBoxDecoration(
                          icon: Icons.lock, hint: "Password", password: true),
                    ),
                  ),

                  SizedBox(height: 15),
                  // Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _signUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: hexToColor("#C58346"),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Sign Up",
                        style: CustomTextStyle.text_600(fontSize: 18)
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),

                  // Create Account & Forgot Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have Account?",
                          style: CustomTextStyle.text(fontSize: 12)),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          Get.offAndToNamed('/login');
                        },
                        child: Text("Sign In",
                            style: CustomTextStyle.text_600(fontSize: 12)),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

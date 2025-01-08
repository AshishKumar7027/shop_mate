import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_mate/controllers/google_sign_in_controller.dart';
import 'package:shop_mate/screens/auth_ui/sign_up_screen.dart';
import 'package:shop_mate/utils/app_constant.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final GoogleSignInController _googleSignInController =
      Get.put(GoogleSignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appScendoryColor,
        centerTitle: true,
        title: Text(
          'Welcome To My App',
          style: TextStyle(
            color: AppConstant.appTextColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                color: AppConstant.appScendoryColor,
                child: Lottie.asset('images/Animation - 1735492918629.json'),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Happy Shopping',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              SizedBox(height: 50),
              Material(
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: AppConstant.appScendoryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton.icon(
                    onPressed: () {
                      _googleSignInController.signInWithGoogle();
                    },
                    icon: Image.asset('images/icons8-google-48.png'),
                    label: Text(
                      'Sign in with google',
                      style: TextStyle(
                        color: AppConstant.appTextColor,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Material(
                child: Container(
                  width: 300,
                  height: 63,
                  decoration: BoxDecoration(
                      color: AppConstant.appScendoryColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton.icon(
                    onPressed: () {
                      Get.off(() => SignUpScreen());
                    },
                    icon: Icon(
                      Icons.email_outlined,
                      color: AppConstant.appTextColor,
                    ),
                    label: Text(
                      'Sign in with email',
                      style: TextStyle(
                        color: AppConstant.appTextColor,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

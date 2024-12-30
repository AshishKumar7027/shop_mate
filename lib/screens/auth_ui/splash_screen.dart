import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_mate/screens/auth_ui/welcome_screen.dart';
import 'package:shop_mate/screens/user_panel/main_screen.dart';
import 'package:shop_mate/utils/app_constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),(){
      Get.offAll(()=> WelcomeScreen());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstant.appScendoryColor,
        appBar: AppBar(
          backgroundColor: AppConstant.appScendoryColor,
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: Lottie.asset('images/Animation - 1735492918629.json'),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                  AppConstant.appPoweredBy,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,color: AppConstant.appTextColor
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

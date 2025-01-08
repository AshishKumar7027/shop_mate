import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_mate/controllers/get_user_data_controller.dart';
import 'package:shop_mate/controllers/sign_in_controller.dart';
import 'package:shop_mate/screens/admin_panel/admin_panel_screen.dart';
import 'package:shop_mate/screens/auth_ui/forget_password_screen.dart';
import 'package:shop_mate/screens/auth_ui/sign_up_screen.dart';
import 'package:shop_mate/screens/user_panel/main_screen.dart';
import 'package:shop_mate/utils/app_constant.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  SignInController signInController = Get.put(SignInController());
  GetUserDataController getUserDataController =
      Get.put(GetUserDataController());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppConstant.appScendoryColor,
          title: Text(
            'Sign In',
            style: TextStyle(
              color: AppConstant.appTextColor,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                isKeyboardVisible
                    ? Text(
                        'Welcome to my app',
                        style: TextStyle(fontSize: 15),
                      )
                    : Column(
                        children: [
                          Lottie.asset('images/Animation - 1735492918629.json')
                        ],
                      ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.text,
                        cursorColor: AppConstant.appScendoryColor,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: Icon(Icons.email),
                            labelText: 'Email')),
                  ),
                ),
                Container(
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Obx(
                        () => TextFormField(
                            obscureText:
                                signInController.isPasswordVisible.value,
                            controller: passwordController,
                            keyboardType: TextInputType.text,
                            cursorColor: AppConstant.appScendoryColor,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                prefixIcon: Icon(Icons.password),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    signInController.isPasswordVisible.toggle();
                                  },
                                  child:
                                      signInController.isPasswordVisible.value
                                          ? Icon(Icons.visibility_off)
                                          : Icon(Icons.visibility),
                                ),
                                labelText: 'Password')),
                      )),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => ForgetPasswordScreen());
                    },
                    child: Text(
                      'Forget Password?',
                      style: TextStyle(
                        color: AppConstant.appScendoryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Material(
                  child: Container(
                    width: 300,
                    decoration: BoxDecoration(
                      color: AppConstant.appScendoryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton(
                      child: Text(
                        'SIGN IN',
                        style: TextStyle(
                          color: AppConstant.appTextColor,
                          fontSize: 30,
                        ),
                      ),
                      onPressed: () async {
                        String email = emailController.text.trim();
                        String password = passwordController.text.trim();
                        if (email.isEmpty || password.isEmpty) {
                          Get.snackbar(
                            'Error',
                            'Please enter all text filled are required',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppConstant.appScendoryColor,
                            colorText: AppConstant.appTextColor,
                          );
                        } else {
                          UserCredential? userCredential =
                              await signInController.signInMethod(
                                  email, password);
                          var userData = await getUserDataController
                              .getUserData(userCredential!.user!.uid);

                          if (userCredential != null) {
                            if (userCredential.user!.emailVerified) {
                              //
                              if (userData[0]['isAdmin'] == true) {
                                Get.snackbar(
                                  "Success Admin Login",
                                  "login Successfully!",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: AppConstant.appScendoryColor,
                                  colorText: AppConstant.appTextColor,
                                );
                                Get.offAll(() => AdminPanelScreen());
                              } else {
                                Get.offAll(() => MainScreen());
                                Get.snackbar(
                                  "Success User Login",
                                  "login Successfully!",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: AppConstant.appScendoryColor,
                                  colorText: AppConstant.appTextColor,
                                );
                              }
                            } else {
                              Get.snackbar(
                                "Error",
                                "Please verify your email before login",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.appScendoryColor,
                                colorText: AppConstant.appTextColor,
                              );
                            }
                          } else {
                            Get.snackbar(
                              "Error",
                              "Please try again",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appScendoryColor,
                              colorText: AppConstant.appTextColor,
                            );
                          }
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don"t have an account ? ',
                      style: TextStyle(
                        color: AppConstant.appScendoryColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.offAll(() => SignUpScreen()),
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                            color: AppConstant.appScendoryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:shop_mate/controllers/sign_up_controller.dart';
import 'package:shop_mate/screens/auth_ui/sign_in_screen.dart';
import 'package:shop_mate/services/notification_service.dart';
import 'package:shop_mate/utils/app_constant.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController signUpController = Get.put(SignUpController());
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final cityController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppConstant.appScendoryColor,
          title: Text(
            'Sign Up',
            style: TextStyle(
              color: AppConstant.appTextColor,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 16),
                Container(
                  child: Text(
                    'Welcome to my app',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppConstant.appScendoryColor,
                    ),
                  ),
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
                    child: TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        cursorColor: AppConstant.appScendoryColor,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: Icon(Icons.person),
                            labelText: 'User Name')),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        cursorColor: AppConstant.appScendoryColor,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: Icon(Icons.phone),
                            labelText: 'Phone Number')),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                        controller: cityController,
                        keyboardType: TextInputType.streetAddress,
                        cursorColor: AppConstant.appScendoryColor,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: Icon(Icons.location_on),
                            labelText: 'City')),
                  ),
                ),
                Container(
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Obx(
                        () => TextFormField(
                            obscureText:
                                signUpController.isPasswordVisibility.value,
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            cursorColor: AppConstant.appScendoryColor,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                prefixIcon: Icon(Icons.password),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    signUpController.isPasswordVisibility
                                        .toggle();
                                  },
                                  child: signUpController
                                          .isPasswordVisibility.value
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                ),
                                labelText: 'Password')),
                      )),
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
                      onPressed: () async {
                        NotificationService notificationService =
                            NotificationService();
                        String name = nameController.text.trim();
                        String email = emailController.text.trim();
                        String phone = phoneController.text.trim();
                        String city = cityController.text.trim();
                        String password = passwordController.text.trim();
                        String? userDeviceToken =
                            await notificationService.getDeviceToken();

                        if (name.isEmpty ||
                            email.isEmpty ||
                            phone.isEmpty ||
                            city.isEmpty ||
                            password.isEmpty) {
                          Get.snackbar(
                            "Error",
                            "All text filled are required",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppConstant.appScendoryColor,
                            colorText: AppConstant.appTextColor,
                          );
                        } else {
                          UserCredential? userCredential =
                              await signUpController.signUpMethod(name, email,
                                  phone, city, password, userDeviceToken);

                          if (userCredential != null) {
                            Get.snackbar(
                              "Verification email sent.",
                              "Please check your email.",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appScendoryColor,
                              colorText: AppConstant.appTextColor,
                            );

                            FirebaseAuth.instance.signOut();
                            Get.offAll(() => SignInScreen());
                          }
                        }
                      },
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                          color: AppConstant.appTextColor,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(
                        color: AppConstant.appScendoryColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.offAll(() => SignInScreen()),
                      child: Text(
                        'Sign In',
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

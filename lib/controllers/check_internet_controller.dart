import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_mate/utils/app_constant.dart';

class CheckInternetController extends GetxController {
  Connectivity connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    connectivity.onConnectivityChanged.listen(NetStatus);
  }

  NetStatus(ConnectivityResult checkInternet) {
    if (checkInternet == ConnectivityResult.none) {
      Get.rawSnackbar(
        titleText: Container(
          width: double.infinity,
          height: Get.size.height * (.900),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Icon(
                  Icons.wifi_off,
                  size: 80,
                  color: Colors.white,
                ),
              ),
              Text(
                'No Internet Connection Please Try Again',
                style: TextStyle(
                  color: AppConstant.appTextColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        messageText: Container(),
        backgroundColor: AppConstant.appScendoryColor,
        isDismissible: false,
        duration: Duration(days: 1),
      );
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }
}

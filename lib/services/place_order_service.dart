// ignore_for_file: file_names, avoid_print, unused_local_variable, prefer_const_constructors

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shop_mate/models/order_model.dart';
import 'package:shop_mate/screens/user_panel/main_screen.dart';
import 'package:shop_mate/services/genrate_order_id_service.dart';
import 'package:shop_mate/services/notification_service.dart';
import 'package:shop_mate/services/send_notification_service.dart';
import 'package:shop_mate/utils/app_constant.dart';

void placeOrder({
  required BuildContext context,
  required String customerName,
  required String customerPhone,
  required String customerAddress,
  required String customerDeviceToken,
}) async {
  final user = FirebaseAuth.instance.currentUser;
  NotificationService notificationService = NotificationService();

  Future<String?> getAdminToken() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('isAdmin', isEqualTo: true)
          .get();
      if(querySnapshot.docs.isNotEmpty){
        return querySnapshot.docs.first['userDeviceToken'] as String;
      }else{
        return null; // no admin found
      }
      } catch(e){
    print('Error fetching admin token : $e');
    return null;
  }
  }
  String? adminToken = await getAdminToken();

  EasyLoading.show(status: "Please Wait..");
  if (user != null) {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('cart')
          .doc(user.uid)
          .collection('cartOrders')
          .get();

      List<QueryDocumentSnapshot> documents = querySnapshot.docs;

      for (var doc in documents) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>;

        String orderId = generateOrderId();

        OrderModel cartModel = OrderModel(
          productId: data['productId'],
          categoryId: data['categoryId'],
          productName: data['productName'],
          categoryName: data['categoryName'],
          salePrice: data['salePrice'],
          fullPrice: data['fullPrice'],
          productImages: data['productImages'],
          deliveryTime: data['deliveryTime'],
          isSale: data['isSale'],
          productDescription: data['productDescription'],
          createdAt: DateTime.now(),
          updatedAt: data['updatedAt'],
          productQuantity: data['productQuantity'],
          productTotalPrice: double.parse(data['productTotalPrice'].toString()),
          customerId: user.uid,
          status: false,
          customerName: customerName,
          customerPhone: customerPhone,
          customerAddress: customerAddress,
          customerDeviceToken: customerDeviceToken,
        );

        for (var x = 0; x < documents.length; x++) {
          await FirebaseFirestore.instance
              .collection('orders')
              .doc(user.uid)
              .set(
            {
              'uId': user.uid,
              'customerName': customerName,
              'customerPhone': customerPhone,
              'customerAddress': customerAddress,
              'customerDeviceToken': customerDeviceToken,
              'orderStatus': false,
              'createdAt': DateTime.now()
            },
          );

          //upload orders
          await FirebaseFirestore.instance
              .collection('orders')
              .doc(user.uid)
              .collection('confirmOrders')
              .doc(orderId)
              .set(cartModel.toMap());

          //delete cart products
          await FirebaseFirestore.instance
              .collection('cart')
              .doc(user.uid)
              .collection('cartOrders')
              .doc(cartModel.productId.toString())
              .delete()
              .then((value) {
            print('Delete cart Products $cartModel.productId.toString()');
          });
        }
        // save notification
        await FirebaseFirestore.instance
            .collection('notifications')
            .doc(user.uid)
            .collection('notifications')
            .doc()
            .set(
          {
            'title': "Order Successfully placed ${cartModel.productName}",
            'body': cartModel.productDescription,
            'isSeen': false,
            'createdAt': DateTime.now(),
            'image': cartModel.productImages,
            'fullPrice': cartModel.fullPrice,
            'salePrice': cartModel.salePrice,
            'isSale': cartModel.isSale,
            'productId': cartModel.productId,
          },
        );
      }
// send notification to admin
      await SendNotificationService.sendNotificationUsingApi(
        token:adminToken,
        title: "Order Successfully placed $customerName",
        body: "notification body",
        data: {
          "screen": "notification",
        },
      );
      // sent notification
      await SendNotificationService.sendNotificationUsingApi(
        token:customerDeviceToken,
            // "cgMoCTElRL-tSA8vmt_fm1:APA91bE1K5i6Yp7KxWH4H_2IGKxJ-Ow-b8e-HTdoI_jgvY"
            // "a_pUIy-kpi9SRJcGdZjfui6uoqkU80rU8kwikZynToztQYRnq3bfzqP7btSLx2J36"
            // "SoO_VzGM",
        title: "Order Successfully placed",
        body: "notification body",
        data: {
          "screen": "notification",
        },
      );

      print("Order Confirmed");
      Get.snackbar(
        "Order Confirmed",
        "Thank you for your order!",
        backgroundColor: AppConstant.appMainColor,
        colorText: Colors.white,
        duration: Duration(seconds: 5),
      );

      EasyLoading.dismiss();
      Get.offAll(() => MainScreen());
    } catch (e) {
      print("error $e");
    }
  }
}

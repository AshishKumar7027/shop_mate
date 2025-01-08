import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_mate/controllers/notification_controller.dart';
import 'package:shop_mate/screens/user_panel/all_category_screen.dart';
import 'package:shop_mate/screens/user_panel/all_flash_sale_screen.dart';
import 'package:shop_mate/screens/user_panel/all_products_screen.dart';
import 'package:shop_mate/screens/user_panel/cart_screen.dart';
import 'package:shop_mate/screens/user_panel/notification_screen.dart';
import 'package:shop_mate/services/fcm_service.dart';
import 'package:shop_mate/services/notification_service.dart';
import 'package:shop_mate/services/send_notification_service.dart';
import 'package:shop_mate/utils/app_constant.dart';
import 'package:shop_mate/widgets/all_product_widget.dart';
import 'package:shop_mate/widgets/banner_widget.dart';
import 'package:shop_mate/widgets/category_widget.dart';
import 'package:shop_mate/widgets/custom_drawer_widget.dart';
import 'package:shop_mate/widgets/flash_sale_widget.dart';
import 'package:shop_mate/widgets/heading_widget.dart';
import 'package:badges/badges.dart' as badges;

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  NotificationService notificationService = NotificationService();
  final NotificationController notificationController =
      Get.put(NotificationController());

  @override
  void initState() {
    super.initState();
    notificationService.requestNotificationPermission();
    notificationService.getDeviceToken();
    FcmService.firebaseInit();
    notificationService.firebaseInit(context);
    notificationService.setupInteractMessage(context);
    subscribe();
    // String tokenKey = 'cgMoCTElRL-tSA8vmt_fm1:APA91bE1K5i6Yp7KxWH4H_2IGKxJ-Ow-'
    //     'b8e-HTdoI_jgvYa_pUIy-kpi9SRJcGdZjfui6uoqkU80rU8kwikZynToztQYRnq3bf'
    //     'zqP7btSLx2J36SoO_VzGM';
    // SendNotificationService.sendNotificationUsingApi(
    //     token: tokenKey,
    //     title: 'notification title',
    //     body: 'notification body ',
    //     data: {
    //       'screen ': 'cart',
    //     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppConstant.appTextColor,
        ),
        centerTitle: true,
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          AppConstant.appMainName,
          style: TextStyle(
            color: AppConstant.appTextColor,
          ),
        ),
        actions: [
          Obx(() {
            return badges.Badge(
              child: IconButton(
                onPressed: () {
                  Get.to(() => NotificationScreen());
                },
                icon: Icon(
                  Icons.notifications_active,
                ),
              ),
              badgeContent: Text(
                '${notificationController.notificationCount.value}',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              position: badges.BadgePosition.topEnd(
                top: 0,
                end: 3,
              ),
              showBadge: notificationController.notificationCount.value > 0,
            );
          }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () async {
                await SendNotificationService.sendNotificationUsingApi(
                    token: '',
                    title: 'Sweet Chat Powered By Ashish',
                    body: '1 notification',
                    data: {});
              },
              // onPressed: () => Get.to(
              //   () => CartScreen(),
              // ),
              icon: Icon(
                Icons.shopping_cart,
              ),
            ),
          ),
        ],
      ),
      drawer: CustomDrawerWidget(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 10),
              // banner widget
              BannerWidget(),
              // heading widget
              HeadingWidget(
                headingTile: 'Categories',
                headingSubTile: 'According to your budget',
                onTap: () {
                  Get.to(() => AllCategoryScreen());
                },
                buttonText: 'See More >',
              ),
              CategoryWidget(),

              HeadingWidget(
                headingTile: 'Flash Sale',
                headingSubTile: 'According to your budget',
                onTap: () => Get.to(
                  () => AllFlashSaleScreen(),
                ),
                buttonText: 'See More >',
              ),
              FlashSaleWidget(),

              HeadingWidget(
                headingTile: 'All Products',
                headingSubTile: 'According to your budget',
                onTap: () {
                  Get.to(
                    () => AllProductsScreen(),
                  );
                },
                buttonText: 'See More >',
              ),
              AllProductsWidget(),
            ],
          ),
        ),
      ),
    );
  }

  void subscribe() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.subscribeToTopic('all');
    print('Subscribe to all topic');
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shop_mate/screens/user_panel/all_order_screen.dart';
import 'package:shop_mate/utils/app_constant.dart';

class CustomDrawerWidget extends StatefulWidget {
  const CustomDrawerWidget({super.key});

  @override
  State<CustomDrawerWidget> createState() => _CustomDrawerWidgetState();
}

class _CustomDrawerWidgetState extends State<CustomDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height / 20),
      child: Drawer(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        )),
        child: Wrap(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 28,
                vertical: 20,
              ),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(
                    'A',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: AppConstant.appMainColor,
                ),
                title: Text(
                  'Ashish Kumar',
                  style: TextStyle(
                    color: AppConstant.appTextColor,
                  ),
                ),
                subtitle: Text(
                  'Mob : +91 1236547898',
                  style: TextStyle(
                    color: AppConstant.appTextColor,
                  ),
                ),
              ),
            ),
            Divider(
              indent: 10,
              endIndent: 10,
              thickness: 2,
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  color: AppConstant.appTextColor,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 16,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.production_quantity_limits_sharp,
                color: Colors.white,
              ),
              title: Text(
                'Products',
                style: TextStyle(
                  color: AppConstant.appTextColor,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 16,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              title: Text(
                'Setting',
                style: TextStyle(
                  color: AppConstant.appTextColor,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 16,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.notifications_none,
                color: Colors.white,
              ),
              title: Text(
                'Notifications',
                style: TextStyle(
                  color: AppConstant.appTextColor,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 16,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.language,
                color: Colors.white,
              ),
              title: Text(
                'App language',
                style: TextStyle(
                  color: AppConstant.appTextColor,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 16,
              ),
            ),
            ListTile(
              onTap: (){
                Get.back();
                Get.to(() => AllOrdersScreen());
              },
              leading: Icon(
                Icons.shop,
                color: Colors.white,
              ),
              title: Text(
                'Orders',
                style: TextStyle(
                  color: AppConstant.appTextColor,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 16,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.person_2,
                color: Colors.white,
              ),
              title: Text(
                'Invite a friend',
                style: TextStyle(
                  color: AppConstant.appTextColor,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 16,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.list,
                color: Colors.white,
              ),
              title: Text(
                'Lists',
                style: TextStyle(
                  color: AppConstant.appTextColor,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 16,
              ),
            ),
            ListTile(
              onTap: () async {
                GoogleSignIn googleSignIn = GoogleSignIn();
                FirebaseAuth auth = FirebaseAuth.instance;
                auth.signOut();
                await googleSignIn.signOut();
              },
              leading: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                  color: AppConstant.appTextColor,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 16,
              ),
            ),
            Divider(
              endIndent: 10,
              indent: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 18,
                top: 6,
              ),
              child: Text(
                'Also from meta',
                style: TextStyle(
                  color: AppConstant.appTextColor,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.facebook,
                color: Colors.white,
              ),
              title: Text(
                'Facebook',
                style: TextStyle(
                  color: AppConstant.appTextColor,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppConstant.appScendoryColor,
      ),
    );
  }
}

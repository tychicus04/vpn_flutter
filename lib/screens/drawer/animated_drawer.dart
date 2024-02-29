import 'package:eye_vpn_lite/screens/landing/home_screen.dart';
import 'package:eye_vpn_lite/screens/network/network_test_screen.dart';
import 'package:eye_vpn_lite/screens/policy/privacy_policy.dart';
import 'package:eye_vpn_lite/screens/share/share_with_friend_screen.dart';
import 'package:eye_vpn_lite/screens/speed_test/speed_test_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../helpers/ad_helper.dart';
import '../../helpers/config.dart';
import '../../helpers/pref.dart';
import '../../widgets/customer_support_alert_dialogue.dart';
import '../../widgets/rate_us_alert_dialog.dart';
import '../../widgets/watch_ad_dialog.dart';

class AnimatedDrawerScreen extends StatefulWidget {
  @override
  _AnimatedDrawerScreenState createState() => _AnimatedDrawerScreenState();
}

class _AnimatedDrawerScreenState extends State<AnimatedDrawerScreen> {
  final ZoomDrawerController zoomDrawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Pref.isDarkMode ? Colors.black54 : Colors.blue,
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          title: Text('VPN Free'),
          // leading: IconButton(
          //   icon: Icon(Icons.menu),
          //   onPressed: () {
          //     zoomDrawerController.toggle!();
          //   },
          // ),
        ),
        drawer: MenuScreen(),
        body: HomeScreen()

        // ZoomDrawer(
        //   controller: zoomDrawerController,
        //   menuScreen: MenuScreen(),
        //   mainScreen: HomeScreen(),
        //   style: DrawerStyle.defaultStyle,
        //   // borderRadius: 24.0,
        //   // angle: -10.0,
        //   // showShadow: true,
        //   // drawerShadowsBackgroundColor: Colors.amber,
        //   // slideWidth: MediaQuery.of(context).size.width * 0.75,
        // ),
        );
  }
}

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Pref.isDarkMode ? Colors.black54 : Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              // <-- SEE HERE
              decoration: BoxDecoration(color: Colors.white),
              accountName: Text(
                "Pinkesh Darji",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
              accountEmail: Text(
                "pinkesh.earth@gmail.com",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
              currentAccountPicture: Image.asset("assets/logo.png"),
            ),

            ListTile(
              leading: CircleAvatar(
                  backgroundColor: Colors.amber,
                  child: Image.asset(
                    "assets/images/home.png",
                    color: Colors.white,
                  )),
              title: Text(
                'Home',
                style: TextStyle(color: Colors.amber, fontSize: 16.sp),
              ),
              onTap: () {
                // Handle network info navigation
              },
            ),
            // ListTile(
            //   leading: CircleAvatar(
            //       backgroundColor: Colors.blueAccent,
            //       child: Icon(Icons.speed,color: Colors.white,)),
            //   title: Text('Speed Test',style: TextStyle(color: Colors.white,fontSize: 16.sp),),
            //   onTap: () {
            //     Get.to(()=>SpeedTestScreen(),transition: Transition.rightToLeft);
            //     // Handle network info navigation
            //   },
            // ),
            ListTile(
              leading: CircleAvatar(
                  backgroundColor: Colors.amber,
                  child: Image.asset(
                    "assets/images/network.png",
                    color: Colors.white,
                  )),
              title: Text(
                'Info Network',
                style: TextStyle(color: Colors.amber, fontSize: 16.sp),
              ),
              onTap: () {
                Get.to(() => NetworkTestScreen(),
                    transition: Transition.rightToLeft);
                // Handle network info navigation
              },
            ),
            ListTile(
              leading: CircleAvatar(
                  backgroundColor: Colors.amber,
                  child: Image.asset(
                    "assets/images/invite_friend.png",
                    color: Colors.white,
                  )),
              title: Text(
                'Invite Friends',
                style: TextStyle(color: Colors.amber, fontSize: 16.sp),
              ),
              onTap: () {
                Get.to(() => ShareWithFriendsScreen(),
                    transition: Transition.rightToLeft);
                // Handle network info navigation
              },
            ),
            ListTile(
              leading: CircleAvatar(
                  backgroundColor: Colors.amber,
                  child: Image.asset(
                    "assets/images/support.png",
                    color: Colors.white,
                  )),
              title: Text(
                'Customer Support',
                style: TextStyle(color: Colors.amber, fontSize: 16.sp),
              ),
              onTap: () {
                customerSupportAlertDialogue(context);

                // Handle network info navigation
              },
            ),
            // ListTile(
            //   leading: CircleAvatar(
            //       backgroundColor: Colors.blueAccent,
            //       child: Icon(
            //         Icons.star,
            //         color: Colors.white,
            //       )),
            //   title: Text(
            //     'Rate us',
            //     style: TextStyle(color: Colors.white, fontSize: 16.sp),
            //   ),
            //   onTap: () {
            //     RateUsAlertDialog(context);
            //     // Handle network info navigation
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

class MainContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Main Content Goes Here',
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}

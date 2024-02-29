import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:eye_vpn_lite/apis/apis.dart';
import 'package:eye_vpn_lite/helpers/my_dialogs.dart';
import 'package:eye_vpn_lite/models/ip_details.dart';
import 'package:eye_vpn_lite/models/vpn_free.dart';
import 'package:eye_vpn_lite/screens/drawer/animated_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/ad_helper.dart';
import '../../main.dart';
import '../landing/home_screen.dart';
import '../onbgoarding/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _fileChecksum = "---";

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 2000), () async {
      //exit full-screen
      SharedPreferences prefs = await SharedPreferences.getInstance();

      AdHelper.precacheInterstitialAd();
      AdHelper.precacheNativeAd();

      //navigate to home

      if (prefs.getString('firstTime') == 'false') {
        Get.off(() => AnimatedDrawerScreen());
      } else {
        Get.off(() => AnimatedDrawerScreen());
      }

      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (_) => OnBoard()));
    });
  }

  @override
  Widget build(BuildContext context) {
    //initializing media query (for getting device screen size)
    mq = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 62, 41, 2),
              Colors.white
            ], // Gradient colors
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  "assets/logo.png",
                  height: 150.h,
                  width: 150.w,
                ),
              ),

              Center(
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "VPN Free",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp),
                    )),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 60.w, vertical: 100.h),
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.amber,
                      ),
                    ),
                  ],
                ),
              ),

              // IconButton(onPressed: (){
              //   splashScreenController.authorizeWithBiometricsOrPassword();
              // }, icon: Icon(Icons.fingerprint,size: 65.h,color: Colors.white,))
            ],
          ),
        ),
      ),
    );
  }
}

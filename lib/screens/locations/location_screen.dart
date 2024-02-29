import 'package:eye_vpn_lite/screens/locations/vip_server_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import '../../controllers/location_controller.dart';
import '../../controllers/native_ad_controller.dart';
import '../../helpers/ad_helper.dart';
import '../../helpers/pref.dart';
import '../../main.dart';
import '../../utils/colors/app_colors.dart';
import '../../widgets/vpn_card.dart';

class LocationScreen extends StatelessWidget {
  LocationScreen({super.key});

  final _controller = LocationController();
  final _adController = NativeAdController();

  @override
  Widget build(BuildContext context) {
    if (_controller.vpnFreeList.isEmpty) _controller.getVpnData();

    _adController.ad = AdHelper.loadNativeAd(adController: _adController);

    return Obx(
      () => DefaultTabController(
        length: 2, // Number of tabs
        child: Scaffold(
          //backgroundColor: Pref.isDarkMode?AppColors.appDarkColor:AppColors.appWhiteColor,
          appBar: AppBar(
            backgroundColor: Pref.isDarkMode
                ? AppColors.appDarkPrimaryColor
                : AppColors.appPrimaryColor,
            elevation: 0,
            title: Text(
              'VPN Locations (${_controller.vpnFreeList.length})',
              style: TextStyle(color: Colors.amber),
            ),
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.amber,
              ),
            ),
            bottom: TabBar(
              indicatorColor: Colors.amber,
              unselectedLabelColor: Colors.black,
              labelColor: Colors.amber,
              tabs: [
                Tab(text: 'Free Server'), // First tab
                Tab(text: 'VIP Server'), // Second tab
              ],
            ),
          ),

          bottomNavigationBar:
              // Config.hideAds ? null:
              _adController.ad != null && _adController.adLoaded.isTrue
                  ? SafeArea(
                      child: SizedBox(
                          height: 85, child: AdWidget(ad: _adController.ad!)))
                  : null,

          //refresh button
          // floatingActionButton: Padding(
          //   padding: const EdgeInsets.only(bottom: 10, right: 10),
          //   child: FloatingActionButton(
          //       onPressed: () => _controller.getVpnData(),
          //       child: Icon(CupertinoIcons.refresh)),
          // ),

          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: Pref.isDarkMode
                ? BoxDecoration(
                    color: Pref.isDarkMode ? AppColors.appDarkColor : null,
                  )
                : BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.appPrimaryColor,
                        AppColors.appPrimaryColor.withOpacity(0.6),
                        AppColors.appPrimaryColor.withOpacity(0.4),
                        AppColors.appPrimaryColor.withOpacity(0.1),
                        // AppColors.appWhiteColor,
                      ],
                    ),
                  ),
            child: TabBarView(
              children: [
                // Content for the "Free Server" tab
                _controller.isLoading.value
                    ? _loadingWidget()
                    : _controller.vpnFreeList.isEmpty
                        ? _noVPNFound()
                        : _vpnData(),
                // Content for the "VIP Server" tab (You can add your design here)
                VipServerScreen()
              ],
            ),
          ),
        ),
      ),
    );
  }

  _vpnData() => ListView.builder(
      itemCount: _controller.vpnFreeList.length,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(
          top: mq.height * .010,
          bottom: mq.height * .010,
          left: mq.width * .04,
          right: mq.width * .04),
      itemBuilder: (ctx, i) => VpnCard(vpn: _controller.vpnFreeList[i]));

  _loadingWidget() => SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //lottie animation
            LottieBuilder.asset('assets/lottie/loading.json',
                width: mq.width * .7),
          ],
        ),
      );

  _noVPNFound() => Center(
        child: Text(
          'VPNs Server Not Found!',
          style: TextStyle(
              fontSize: 18, color: Colors.black54, fontWeight: FontWeight.bold),
        ),
      );
}

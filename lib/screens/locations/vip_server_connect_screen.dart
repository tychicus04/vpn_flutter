import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/home_controller.dart';
import '../../helpers/pref.dart';
import '../../main.dart';
import '../../services/vpn_engine.dart';
import '../../utils/colors/app_colors.dart';
import '../../widgets/count_down_timer.dart';



class VipServerConnectScreen extends StatefulWidget {
  VipServerConnectScreen({super.key});

  @override
  State<VipServerConnectScreen> createState() => _VipServerConnectScreenState();
}

class _VipServerConnectScreenState extends State<VipServerConnectScreen> {
  final _controller = Get.put(HomeController());

  dynamic country;
  dynamic username;
  dynamic password;
  dynamic config;

  Future<void> loadStoredData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Update the UI with the retrieved data
    setState(() {
      // Retrieve data from SharedPreferences
      country = prefs.getString('country') ?? '';
      username = prefs.getString('username') ?? '';
      password = prefs.getString('password') ?? '';
      config = prefs.getString('config') ?? '';

      print("Country name>>> "+country);
      print("Username>>> "+username);
      print("Password>>> "+password);
      print("Config>>> "+config);
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadStoredData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///Add listener to update vpn state
    VpnEngine.vpnStageSnapshot().listen((event) {
      _controller.vpnState.value = event;
    });

    return Scaffold(
      // backgroundColor: Pref.isDarkMode?AppColors.appDarkColor:AppColors.appWhiteColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        titleSpacing: 5,
        title: Text('${country} server',style: TextStyle(
          color: Colors.white
        ),),
        backgroundColor: Pref.isDarkMode?AppColors.appDarkPrimaryColor:AppColors.appPrimaryColor,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,color: AppColors.appWhiteColor,),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: Pref.isDarkMode?BoxDecoration(
          color: Pref.isDarkMode?AppColors.appDarkColor:null,
        ):BoxDecoration(
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
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start, children: [
          //vpn button


          Obx(() => SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _vpnButton(context),
              ],
            ),
          ),
          ),
        ]),
      ),
    );
  }

  //vpn button
  Widget _vpnButton(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20
    ),
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: Pref.isDarkMode?AppColors.appDarkPrimaryColor:AppColors.appPrimaryColor.withOpacity(0.5),
            ),
            child: Column(
              children: [
                Text("Connecting Time",style: TextStyle(color: AppColors.appWhiteColor.withOpacity(0.7)),),

                SizedBox(height: 5,),

                //count down timer
                Obx(() => CountDownTimer(
                    startTimer:
                    _controller.vpnState.value == VpnEngine.vpnConnected)),
              ],
            ),
          ),

          SizedBox(height: 15,),

          //button
          Semantics(
            button: true,
            child: InkWell(
              onTap: () {
                _controller.connectToVipServer(
                    country,
                    username,
                    password,
                    config
                );
              },
              borderRadius: BorderRadius.circular(100),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                    _controller.vpnState.value == VpnEngine.vpnConnected?
                    AppColors.vpnConnectedColor.withOpacity(0.3):Colors.red.withOpacity(0.2)),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                      _controller.vpnState.value == VpnEngine.vpnConnected?
                      AppColors.vpnConnectedColor.withOpacity(0.3):Colors.red.withOpacity(0.1)),
                  child: Container(
                    width: mq.height * .14,
                    height: mq.height * .14,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                        _controller.vpnState.value == VpnEngine.vpnConnected?
                        AppColors.vpnConnectedColor.withOpacity(0.5): Colors.red.withOpacity(0.2)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //icon
                        Icon(
                          Icons.power_settings_new,
                          size: 28,
                          color: AppColors.appWhiteColor,
                        ),

                        SizedBox(height: 4),

                        //text
                        Text(
                          _controller.getButtonText,
                          style: TextStyle(
                              fontSize: 12.5,
                              color: AppColors.appWhiteColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 10,),
          //connection status label
          Container(
            margin:
            EdgeInsets.only(top: mq.height * .015, bottom: mq.height * .02),
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            decoration: BoxDecoration(
                color: AppColors.appPrimaryColor, borderRadius: BorderRadius.circular(5)),
            child: Text(
              _controller.vpnState.value == VpnEngine.vpnDisconnected
                  ? 'Not Connected'
                  : _controller.vpnState.replaceAll('_', ' ').toUpperCase(),
              style: TextStyle(fontSize: 12.5, color: AppColors.appWhiteColor, fontWeight: FontWeight.w500),
            ),
          ),

          SizedBox(height: 25,),
        ],
      ),
    ),
  );
}

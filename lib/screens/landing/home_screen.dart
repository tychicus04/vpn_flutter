import 'package:eye_vpn_lite/apis/vpn_free_repository.dart';
import 'package:eye_vpn_lite/models/get_access.dart';
import 'package:eye_vpn_lite/screens/get_code_screen.dart';
import 'package:eye_vpn_lite/utils/share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/home_controller.dart';
import '../../helpers/ad_helper.dart';
import '../../helpers/config.dart';
import '../../helpers/pref.dart';
import '../../main.dart';

import '../../models/vpn_status.dart';
import '../../services/vpn_engine.dart';
import '../../widgets/count_down_timer.dart';
import '../../widgets/home_card.dart';
import '../../widgets/watch_ad_dialog.dart';
import '../locations/location_screen.dart';
import '../network/network_test_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = Get.put(HomeController());
  final TextEditingController randomCode = TextEditingController();

  final ZoomDrawerController zoomDrawerController = ZoomDrawerController();
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // late Future<bool> check;

  // Future<void> isCheck() async {
  //   final SharedPreferences prefs = await _prefs;
  //   final bool isCheck = prefs.getBool('check') ?? true;
  //   setState(() {
  //     check = prefs.setBool('check', isCheck).then((bool success) {
  //       return check;
  //     });
  //   });
  // }

  bool isShowDialog = false;
  String session_id = "";
  String hash_code = "";
  String status = "";
  String url = "";
  @override
  Widget build(BuildContext context) {
    ///Add listener to update vpn state
    VpnEngine.vpnStageSnapshot().listen((event) {
      _controller.vpnState.value = event;
    });

    Pref.getSessionId().then((value) {
      setState(() {
        session_id = value;
      });
    });

    Pref.getShowDialog().then((value) {
      setState(() {
        isShowDialog = value;
      });
      // value will be your data stored in that key
    });

    Pref.getHash().then((value) {
      // print(value);
      setState(() {
        hash_code = value;
      });
      // value will be your data stored in that key
    });

    Pref.getStatus().then((value) {
      // print(value);
      setState(() {
        status = value;
      });
      // value will be your data stored in that key
    });

    Pref.getUrl().then((value) {
      // print(value);
      setState(() {
        url = value;
      });
      // value will be your data stored in that key
    });

    return Scaffold(
      //body
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //vpn button
                  Container(
                    color: Color(0xff02273e),
                    height: 500,
                    width: double.infinity,
                    child: Obx(() => Column(
                          children: [
                            _vpnButton(),
                          ],
                        )),
                  ),

                  _changeLocation(context),

                  Card(
                    elevation: 0,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Obx(
                          () => Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.grey.shade200),
                                    height: 50,
                                    width: 80,
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Colors.blue,
                                      child: _controller
                                              .vpnFree.value.region!.isEmpty
                                          ? Icon(Icons.vpn_lock_rounded,
                                              size: 30, color: Colors.white)
                                          : null,
                                      backgroundImage: _controller
                                              .vpnFree.value.region!.isEmpty
                                          ? null
                                          : AssetImage(
                                              'assets/flags/${_controller.vpnFree.value.region!.split(", ")[1].trim().toLowerCase()}.png'),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _controller
                                                .vpnFree.value.region!.isEmpty
                                            ? 'Country'
                                            : _controller.vpnFree.value.region!,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "FREE",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              //ping time
                              Expanded(
                                child: HomeCard(
                                    title: _controller
                                            .vpnFree.value.region!.isEmpty
                                        ? '100 ms'
                                        : '${_controller.vpnFree.value.srvload} ms',
                                    icon: CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.orange,
                                      child: Icon(
                                        Icons.equalizer_rounded,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ]),
          ),
          isShowDialog
              ? Container(
                  color: Colors.black.withOpacity(0.5),
                  child: AlertDialog(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Thông báo",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.amber,
                            fontSize: 30,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Bạn đã hết thời gian Free!",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.amber,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "Làm nhiệm vụ để sử dụng tiếp dịch vụ: ",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.amber,
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                        TextField(
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                          decoration: InputDecoration(
                            hintText: "Nhập code để tiếp tục sử dụng dịch vụ",
                            hintStyle: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          controller: randomCode,
                        )
                      ],
                    ),
                    backgroundColor: Colors.white,
                    actionsAlignment: MainAxisAlignment.center,
                    actions: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => GetAdsScreen(
                                url: url,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              "OK",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          _controller.validateAds(hash_code, randomCode.text);
                          if (status.isEmpty) {
                          } else if (status == "success") {
                            Pref.setShowDialog(false);
                            Pref.setCheck(true);
                            _controller.getAccess();
                            _controller.connectToFreeVpn();
                          } else if (status == "fail") {}
                        },
                        // onTap: () {
                        //   Pref.setShowDialog(false);
                        //   Pref.setCheck(true);
                        //   _controller.getAccess();
                        //   _controller.connectToFreeVpn();
                        // },
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              "Áp dụng",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  //vpn button
  Widget _vpnButton() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            Text(
              "Connecting Time",
              style: TextStyle(color: Colors.white70),
            ),

            SizedBox(
              height: 5,
            ),

            //count down timer
            Obx(() => CountDownTimer(
                startTimer:
                    _controller.vpnState.value == VpnEngine.vpnConnected)),

            SizedBox(
              height: 15,
            ),

            //button
            Semantics(
              button: true,
              child: InkWell(
                onTap: () {
                  if (_controller.vpnState.value == VpnEngine.vpnConnected) {
                    _controller.killSession(session_id);
                    _controller.getAccess();
                    _controller.connectToFreeVpn();
                  } else if (_controller.vpnState.value ==
                      VpnEngine.vpnDisconnected) {
                    _controller.getAccess();
                    _controller.connectToFreeVpn();
                  }
                },
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _controller.getButtonColor.withOpacity(.1)),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _controller.getButtonColor.withOpacity(.3)),
                    child: Container(
                      width: mq.height * .14,
                      height: mq.height * .14,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _controller.getButtonColor),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //icon
                          Icon(
                            Icons.power_settings_new,
                            size: 28,
                            color: Colors.white,
                          ),

                          SizedBox(height: 4),

                          //text
                          Text(
                            _controller.getButtonText,
                            style: TextStyle(
                                fontSize: 12.5,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),
            //connection status label
            Container(
              margin: EdgeInsets.only(
                  top: mq.height * .015, bottom: mq.height * .02),
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(15)),
              child: Text(
                _controller.vpnState.value == VpnEngine.vpnDisconnected
                    ? 'Not Connected'
                    : _controller.vpnState.replaceAll('_', ' ').toUpperCase(),
                style: TextStyle(
                    fontSize: 12.5,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            StreamBuilder<VpnStatus?>(
                initialData: VpnStatus(),
                stream: VpnEngine.vpnStatusSnapshot(),
                builder: (context, snapshot) => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //download
                          HomeCard(
                              title: '${snapshot.data?.byteIn ?? '0 kbps'}',
                              subtitle: 'DOWNLOAD',
                              icon: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.lightGreen,
                                child: Icon(Icons.arrow_downward_rounded,
                                    size: 20, color: Colors.white),
                              )),

                          //upload
                          HomeCard(
                              title: '${snapshot.data?.byteOut ?? '0 kbps'}',
                              subtitle: 'UPLOAD',
                              icon: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.amber,
                                child: Icon(Icons.arrow_upward_rounded,
                                    size: 20, color: Colors.white),
                              )),
                        ],
                      ),
                    )),
          ],
        ),
      );

  //bottom nav to change location
  Widget _changeLocation(BuildContext context) => Semantics(
        button: true,
        child: InkWell(
          onTap: () => Get.to(() => LocationScreen(),
              transition: Transition.rightToLeft),
          child: Container(
              color: Theme.of(context).bottomNav,
              padding: EdgeInsets.symmetric(horizontal: mq.width * .04),
              height: 60,
              child: Row(
                children: [
                  //icon
                  Icon(CupertinoIcons.globe, color: Colors.white, size: 28),

                  //for adding some space
                  SizedBox(width: 10),

                  //text
                  Text(
                    'Change Location',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),

                  //for covering available spacing
                  Spacer(),

                  //icon
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.keyboard_arrow_right_rounded,
                        color: Colors.amber, size: 26),
                  )
                ],
              )),
        ),
      );
}

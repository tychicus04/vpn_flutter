import 'dart:math';

import 'package:eye_vpn_lite/helpers/my_dialogs.dart';
import 'package:eye_vpn_lite/models/vpn_free.dart';
import 'package:eye_vpn_lite/utils/share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../helpers/pref.dart';
import '../main.dart';
import '../models/vpn.dart';
import '../services/vpn_engine.dart';
import '../utils/colors/app_colors.dart';

class VpnCard extends StatefulWidget {
  final Datum vpn;

  const VpnCard({super.key, required this.vpn});

  @override
  State<VpnCard> createState() => _VpnCardState();
}

String session_id = "";

class _VpnCardState extends State<VpnCard> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    String flag = widget.vpn.region!.split(", ")[1].trim().toLowerCase();

    Pref.getSessionId().then((value) {
      setState(() {
        session_id = value;
      });
    });

    return Card(
        elevation: 2,
        color: Pref.isDarkMode
            ? AppColors.appDarkPrimaryColor
            : AppColors.appWhiteColor.withOpacity(0.8),
        margin: EdgeInsets.symmetric(vertical: mq.height * .01),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: InkWell(
          onTap: () async {
            controller.vpnFree.value = widget.vpn;
            Pref.datum = widget.vpn;
            Get.back();

            MyDialogs.success(msg: 'Connecting VPN Location...');

            if (controller.vpnState.value == VpnEngine.vpnConnected) {
              VpnEngine.stopVpn();
              Future.delayed(Duration(seconds: 2), () {
                controller.killSession(session_id);
                Pref.setCheck(false);
                controller.getAccess();
                controller.connectToFreeVpn();
              });
            } else if (controller.vpnState.value == VpnEngine) {
            } else {
              Pref.setCheck(false);
              controller.getAccess();
              controller.connectToFreeVpn();
            }
          },
          borderRadius: BorderRadius.circular(15),
          child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

            //flag
            leading: Container(
              padding: EdgeInsets.all(.5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(5)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset('assets/flags/${flag}.png',
                    height: 40, width: mq.width * .15, fit: BoxFit.cover),
              ),
            ),

            //title
            title: Text(widget.vpn.region!),

            //subtitle
            subtitle: Row(
              children: [
                Icon(Icons.speed_rounded, color: Colors.amber, size: 20),
                SizedBox(width: 4),
                // Text(_formatBytes(int.parse(vpn.srvload.toString()), 1),
                // style: TextStyle(fontSize: 13))
              ],
            ),
          ),
        ));
  }

  String _formatBytes(int bytes, int decimals) {
    if (bytes <= 0) return "0 B";
    const suffixes = ['Bps', "Kbps", "Mbps", "Gbps", "Tbps"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}

import 'dart:async';

import 'package:eye_vpn_lite/controllers/get_ads_controller.dart';
import 'package:eye_vpn_lite/controllers/home_controller.dart';
import 'package:eye_vpn_lite/helpers/pref.dart';
import 'package:eye_vpn_lite/services/vpn_engine.dart';
import 'package:eye_vpn_lite/utils/share.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountDownTimer extends StatefulWidget {
  final bool startTimer;

  const CountDownTimer({super.key, required this.startTimer});

  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  Duration _duration = Duration();
  Timer? _timer;
  final _controller = Get.put(HomeController());
  final _getController = Get.put(GetAdsController());

  _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _duration = Duration(seconds: _duration.inSeconds + 1);
      });
    });
  }

  _stopTimer() {
    setState(() {
      _timer?.cancel();
      _timer = null;
      _duration = Duration();
    });
  }

  bool isCheck = false;
  String session_id = "";
  @override
  Widget build(BuildContext context) {
    if (_timer == null || !widget.startTimer) {
      widget.startTimer ? _startTimer() : _stopTimer();
    }
    // Pref.setCheck(falseVar);

    Pref.getCheck().then((value) {
      setState(() {
        isCheck = value;
      });
      // value will be your data stored in that key
    });

    Pref.getSessionId().then((value) {
      setState(() {
        session_id = value;
      });
      // value will be your data stored in that key
    });

    String twoDigit(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigit(_duration.inMinutes.remainder(60));
    final seconds = twoDigit(_duration.inSeconds.remainder(60));
    final hours = twoDigit(_duration.inHours.remainder(60));
    if (isCheck) {
      if (_duration.inMinutes == 30) {
        _controller.killSession(session_id);
        _controller.connectToFreeVpn();
        _getController.getAds();
        Pref.setShowDialog(true);
        Pref.setCheck(false);
      }
    } else {
      if (_duration.inMinutes == 3) {
        _controller.killSession(session_id);
        _controller.connectToFreeVpn();
        _getController.getAds();
        Pref.setShowDialog(true);
      }
    }

    return Container(
      child: Text(
        '$hours: $minutes: $seconds',
        style: TextStyle(fontSize: 30, color: Colors.white),
      ),
    );
  }
}

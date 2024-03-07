import 'dart:convert';

import 'package:eye_vpn_lite/apis/vpn_free_repository.dart';
import 'package:eye_vpn_lite/models/vpn_free.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/ad_helper.dart';
import '../helpers/my_dialogs.dart';
import '../helpers/pref.dart';
import '../models/vpn.dart';
import '../models/vpn_config.dart';
import '../services/vpn_engine.dart';

class HomeController extends GetxController {
  // final Rx<Vpn> vpn = Pref.vpn.obs;
  final Rx<Datum> vpnFree = Pref.datum.obs;

  final vpnState = VpnEngine.vpnDisconnected.obs;

  void connectToFreeVpn() async {
    if (vpnFree.value.hostname!.isEmpty) {
      MyDialogs.info(msg: 'Select a Location by clicking \'Change Location\'');
      return;
    }

    if (vpnState.value == VpnEngine.vpnDisconnected) {
      print("ALO: ${vpnFree.value.configuration!}");
      final data = Base64Decoder().convert(vpnFree.value.configuration!);
      print("Check Config $data");
      final config = Utf8Decoder().convert(data);

      final vpnConfig = VpnConfig(
        country: vpnFree.value.region!,
        username: 'vpn',
        password: 'vpn',
        config: config,
      );
      await VpnEngine.startVpn(vpnConfig);
    } else {
      await VpnEngine.stopVpn();
    }
  }

  Future<void> getAccess() async {
    await FreeServerRepository.getAccess();
  }

  Future<void> killSession(String session_id) async {
    await FreeServerRepository.killSession(session_id);
  }

  Future<void> validateAds(String hashCode, String code) async {
    await FreeServerRepository.validateAds(hashCode, code);
  }

  void connectToVipServer(
    dynamic countryName,
    dynamic userName,
    dynamic password,
    dynamic config,
  ) async {
    if (vpnState.value == VpnEngine.vpnDisconnected) {
      // log('\nBefore: ${vpn.value.openVPNConfigDataBase64}');
      List<int> decodedBytes = base64.decode(config);
      final decodedConfig = utf8.decode(decodedBytes);

      final vpnConfig = VpnConfig(
          country: countryName,
          username: userName,
          password: password,
          config: '''
          $decodedConfig
          ''');

      // log('\nAfter: $config');

      //code to show interstitial ad and then connect to vpn
      AdHelper.showInterstitialAd(onComplete: () async {
        await VpnEngine.startVpn(vpnConfig);
      });
    } else {
      await VpnEngine.stopVpn();
    }
  }

  // vpn buttons color
  Color get getButtonColor {
    switch (vpnState.value) {
      case VpnEngine.vpnDisconnected:
        return Colors.amber;

      case VpnEngine.vpnConnected:
        return Colors.green;

      default:
        return Colors.orangeAccent;
    }
  }

  // vpn button text
  String get getButtonText {
    switch (vpnState.value) {
      case VpnEngine.vpnDisconnected:
        return 'Tap to Connect';

      case VpnEngine.vpnConnected:
        return 'Disconnect';

      default:
        return 'Connecting...';
    }
  }
}

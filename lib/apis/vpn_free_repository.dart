import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:eye_vpn_lite/apis/apis.dart';
import 'package:eye_vpn_lite/helpers/my_dialogs.dart';
import 'package:eye_vpn_lite/helpers/pref.dart';
import 'package:eye_vpn_lite/models/get_access.dart';
import 'package:eye_vpn_lite/models/get_ads.dart';
import 'package:eye_vpn_lite/models/get_ads.dart';

import 'package:eye_vpn_lite/models/ip_details.dart';
import 'package:eye_vpn_lite/models/kill_session.dart';
import 'package:eye_vpn_lite/models/validate_ads.dart';

import 'package:eye_vpn_lite/models/vpn_free.dart';
import 'package:eye_vpn_lite/utils/share.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class FreeServerRepository {
  static Future<List<Datum>> getVpnFree() async {
    String? ip_address;

    try {
      final res = await get(Uri.parse('http://ip-api.com/json/'));
      final data = jsonDecode(res.body);
      log(data.toString());
      ip_address = data['query'];
    } catch (e) {
      MyDialogs.error(msg: e.toString());
      log('\ngetIPDetailsE: $e');
    }

    final year = DateTime.now().year;
    final month = DateTime.now().month;
    final now = "${year}-0${month}";
    var dataToHash =
        "listsrv-${ip_address}x${now}+u1MTrr1is70sf60KuTW0ioGXbuCEelJT2V7zBJaVMNUx07wSwd";
    var bytesToHash = utf8.encode(dataToHash);
    var md5Digest = md5.convert(bytesToHash);
    print('Data to hash: $dataToHash');
    print('MD5: $md5Digest');

    final response = await http.get(
      Uri.parse('https://freevpn.ws/api.php?action=listsrv&sign=${md5Digest}'),
    );
    // var response = await get(Uri.parse('https://freevpn.ws/api.php?action=listsrv&sign=${md5Digest}'));
    print("31: ${response}");
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      print("41: ${data.map((item) => Datum.fromJson(item)).toList()}");
      return data.map((item) => Datum.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<void> getAccess() async {
    String? ip_address;

    try {
      final res = await get(Uri.parse('http://ip-api.com/json/'));
      final data = jsonDecode(res.body);
      log(data.toString());
      ip_address = data['query'];
    } catch (e) {
      MyDialogs.error(msg: e.toString());
      log('\ngetIPDetailsE: $e');
    }

    print("IP: ${ip_address}");

    final year = DateTime.now().year;
    final month = DateTime.now().month;
    final now = "${year}-0${month}";
    var dataToHash =
        "getaccess-${ip_address}x${now}+u1MTrr1is70sf60KuTW0ioGXbuCEelJT2V7zBJaVMNUx07wSwd";
    var bytesToHash = utf8.encode(dataToHash);
    var md5Digest = md5.convert(bytesToHash);
    print('Data to hash: $dataToHash');
    print('MD5: $md5Digest');

    final response = await http.get(
      Uri.parse(
          'https://freevpn.ws/api.php?action=getaccess&type=free&sign=${md5Digest}'),
    );

    print("31: ${response.body}");

    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body)['message'];
      Message message = Message.fromJson(data);
      print("DTA: ${message}");
      Pref.setSessionId(message.sessionId);
      Pref.setUserName(message.user);
      Pref.setPass(message.password);
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<void> killSession(String sessionId) async {
    String? ip_address;

    try {
      final res = await get(Uri.parse('http://ip-api.com/json/'));
      final data = jsonDecode(res.body);
      log(data.toString());
      ip_address = data['query'];
    } catch (e) {
      MyDialogs.error(msg: e.toString());
      log('\ngetIPDetailsE: $e');
    }

    print("IP: ${ip_address}");

    final year = DateTime.now().year;
    final month = DateTime.now().month;
    final now = "${year}-0${month}";
    var dataToHash =
        "killsession-${ip_address}x${now}+u1MTrr1is70sf60KuTW0ioGXbuCEelJT2V7zBJaVMNUx07wSwd";
    var bytesToHash = utf8.encode(dataToHash);
    var md5Digest = md5.convert(bytesToHash);
    print('Data to hash: $dataToHash');
    print('MD5: $md5Digest');

    final response = await http.get(
      Uri.parse(
          'https://freevpn.ws/api.php?action=killsession&sid=${sessionId}&sign=${md5Digest}'),
    );

    print("31: ${response}");

    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body)['message'];
      print(data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<GetAds> getAds() async {
    String? ip_address;

    try {
      final res = await get(Uri.parse('http://ip-api.com/json/'));
      final data = jsonDecode(res.body);
      log(data.toString());
      ip_address = data['query'];
    } catch (e) {
      MyDialogs.error(msg: e.toString());
      log('\ngetIPDetailsE: $e');
    }

    final response = await http.get(
      Uri.parse(
          'https://loadads.online/getads.php?type=getads&user_ip=${ip_address}'),
    );

    print("31: ${response}");

    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      final GetAds adsData = GetAds.fromJson(data);
      return adsData;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<String> validateAds(String hashCode, String code) async {
    String? ip_address;

    try {
      final res = await get(Uri.parse('http://ip-api.com/json/'));
      final data = jsonDecode(res.body);
      log(data.toString());
      ip_address = data['query'];
    } catch (e) {
      MyDialogs.error(msg: e.toString());
      log('\ngetIPDetailsE: $e');
    }

    final response = await http.get(
      Uri.parse(
          'https://loadads.online/getads.php?type=validateads&hash=${hashCode}&captcha=${code}&ip=${ip_address}'),
    );

    print("31: ${response}");

    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body)['status'];
      Pref.setStatus(data);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
}

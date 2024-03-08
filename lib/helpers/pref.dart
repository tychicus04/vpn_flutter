import 'dart:convert';

import 'package:eye_vpn_lite/models/vpn_free.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/vpn.dart';

const url = 'url';
const hash = 'hash';
const sessionId = 'session id';
const isShowDialog = 'is show dialog';
const check = 'check';
const status = 'status';
const username = 'username';
const pass = 'pass';

class Pref {
  static Future<String> getUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(url) ?? "";
  }

  static Future setUrl(String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(url, value);
  }

  static Future<String> getStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(status) ?? "";
  }

  static Future setStatus(String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(status, value);
  }

  static Future<String> getSessionId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(sessionId) ?? "";
  }

  static Future setSessionId(String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(sessionId, value);
  }

  static Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(username) ?? "";
  }

  static Future setUserName(String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(username, value);
  }

  static Future<String> getPass() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(pass) ?? "";
  }

  static Future setPass(String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(pass, value);
  }

  static Future<String> getHash() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(hash) ?? "";
  }

  static Future setHash(String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(hash, value);
  }

  static Future setShowDialog(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(isShowDialog, value);
  }

  static Future<bool> getShowDialog() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isShowDialog) ?? false;
  }

  static Future setCheck(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(check, value);
  }

  static Future<bool> getCheck() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(check) ?? false;
  }

  static late Box _box;

  static Future<void> initializeHive() async {
    await Hive.initFlutter();
    _box = await Hive.openBox('data');
  }

  static void clearVpnData() async {
    _box = await Hive.openBox('vpn');
    await _box.clear();
  }

  static void clearVpnFreeData() async {
    _box = await Hive.openBox('vpnFree');
    await _box.clear();
  }

  //for storing theme data
  static bool get isDarkMode => _box.get('isDarkMode') ?? false;
  static set isDarkMode(bool v) => _box.put('isDarkMode', v);

  //for storing single selected vpn details
  static Vpn get vpn => Vpn.fromJson(jsonDecode(_box.get('vpn') ?? '{}'));
  static set vpn(Vpn v) => _box.put('vpn', jsonEncode(v));

  static Datum get datum =>
      Datum.fromJson(jsonDecode(_box.get('datum') ?? '{}'));

  static set datum(Datum v) => _box.put('datum', jsonEncode(v));

  //for storing vpn servers details
  static List<Vpn> get vpnList {
    List<Vpn> temp = [];
    final data = jsonDecode(_box.get('vpnList') ?? '[]');

    for (var i in data) temp.add(Vpn.fromJson(i));

    return temp;
  }

  static List<Datum> get vpnFreeList {
    List<Datum> temp = [];
    final data = jsonDecode(_box.get('vpnFreeList') ?? '[]');

    for (var i in data) temp.add(Datum.fromJson(i));

    return temp;
  }

  static set vpnList(List<Vpn> v) => _box.put('vpnList', jsonEncode(v));
  static set vpnFreeList(List<Datum> v) =>
      _box.put('vpnFreeList', jsonEncode(v));
}

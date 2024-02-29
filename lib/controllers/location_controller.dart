import 'package:eye_vpn_lite/apis/vpn_free_repository.dart';
import 'package:eye_vpn_lite/models/vpn_free.dart';
import 'package:get/get.dart';

import '../apis/apis.dart';
import '../helpers/pref.dart';
import '../models/vpn.dart';

class LocationController extends GetxController {
  // List<Datum> vpnFreeList = Pref.vpnFreeList;
  List<Datum> vpnFreeList = [];

  final RxBool isLoading = false.obs;

  Future<void> getVpnData() async {
    isLoading.value = true;
    vpnFreeList.clear();
    vpnFreeList = await FreeServerRepository.getVpnFree();
    isLoading.value = false;
  }
}

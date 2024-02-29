import 'package:eye_vpn_lite/apis/vpn_free_repository.dart';
import 'package:eye_vpn_lite/models/get_ads.dart';
import 'package:eye_vpn_lite/models/vpn_free.dart';
import 'package:get/get.dart';

import '../apis/apis.dart';
import '../helpers/pref.dart';
import '../models/vpn.dart';

class GetAdsController extends GetxController {
  // List<Datum> vpnFreeList = Pref.vpnFreeList;
  late GetAds ads;

  final RxBool isLoading = false.obs;

  Future<void> getAds() async {
    isLoading.value = true;
    ads = await FreeServerRepository.getAds();
    Pref.setUrl(ads.url);
    Pref.setHash(ads.hash);
    isLoading.value = false;
  }
}

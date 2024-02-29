import 'package:eye_vpn_lite/helpers/config.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../models/vip_server_model.dart'; // Import Dio if you haven't already

class VipServerController extends GetxController {
  var isLoading = true.obs;
  var vipServers = <Data>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      final response = await Dio().get(
        '${Config.vipServerBaseUrl}/user/server/list',
      );

      if (response.statusCode == 200) {
        final VipServerModel vipServerModel =
            VipServerModel.fromJson(response.data);

        vipServers.assignAll(vipServerModel.data!);
      }
    } catch (error) {
      print('Error: $error');
    } finally {
      isLoading.value = false;
    }
  }
}

import 'dart:ffi';

import 'package:eye_vpn_lite/apis/vpn_free_repository.dart';
import 'package:eye_vpn_lite/controllers/get_ads_controller.dart';
import 'package:eye_vpn_lite/helpers/pref.dart';
import 'package:eye_vpn_lite/utils/share.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GetAdsScreen extends StatefulWidget {
  GetAdsScreen({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  _GetAdsScreenState createState() => _GetAdsScreenState();
}

class _GetAdsScreenState extends State<GetAdsScreen> {
  late WebViewController controller;
  var loadingPercentage = 0;

  @override
  void initState() {
    // TODO: implement initState
    // #docregion webview_controller
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
      ))
      ..loadRequest(
        Uri.parse('${widget.url}'),
        //       headers: {
        //         'Authorization': "Bearer ${access_token.$}",
        //       }).whenComplete(() => null);
        // print(
        //   "token test + ${"Bearer ${access_token.$}"}",
      );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}

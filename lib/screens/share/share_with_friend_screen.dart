import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:share_extend/share_extend.dart';

class ShareWithFriendsScreen extends StatefulWidget {
  const ShareWithFriendsScreen({Key? key}) : super(key: key);

  @override
  State<ShareWithFriendsScreen> createState() => _ShareWithFriendsScreenState();
}

class _ShareWithFriendsScreenState extends State<ShareWithFriendsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Invite Friends'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Center(
          child: Column(
            children: [
              Lottie.asset("assets/lottie/share.json",
                  height: 300.h, width: 300.w),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Share VPN Using Experience",
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                "Help your friends getting secure connection over the world and unlock Restricted content and enjoy streaming service from any locations using Eye VPN Lite.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 12.sp,
                    letterSpacing: 0.3,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 50.h,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: MaterialButton(
                  color: Colors.amber,
                  minWidth: 200.w,
                  height: 40,
                  onPressed: () {
                    String textToShare =
                        'https://play.google.com/store/games'; // Replace with the text you want to share
                    ShareExtend.share(textToShare, 'text');
                    //shareUdhaarAppAlertDialogue(context);
                    //Get.toNamed(TransactionInformationPage.routeName);
                  },
                  child: Text(
                    "Share Now",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

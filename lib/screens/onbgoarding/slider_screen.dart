import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class SliderScreen extends StatelessWidget {
  final String description;
  final String image;

  const SliderScreen(
      {super.key,
        required this.description,
        required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 44.h, left: 20.w, right: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Padding(
            padding: EdgeInsets.only(top: 80.h),
            child: Center(
              child: Lottie.asset(
                image,
                height: 250.h,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 50.h),
            child: Center(
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins-Light',
                  color: Colors.black54,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
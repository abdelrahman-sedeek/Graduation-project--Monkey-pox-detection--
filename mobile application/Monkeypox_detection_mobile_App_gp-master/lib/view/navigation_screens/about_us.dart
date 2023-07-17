import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monkeybox_final/utilities/app_colors.dart';
import 'package:monkeybox_final/utilities/app_assets.dart';
import 'package:sizer/sizer.dart';

class aboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.0.w, vertical: 2.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Center(
            child: Text(
              'About us',
              style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: clr.primaryColor),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Image.asset(
            appImages.aboutusImage,
          ),
          SizedBox(
            height: 1.h,
          ),
          Text(
              'We are a bioinformatician team that aim to help'
              ' people who doubt of having a Monkeypox disease.'
              ' We can help them to check their illness from home '
              'by simply upload a picture of their pills.',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
              )),
          SizedBox(
            height: 1.h,
          )
        ]),
      ),
    );
  }
}

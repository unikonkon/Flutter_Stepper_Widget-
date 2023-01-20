import 'dart:io';

import 'package:application_test/formpage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  static Route route() {
    if (Platform.isAndroid) {
      // Android-specific code
      return PageTransition<void>(
        type: PageTransitionType.rightToLeft,
        child: Home(),
      );
    } else {
      // iOS-specific code
      return MaterialPageRoute<void>(
        builder: (_) => Home(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FormStep',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 90.h),
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Color.fromARGB(255, 103, 108, 109),
                  fixedSize: Size(0.55.sw, 80.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.w),
                  ),
                  padding: EdgeInsets.only(left: 30.w, right: 23.w),
                  alignment: Alignment.center,
                ),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true)
                      .push<void>(FormPage.route());
                },
                child: Text(
                  'FormStep',
                  style: TextStyle(fontSize: 20.sp),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

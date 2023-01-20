import 'dart:io';

import 'package:application_test/bloc/stepform_bloc.dart';
import 'package:application_test/formpage.dart';
import 'package:application_test/model_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocBuilder<StepFormBloc, StepFormState>(
      builder: (context, state) {
        final List<Data> dataList = state.all;
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'FormStep',
              style: TextStyle(
                color: Color.fromARGB(255, 242, 238, 238),
              ),
            ),
            backgroundColor: Color.fromARGB(255, 89, 97, 113),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 50.h),
            child: Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Color.fromARGB(255, 103, 108, 109),
                      fixedSize: Size(0.95.sw, 70.h),
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
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'รายการที่บันทึก',
                    style: TextStyle(
                        fontSize: 20.sp, color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  DataList(dataList: dataList),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class DataList extends StatelessWidget {
  const DataList({
    Key? key,
    required this.dataList,
  }) : super(key: key);

  final List<Data> dataList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          var data = dataList[index];
          return Card(
            color: Color.fromARGB(255, 207, 215, 221),
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Theme.of(context).colorScheme.outline),
                borderRadius: const BorderRadius.all(Radius.circular(7))),
            child: SizedBox(
              child: Padding(
                padding: EdgeInsets.only(left: 20.w, top: 7.h, bottom: 7.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      data.namedata,
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

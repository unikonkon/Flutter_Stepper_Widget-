import 'dart:io';
import 'dart:async';
import 'package:application_test/bloc/stepform_bloc.dart';
import 'package:application_test/model_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cupertino_stepper/cupertino_stepper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});
  static Route route() {
    if (Platform.isAndroid) {
      // Android-specific code
      return PageTransition<void>(
        type: PageTransitionType.rightToLeft,
        child: const FormPage(),
      );
    } else {
      // iOS-specific code
      return MaterialPageRoute<void>(
        builder: (_) => const FormPage(),
      );
    }
  }

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  int currentStep = 0;
  bool isComplete = false;

  TextEditingController name = TextEditingController();
  TextEditingController adderss = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StepFormBloc, StepFormState>(
      builder: (context, state) {
        CompleteStep() {
          Timer(const Duration(milliseconds: 500), () {
            Navigator.of(context).pop(context);
            isComplete = false;
            currentStep = 0;
            var data = Data(name: name.text, namedata: adderss.text);
            context.read<StepFormBloc>().add(
                  OnAddData(data: data),
                );
          });
          return Scaffold(
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 150.w,
                    color: Color.fromARGB(255, 109, 225, 109),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    'success',
                    style: TextStyle(fontSize: 40.sp),
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
            appBar: AppBar(
                title: const Text('FormPage'),
                backgroundColor: Color.fromARGB(255, 89, 97, 113)),
            body: isComplete
                ? CompleteStep()
                : Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(
                          primary: Color.fromARGB(255, 67, 71, 99)),
                    ),
                    child: Stepper(
                      type: StepperType.horizontal,
                      currentStep: currentStep,
                      steps: getSteps(),
                      onStepContinue: () {
                        final last = currentStep == getSteps().length - 1;
                        if (last) {
                          setState(() {
                            isComplete = true;
                          });
                        } else if (name.text.isNotEmpty &&
                            adderss.text.isNotEmpty) {
                          setState(() => currentStep += 1);
                        }
                      },
                      onStepCancel: () {
                        currentStep == 0
                            ? null
                            : setState(() => currentStep -= 1);
                      },
                      onStepTapped: (step) =>
                          setState(() => currentStep = step),
                      controlsBuilder:
                          (BuildContext context, ControlsDetails controls) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Row(
                            children: <Widget>[
                              if (currentStep != 1)
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    fixedSize: Size(0.30.sw, 40.h),
                                    alignment: Alignment.center,
                                  ),
                                  onPressed: controls.onStepContinue,
                                  child: const Text('NEXT'),
                                ),
                              if (currentStep == 1)
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    fixedSize: Size(0.30.sw, 40.h),
                                    alignment: Alignment.center,
                                  ),
                                  onPressed: controls.onStepContinue,
                                  child: const Text('CONFIRM'),
                                ),
                              if (currentStep != 0)
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      fixedSize: Size(0.30.sw, 40.h),
                                      alignment: Alignment.center,
                                    ),
                                    onPressed: controls.onStepCancel,
                                    child: const Text(
                                      'BACK',
                                      // style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              // if (name.text.isEmpty && adderss.text.isEmpty)
                              //   Container(
                              //     child: Text('ใส่ข้อมูลให้ครบ'),
                              //   )
                            ],
                          ),
                        );
                      },
                    ),
                  ));
      },
    );
  }

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text('Account'),
          content: Container(
            child: Column(
              children: [
                TextField(
                  controller: name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Full Name',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: adderss,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Adderss',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 1,
            title: Text('data Account'),
            content: Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Name: ${name.text}',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Adderss: ${adderss.text}',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Text(
                  'ยืนยันข้อมูล',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ))),
        // Step(
        //   state: currentStep > 2 ? StepState.complete : StepState.disabled,
        //   isActive: currentStep >= 2,
        //   title: Text('Complete'),
        //   content: Column(
        //     children: [
        //       Container(
        //         child: Text("Complete"),
        //       ),
        //     ],
        //   ),
        // )
      ];
}

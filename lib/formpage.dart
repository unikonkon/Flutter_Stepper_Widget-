import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cupertino_stepper/cupertino_stepper.dart';
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
    CompleteStep() {
      Timer(const Duration(milliseconds: 500), () {
        Navigator.of(context).pop(context);
        isComplete = false;
        currentStep = 0;
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
          // child: Image.asset(
          //   'assets/images/check.png',
          //   width: 128.w,
          // ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('FormPage'),
      ),
      body: isComplete
          ? CompleteStep()
          : Stepper(
              type: StepperType.horizontal,
              currentStep: currentStep,
              steps: getSteps(),
              onStepContinue: () {
                final last = currentStep == getSteps().length - 1;
                if (last) {
                  setState(() {
                    isComplete = true;
                  });
                } else {
                  setState(() => currentStep += 1);
                }
              },
              onStepCancel: () {
                currentStep == 0 ? null : setState(() => currentStep -= 1);
              },
              onStepTapped: (step) => setState(() => currentStep = step),
              // controlsBuilder: (context, {onStepContinue, onStepCancel}) {
              //   return Container();
              // },
            ),
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
                Text('Name: ${name.text}'),
                Text('Adderss: ${adderss.text}'),
              ],
            ))),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.disabled,
          isActive: currentStep >= 2,
          title: Text('Complete'),
          content: Column(
            children: [
              Container(
                child: Text("Complete"),
              ),
            ],
          ),
        )
      ];

  // CompleteStep() {
  //   return Container(
  //       child: ElevatedButton(
  //     onPressed: () {
  //       isComplete = false;
  //       currentStep = 0;
  //     },
  //     child: Text("Complete"),
  //   ));
  // }
  // Widget CompleteStep() {
  //   return Container(
  //       child: ElevatedButton(
  //     onPressed: () {
  //       isComplete = false;
  //       currentStep = 0;
  //       Navigator.pop(context);
  //     },
  //     child: Text("Complete"),
  //   ));
  // }

}

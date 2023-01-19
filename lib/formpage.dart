import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cupertino_stepper/cupertino_stepper.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  int currentStep = 0;
  bool isComplete = false;
  @override
  Widget build(BuildContext context) {
    CompleteStep() {
      return Container(
          child: ElevatedButton(
        onPressed: () {
          isComplete = false;
          currentStep = 0;
        },
        child: Text("Complete"),
      ));
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
            child: Text("Account"),
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: Text('Address'),
          content: Container(
            child: Text("Address"),
          ),
        ),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.disabled,
          isActive: currentStep >= 2,
          title: Text('Complete'),
          content: Container(
            child: Text("Complete"),
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

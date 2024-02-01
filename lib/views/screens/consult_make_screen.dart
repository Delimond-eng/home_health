import 'package:animate_do/animate_do.dart';
import 'package:enhance_stepper/enhance_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/style.dart';
import '../widgets/custom_app_header.dart';

class ConsultMakeScreen extends StatefulWidget {
  const ConsultMakeScreen({super.key});

  @override
  State<ConsultMakeScreen> createState() => _ConsultMakeScreenState();
}

class _ConsultMakeScreenState extends State<ConsultMakeScreen> {
  int _currentStep = 0;

  final List<StepItem> steps = [
    StepItem(
      title: "Prise de contact",
      icon: "padd.svg",
      subtitle: "La prise de contact du patient",
    ),
    StepItem(
      title: "Signes vitaux",
      icon: "signvit.svg",
      subtitle: "La prise de contact du patient",
    ),
    StepItem(
      title: "Histoire maladie",
      icon: "story.svg",
      subtitle: "Description des différentes manifestations de la maladie",
    ),
    StepItem(
      title: "Antécédents",
      icon: "antd.svg",
      subtitle: "Prélevement les antécedents du patient",
    ),
    StepItem(
      title: "Examens physiques",
      icon: "examenph.svg",
      subtitle: "Prélevement des examens physiques",
    ),
    StepItem(
      title: "Examens labo",
      icon: "laboexam.svg",
      subtitle: "Prélevement des examens laboratoires",
    ),
    StepItem(
      title: "Prescriptions",
      icon: "prescriptions.svg",
      subtitle: "Etablissement du diagnostic médical",
    ),
    StepItem(
      title: "Modes de traitement",
      icon: "medication.svg",
      subtitle: "Description des modes de traitement",
    ),
  ];
  final List<Widget> stepperContents = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppHeader(title: "Consultation médicale"),
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  EnhanceStepper(
                      type: StepperType.vertical,
                      currentStep: _currentStep,
                      stepIconSize: 40.0,
                      physics: const ClampingScrollPhysics(),
                      onStepTapped: (step) => tappedStep(step),
                      onStepContinue: () => continuedStep(),
                      onStepCancel: () => cancelStep(),
                      controlsBuilder: (context, details) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (_currentStep != 0) ...[
                                Flexible(
                                  child: FadeInLeft(
                                    child: Container(
                                      height: 45.0,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 8,
                                            color: Colors.grey.withOpacity(.3),
                                            offset: const Offset(0, 3),
                                          )
                                        ],
                                      ),
                                      child: Material(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          onTap: () => cancelStep(),
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SvgPicture.asset(
                                                "assets/svg/prev.svg",
                                                // ignore: deprecated_member_use
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                              ] else ...[
                                const SizedBox()
                              ],
                              Flexible(
                                child: FadeInRight(
                                  child: Container(
                                    height: 45.0,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(4.0),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 8,
                                          color: Colors.grey.withOpacity(.3),
                                          offset: const Offset(0, 3),
                                        )
                                      ],
                                    ),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(4.0),
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        onTap: () => continuedStep(),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgPicture.asset(
                                              "assets/svg/next.svg",
                                              // ignore: deprecated_member_use
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      steps: steps
                          .map(
                            (e) => EnhanceStep(
                              icon: stepperSvg(e.icon!),
                              title: stepperTitle(e.title!),
                              subtitle: stepperSubtile(e.subtitle!),
                              content: Container(),
                              isActive: _currentStep == steps.indexOf(e),
                              state: _currentStep >= steps.indexOf(e)
                                  ? StepState.complete
                                  : StepState.disabled,
                            ),
                          )
                          .toList())
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void tappedStep(int step) {
    setState(() => _currentStep = step);
  }

  void continuedStep() {
    /* _currentStep < 2 ? setState(() => _currentStep += 1) : null; */
    if (_currentStep > 7) {
      setState(() {
        _currentStep = 0;
      });
    } else {
      setState(() {
        _currentStep += 1;
      });
    }
  }

  void cancelStep() {
    /* _currentStep > 0 ? setState(() => _currentStep -= 1) : null; */
    if (_currentStep <= 0) {
      return;
    }
    setState(() {
      _currentStep--;
    });
  }

  Widget stepperTitle(String? title) {
    return Text(
      title!,
      style: const TextStyle(
        fontFamily: kFontFamily,
        fontSize: 12.0,
        fontWeight: FontWeight.w800,
        color: Colors.indigo,
      ),
    );
  }

  Widget stepperSubtile(String? title) {
    return Text(
      title!,
      style: const TextStyle(
        fontFamily: kFontFamily,
        fontSize: 10.0,
      ),
    );
  }

  Widget stepperSvg(String? icon) {
    return SvgPicture.asset(
      "assets/svg/$icon",
      // ignore: deprecated_member_use
      color: primaryColor,
      height: 50.0,
      width: 50.0,
    );
  }
}

class StepItem {
  String? title, icon, subtitle;
  StepItem({this.icon, this.title, this.subtitle});
}

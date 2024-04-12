import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:home_health/global/controllers.dart';
import '../../../models/nurse.dart';
import '../../widgets/user_avatar.dart';

class VisitDetailPage extends StatefulWidget {
  const VisitDetailPage({super.key, this.nurse});
  final Nurse? nurse;

  @override
  State<VisitDetailPage> createState() => _VisitDetailPageState();
}

class _VisitDetailPageState extends State<VisitDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Column(
            children: [
              _header(context),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/imgs/nurse-male.png',
                            height: 40.0,
                          ),
                          Text(
                            dataController
                                .selectedVisit.value.nurse!.nurseFullname!,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/imgs/examination.png',
                            height: 40.0,
                          ),
                          Text(
                            dataController
                                .selectedVisit.value.patient!.patientFullname!,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/imgs/home.png",
                              height: 20.0,
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Flexible(
                              child: Text(
                                dataController.selectedVisit.value.patient!
                                    .patientAddress!,
                                textScaleFactor: .9,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      for (var e in dataController
                          .selectedVisit.value.treatments!) ...[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/imgs/medical-check.png',
                                      height: 30.0,
                                    ),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    Flexible(
                                      child: Text(
                                        e.patientTreatmentLibelle!,
                                        textScaleFactor: .9,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 6.0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: e.patientTreatmentStatus == "done"
                                      ? Colors.green
                                      : Colors.orange.shade300,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    e.patientTreatmentStatus == "done"
                                        ? "Fait"
                                        : "Non fait",
                                    textScaleFactor: .9,
                                    style: const TextStyle(
                                        fontSize: 10.0, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider()
                      ]
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }

  /*  Header widget */
  Widget _header(context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/imgs/shape-bg-1.jpg"),
          alignment: Alignment.center,
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.indigo,
              Colors.indigo.shade300.withOpacity(.8),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 40.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(5),
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              "assets/svg/arrow-back.svg",
                              // ignore: deprecated_member_use
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Text(
                      "Visite détails",
                      textScaleFactor: .9,
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                const UserAvatar(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String translate(String key) {
    switch (key.toLowerCase()) {
      case "tout":
        return "all";
      case "jour":
        return "day";
      case "sem":
        return "week";
      case "mois":
        return "month";
      default:
        return "all";
    }
  }
}

class IntlFilterCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final bool isActive;
  final Function(String value)? onSelected;
  const IntlFilterCard({
    super.key,
    required this.data,
    this.isActive = false,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
        color: isActive ? Colors.indigo.shade400 : Colors.transparent,
        border: isActive
            ? null
            : Border.all(
                color: Colors.indigo.shade200,
              ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(5.0),
          onTap: () {
            onSelected!.call(data['code'].toString());
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              data["label"],
              textScaleFactor: .8,
              style: TextStyle(color: isActive ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}

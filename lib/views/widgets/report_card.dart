import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_health/utils/costum_modal.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../models/report.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({
    super.key,
    required this.item,
  });

  final Report item;

  Color getColor(double percentage) {
    if (percentage >= 0.75) {
      return Colors.green;
    } else if (percentage >= 0.5) {
      return Colors.orange;
    } else if (percentage >= 0.25) {
      return Colors.orange.shade800;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    int total = item.visit!.treatments!.length;
    int done = item.visit!.treatments!
        .where((el) => el.patientTreatmentStatus == "done")
        .length;
    double percent = (done / total) * 100;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/imgs/destination.png",
                          height: 20.0,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Flexible(
                          child: Text(
                            item.nurse!.nurseFullname!,
                            textScaleFactor: .9,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.indigo,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          "assets/imgs/calendar.png",
                          height: 20.0,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Flexible(
                          child: Text(
                            item.reportCreatedAt!,
                            textScaleFactor: .8,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  Image.asset(
                    "assets/imgs/examination.png",
                    height: 20.0,
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Flexible(
                    child: Text(
                      item.visit!.patient!.patientFullname!,
                      textScaleFactor: .9,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
                        item.visit!.patient!.patientAddress!,
                        textScaleFactor: .8,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Progression",
                        style: TextStyle(
                          fontSize: 8.0,
                        ),
                      ),
                    ),
                    LinearPercentIndicator(
                      animation: true,
                      lineHeight: 3.0,
                      animationDuration: 1000,
                      percent: percent / 100,
                      animateFromLastPercent: true,
                      barRadius: const Radius.circular(2),
                      progressColor: getColor(percent / 100),
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      elevation: 1.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      showCustomModal(
                        context,
                        modalTitle: "Soins & services",
                        child: Column(
                          children: [
                            for (var e in item.visit!.treatments!) ...[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "- ${e.patientTreatmentLibelle!}",
                                        textScaleFactor: .9,
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 6.0,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color:
                                            e.patientTreatmentStatus == "done"
                                                ? Colors.green
                                                : Colors.orange.shade300,
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          e.patientTreatmentStatus == "done"
                                              ? "Fait"
                                              : "Non fait",
                                          textScaleFactor: .8,
                                          style: const TextStyle(
                                              fontSize: 10.0,
                                              color: Colors.white),
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
                      );
                    },
                    child: const Text(
                      'Voir tâches',
                      style: TextStyle(
                        fontSize: 10.0,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Card expansionCard(double percent, BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: ExpansionTile(
        collapsedTextColor: Colors.black,
        iconColor: Colors.grey,
        subtitle: Row(
          children: [
            SvgPicture.asset(
              "assets/svg/location-place.svg",
              colorFilter: const ColorFilter.mode(
                Colors.blue,
                BlendMode.srcIn,
              ),
              height: 18,
            ),
            const SizedBox(
              width: 5.0,
            ),
            Flexible(
              child: Text(
                item.visit!.patient!.patientAddress!,
                textScaleFactor: .8,
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        title: Row(
          children: [
            CircularPercentIndicator(
              radius: 20.0,
              lineWidth: 4.0,
              percent: percent / 100,
              animateFromLastPercent: true,
              backgroundColor: Colors.grey.shade300,
              circularStrokeCap: CircularStrokeCap.round,
              animation: true,
              center: Text(
                "${percent.toInt()} %",
                textScaleFactor: .8,
                style: const TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              progressColor: getColor(percent / 100),
            ),
            const SizedBox(
              width: 5.0,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Visite chez le patient",
                        textScaleFactor: .8,
                        style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.calendar_month_sharp,
                                size: 10.0,
                              ),
                              Text(
                                item.reportCreatedAt!,
                                textScaleFactor: .8,
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    item.visit!.patient!.patientFullname!,
                    textScaleFactor: .8,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Divider(
                    color: Colors.grey.shade200,
                    height: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.indigo.shade200,
                ),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Text(
                "Soins et services",
                textScaleFactor: .8,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          for (var e in item.visit!.treatments!) ...[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      "- ${e.patientTreatmentLibelle!}",
                      textScaleFactor: .8,
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
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
                        textScaleFactor: .8,
                        style: const TextStyle(
                            fontSize: 10.0, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_health/global/controllers.dart';
import 'package:home_health/models/schedule.dart';
import 'package:home_health/views/pages/patient_traitment_page.dart';

class MedicDocItemList extends StatelessWidget {
  final Visit item;
  const MedicDocItemList({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.0,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
            margin: const EdgeInsets.fromLTRB(8, 4, 8, 0),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(5.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(5.0),
                onTap: () {
                  nurseDataController.selectScheduleTreatments.value =
                      item.treatments!;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PatientTraitmentPage(
                        item: item,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 30.0,
                                width: 30.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    30,
                                  ),
                                  color: buildColor(
                                      item.visitStatus!.toLowerCase()),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: SvgPicture.asset(
                                    "assets/svg/patient-2.svg",
                                    colorFilter: const ColorFilter.mode(
                                        Colors.white, BlendMode.srcIn),
                                    height: 24,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                item.patient!.patientFullname!,
                                textScaleFactor: .8,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/svg/location-place.svg",
                                colorFilter: const ColorFilter.mode(
                                  Colors.black,
                                  BlendMode.srcIn,
                                ),
                                height: 20,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Flexible(
                                child: Text(
                                  item.patient!.patientAddress!,
                                  textScaleFactor: .8,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey.shade800,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white, width: 1.5),
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.black87,
                            ),
                            child: Material(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(5),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4.0,
                                    horizontal: 8.0,
                                  ),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/svg/map-location.svg",
                                        colorFilter: ColorFilter.mode(
                                          Colors.brown.shade100,
                                          BlendMode.srcIn,
                                        ),
                                        height: 15.0,
                                      ),
                                      Text(
                                        'Itinéraire',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.brown.shade100,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_month_outlined,
                                        size: 15.0,
                                        color: Colors.indigo,
                                      ),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        item.visitDate!,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Poppins',
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            child: Container(
              height: 116.0,
              margin: const EdgeInsets.fromLTRB(8.0, 4.0, 0, 0),
              width: 4.0,
              decoration: BoxDecoration(
                color: buildColor(item.visitStatus!.toLowerCase()),
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(4.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color buildColor(String status) {
    if (status == 'pending') {
      return Colors.grey;
    } else if (status == "delegated") {
      return Colors.blue;
    } else if (status == "completed") {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }
}

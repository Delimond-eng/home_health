import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/nurse_home.dart';

class ScheduleTileDelegate extends StatelessWidget {
  final Delegate item;
  const ScheduleTileDelegate(
      {super.key, required this.isLast, required this.item});
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 125.0,
          width: MediaQuery.of(context).size.width * .85,
          child: Card(
            margin: const EdgeInsets.only(right: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          item.visit!.patient!.patientFullname!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/svg/location-place.svg",
                            colorFilter: const ColorFilter.mode(
                              Colors.blue,
                              BlendMode.srcIn,
                            ),
                            height: 20,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Flexible(
                            child: Text(
                              item.visit!.patient!.patientAddress!,
                              textScaleFactor: .8,
                              style: const TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.black87,
                              border:
                                  Border.all(color: Colors.white, width: 1.5),
                            ),
                            child: Material(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(4),
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
                                      const SizedBox(
                                        width: 8.0,
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
                              color: Colors.white.withOpacity(.8),
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
                                      ),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        item.visit!.visitDate!,
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
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          child: Container(
            height: 125.0,
            width: 4.0,
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(4.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color getColor(String status) {
    if (status == 'pending') {
      return Colors.grey;
    } else if (status == 'completed') {
      return Colors.green;
    } else if (status == 'delegate') {
      return Colors.blue;
    } else {
      return Colors.red;
    }
  }
}

class Schedule {
  String? title;
  String? adresse;
  String? dateHour;
  String? infirmier;
  MaterialColor? color;
  Schedule(
      {this.title, this.adresse, this.dateHour, this.color, this.infirmier});
}

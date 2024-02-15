import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_health/views/pages/patient_traitment_page.dart';

class MedicDocItemList extends StatelessWidget {
  final Patient item;
  const MedicDocItemList({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.0,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.fromLTRB(8, 4, 8, 0),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(5.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(5.0),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PatientTraitmentPage(
                    soins: item.soins!,
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
                              color: item.color!,
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
                            item.nom!,
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
                              item.adresse!,
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
                          border: Border.all(color: Colors.white, width: 1.5),
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
                                    item.dateHour!,
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
    );
  }
}

class Patient {
  String? nom;
  String? adresse, dateHour;
  MaterialColor? color;
  List<Soin>? soins;
  Patient({this.nom, this.adresse, this.color, this.dateHour, this.soins});
}

class Soin {
  String? libelle;
  bool selected = false;
  Soin({this.libelle});
}

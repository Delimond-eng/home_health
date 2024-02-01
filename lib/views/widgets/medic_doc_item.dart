import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MedicDocItem extends StatelessWidget {
  final Color statusColor;
  const MedicDocItem({
    super.key,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            image: const DecorationImage(
              image: AssetImage("assets/imgs/shape-bg-1.jpg"),
              alignment: Alignment.center,
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: LinearGradient(
                colors: [Colors.white, Colors.indigo.shade100.withOpacity(.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Material(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(5.0),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: SvgPicture.asset(
                            "assets/svg/svg-3.svg",
                            // ignore: deprecated_member_use
                            color: Colors.indigo,
                            height: 60.0,
                            width: 60.0,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Plainte",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                              fontSize: 10.0,
                            ),
                          ),
                          Text(
                            "Lorem Ipsum dolorem...",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[700],
                              fontSize: 13.0,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Icon(
                                  CupertinoIcons.clock,
                                  size: 15.0,
                                  color: Colors.indigo,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  "09 Fev. 2023, 11:20",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w900,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 10.0,
          child: Column(
            children: [
              Container(
                height: 5.0,
                width: 3.0,
                color: Colors.indigo.shade100,
              ),
              Container(
                  height: 10.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 15.0,
                        width: 33.0,
                        margin: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        )
      ],
    );
  }
}

class MedicDocItemList extends StatelessWidget {
  final Patient item;
  const MedicDocItemList({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 120.0,
          margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage("assets/imgs/shape-bg-1.jpg"),
              alignment: Alignment.center,
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.1),
                blurRadius: 5.0,
                offset: const Offset(0, 3),
              )
            ],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              gradient: LinearGradient(
                colors: [
                  Colors.indigo.shade100,
                  Colors.indigo.shade100.withOpacity(.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(8.0),
                onTap: () {},
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
                                    width: 4.0,
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
                                    Colors.black, BlendMode.srcIn),
                                height: 20,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Flexible(
                                child: Text(
                                  item.adresse!,
                                  style: TextStyle(
                                    fontSize: 10.0,
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
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.indigo,
                            ),
                            child: Material(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(20),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4.0,
                                    horizontal: 8.0,
                                  ),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/svg/map-location.svg",
                                        colorFilter: const ColorFilter.mode(
                                          Colors.white,
                                          BlendMode.srcIn,
                                        ),
                                        height: 15.0,
                                      ),
                                      const Text(
                                        'Itinéraire',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
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
        ),
        Positioned(
          top: 8.0,
          right: 12.0,
          child: Column(
            children: [
              Container(
                height: 5.0,
                width: 3.0,
                color: Colors.white,
              ),
              Container(
                  height: 10.0,
                  width: 80.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Container(
                          height: 10.0,
                          width: 80.0,
                          margin: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                            color: item.color!,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        )
      ],
    );
  }
}

class Patient {
  String? nom;
  String? adresse, dateHour;
  Color? color;
  Patient({this.nom, this.adresse, this.color, this.dateHour});
}

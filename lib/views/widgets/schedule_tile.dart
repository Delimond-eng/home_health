import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScheduleTile extends StatelessWidget {
  const ScheduleTile({super.key, required this.isLast});
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    var color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    return Container(
      margin: EdgeInsets.only(right: isLast ? 0 : 10.0),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage("assets/imgs/shape-bg-1.jpg"),
          alignment: Alignment.center,
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Container(
        height: 150.0,
        width: MediaQuery.of(context).size.width * .85,
        decoration: BoxDecoration(
          color: color.shade800.withOpacity(.8),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 35.0,
                    width: 35.0,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/svg/calendar-time.svg",
                          height: 22.0,
                          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  const Flexible(
                    child: Text(
                      "Lorem ipsum dolorem ",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 15,
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
                  Text(
                    "sit amet consectetur adipisicing elit. Asperiores...",
                    style: TextStyle(
                      color: Colors.grey.shade200,
                      fontSize: 12.0,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.grey.shade50.withOpacity(.6),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Icon(
                            CupertinoIcons.clock,
                            size: 15.0,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "Lundi, 09 Fev. 2023 de 11:20 - 13:30",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          )
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
    );
  }
}

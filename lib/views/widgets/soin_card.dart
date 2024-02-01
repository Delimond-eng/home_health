import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/soin.dart';

class SoinCard extends StatelessWidget {
  final Soin data;
  final Function onCleared;
  const SoinCard({super.key, required this.data, required this.onCleared});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 8.0),
          height: 70.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
          ),
          padding: const EdgeInsets.all(8.0),
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 226, 113, 113),
                      Color.fromARGB(255, 233, 30, 30),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/svg/svg-2.svg",
                      height: 40.0,
                      width: 40.0,
                      // ignore: deprecated_member_use
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 5.0,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data.title!,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 12.0,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                        ),
                        children: [
                          const TextSpan(
                            text: "Dosage : ",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Color.fromARGB(255, 233, 30, 30),
                            ),
                          ),
                          TextSpan(
                            text: data.dosage!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 5,
          right: 5.0,
          child: Container(
            height: 35.0,
            width: 35.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: Colors.indigo.shade200,
            ),
            child: Material(
              borderRadius: BorderRadius.circular(4.0),
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(4.0),
                onTap: () => onCleared(),
                child: const Center(
                  child: Icon(
                    CupertinoIcons.clear,
                    color: Colors.white,
                    size: 12.0,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

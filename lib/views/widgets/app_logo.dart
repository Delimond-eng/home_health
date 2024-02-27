import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          "assets/svg/house-medical.svg",
          height: 22.0,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              fontSize: 25.0,
              fontFamily: 'Staatliches',
              color: Colors.white,
              fontWeight: FontWeight.w700,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(.5),
                  blurRadius: .1,
                  offset: const Offset(0, 1),
                )
              ],
            ),
            children: [
              TextSpan(
                text: "HOME".toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
              TextSpan(
                text: "HEALTH".toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Color.fromARGB(255, 234, 59, 74),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

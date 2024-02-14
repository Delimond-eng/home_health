import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class HeadingTitle extends StatelessWidget {
  final String title;
  final MaterialColor? color;
  final Widget? actionChild;
  const HeadingTitle({
    super.key,
    required this.title,
    this.color,
    this.actionChild,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (int i = 0; i < 2; i++) ...[
                  Container(
                    height: 4.0,
                    width: i == 0 ? 10.0 : 50.0,
                    decoration: BoxDecoration(
                      color: color ?? Colors.indigo,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                ],
              ],
            ),
          ],
        ),
        if (actionChild != null) ...[actionChild!]
      ],
    );
  }
}

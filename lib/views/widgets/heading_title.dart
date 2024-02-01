import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class HeadingTitle extends StatelessWidget {
  final String title;
  final MaterialColor? color;
  final bool? withActionBtn;
  final IconData? actionBtnIcon;
  final Function? onActionBtnPressed;
  const HeadingTitle(
      {super.key,
      required this.title,
      this.color,
      this.withActionBtn = false,
      this.actionBtnIcon = Icons.circle,
      this.onActionBtnPressed});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Row(
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
          if (withActionBtn == true) ...[
            Container(
              height: 35.0,
              width: 35.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.1),
                    blurRadius: 8.0,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Material(
                borderRadius: BorderRadius.circular(35.0),
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(35.0),
                  onTap: () => onActionBtnPressed!,
                  child: Center(
                    child: Icon(
                      actionBtnIcon!,
                      color: Colors.grey.shade600,
                      size: 18.0,
                    ),
                  ),
                ),
              ),
            )
          ]
        ],
      ),
    );
  }
}

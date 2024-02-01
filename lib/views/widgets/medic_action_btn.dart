import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MedicActionBtn extends StatelessWidget {
  final String title;
  final String? icon;
  final MaterialColor color;
  final Function onPressed;
  const MedicActionBtn({
    super.key,
    required this.title,
    this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        image: const DecorationImage(
          image: AssetImage("assets/imgs/shape-bg-1.jpg"),
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          gradient: LinearGradient(
            colors: [color.shade900, color.shade300.withOpacity(.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.transparent,
          child: InkWell(
            onTap: () => onPressed(),
            borderRadius: BorderRadius.circular(5.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 5.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (icon != null) ...[
                    Container(
                      height: 30.0,
                      width: 30.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.5,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Center(
                            child: SvgPicture.asset(
                              "assets/svg/$icon",
                              // ignore: deprecated_member_use
                              color: color,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ] else ...[
                    const Icon(
                      CupertinoIcons.play_circle_fill,
                      color: Colors.white,
                    ),
                  ],
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
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

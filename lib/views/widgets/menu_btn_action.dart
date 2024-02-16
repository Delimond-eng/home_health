import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuBtnAction extends StatelessWidget {
  final String title;
  final String? icon;
  final MaterialColor color;
  final VoidCallback? onPressed;
  final Border? border;
  const MenuBtnAction({
    super.key,
    required this.title,
    this.icon,
    required this.color,
    required this.onPressed,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.9),
        border: border ?? const Border(),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(2.0),
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(2.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 5.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  "assets/svg/$icon",
                  height: 26.0,
                  colorFilter: 
                  ColorFilter.mode(color, BlendMode.srcIn),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Flexible(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontSize: 12.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

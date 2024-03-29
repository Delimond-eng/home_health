import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SubmitBtnLoader extends StatelessWidget {
  final bool isLoading;
  final String label;
  final Widget? icon;
  final MaterialColor color;
  final VoidCallback onPressed;
  const SubmitBtnLoader({
    super.key,
    this.isLoading = false,
    required this.label,
    required this.color,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        disabledBackgroundColor: color.shade300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SpinKitThreeInOut(
              color: Colors.white,
              size: 30.0,
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) icon!,
                const SizedBox(
                  width: 5,
                ),
                Text(
                  label.toUpperCase(),
                  textScaleFactor: .8,
                  style: TextStyle(
                    color: color.shade50,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
    );
  }
}

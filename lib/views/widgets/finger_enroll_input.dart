import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../modals/scanner_modal.dart';

class FingerEnrollInput extends StatelessWidget {
  const FingerEnrollInput({super.key});

  @override
  Widget build(BuildContext context) {
    var animated = true;
    return StatefulBuilder(
      builder: (context, setter) => Container(
        height: 80.0,
        width: 80.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(80.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.2),
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Material(
          borderRadius: BorderRadius.circular(80.0),
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(80.0),
            onTap: () {
              showPatientScanDialog(context, (value) {
                if (kDebugMode) {
                  print(value);
                }
                setter(() => animated = false);
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Lottie.asset(
                "assets/animateds/fp-2.json",
                repeat: animated,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

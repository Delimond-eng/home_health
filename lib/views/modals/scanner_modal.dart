import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Future<void> showPatientScanDialog(context, callback) async {
  // ignore: unused_local_variable
  Timer timer;
  showGeneralDialog(
    barrierDismissible: false,
    barrierLabel: "Finger scan",
    barrierColor: const Color.fromARGB(162, 0, 0, 0),
    context: context,
    transitionDuration: const Duration(milliseconds: 400),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      Tween<Offset> tween;
      tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
      return SlideTransition(
        position: tween.animate(
          CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        ),
        child: child,
      );
    },
    pageBuilder: (context, _, __) {
      return Center(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: StatefulBuilder(
              builder: (context, setter) => Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 30.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ZoomIn(
                              child: Lottie.asset(
                                "assets/animateds/fingerprint-scanner-1.json",
                                alignment: Alignment.center,
                                repeat: true,
                                height: 150.0,
                                width: 150.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50.0,
                    child: Container(
                      height: 50,
                      width: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: const Color.fromARGB(107, 233, 30, 98),
                      ),
                      child: Material(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(5.0),
                          onTap: () async {
                            Navigator.pop(context);
                          },
                          child: const Center(
                            child: Icon(
                              CupertinoIcons.clear,
                              color: Colors.white,
                              size: 15.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
  timer = Timer.periodic(const Duration(seconds: 3), (timer) {
    Navigator.pop(context);
    callback(true);
    timer.cancel();
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:home_health/global/controllers.dart';

class EmptyLoader extends StatelessWidget {
  final String? message;
  const EmptyLoader({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (dataController.dataLoading.value) ...[
                  const SpinKitFadingCircle(
                    color: Colors.indigo,
                  ),
                ] else ...[
                  Image.asset(
                    "assets/imgs/empty.png",
                    height: 80.0,
                    fit: BoxFit.scaleDown,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    message ?? "Aucune donnée répertoriée !",
                    textScaleFactor: .8,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ]
              ],
            ),
          ),
        ));
  }
}

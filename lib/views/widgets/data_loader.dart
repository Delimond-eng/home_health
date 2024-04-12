import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'empty_loader.dart';

class DataLoader extends StatefulWidget {
  final Widget child;
  final bool hasNoData;
  const DataLoader({super.key, required this.child, required this.hasNoData});

  @override
  State<DataLoader> createState() => _DataLoaderState();
}

class _DataLoaderState extends State<DataLoader> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
        stream: _connectivity.onConnectivityChanged,
        builder:
            (BuildContext context, AsyncSnapshot<ConnectivityResult> snapshot) {
          if (snapshot.hasData) {
            var result = snapshot.data!;
            if (result == ConnectivityResult.none) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/imgs/wi-fi.png",
                      height: 60.0,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 50.0,
                      ),
                      child: Text(
                        "Assurez-vous d'avoir une connexion internet active avant de continuer !",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return widget.hasNoData
                  ? const EmptyLoader(
                      message: "Aucun infirmier répertorié !",
                    )
                  : widget.child;
            }
          } else {
            return widget.child;
          }
        });
  }
}

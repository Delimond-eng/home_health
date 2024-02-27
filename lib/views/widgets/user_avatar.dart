import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_health/global/controllers.dart';
import 'package:home_health/views/screens/starting_screen.dart';

import '../../global/storage.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PopupMenuButton<String>(
        onSelected: (action) {
          handleMenuAction(context, action);
        },
        icon: avatar(),
        elevation: 15.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem<String>(
              value: 'header',
              enabled: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    authController.user.value.name!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    authController.user.value.email!,
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  const Divider(height: 10),
                ],
              ),
            ),
            const PopupMenuItem<String>(
              value: 'profile',
              child: Row(
                children: [
                  Icon(
                    Icons.person_outlined,
                    size: 15.0,
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                  Text(
                    'Voir le profil',
                    textScaleFactor: .8,
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
            const PopupMenuItem<String>(
              value: 'loggout',
              child: Row(
                children: [
                  Icon(
                    Icons.logout,
                    size: 15.0,
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                  Text(
                    'Se déconnecter',
                    textScaleFactor: .8,
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
            const PopupMenuItem<String>(
              value: 'exit',
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.clear_circled,
                    size: 15.0,
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                  Text(
                    'Quitter l\'application',
                    textScaleFactor: .8,
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
      ),
    );
  }

  Widget avatar() {
    return ZoomIn(
      child: Container(
        height: 50.0,
        width: 50.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.2),
              blurRadius: 8.0,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              authController.user.value.name!.substring(0, 1).toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.indigo,
                fontSize: 16.0,
              ),
            )
          ],
        ),
      ),
    );
  }

  void handleMenuAction(BuildContext context, String action) {
    switch (action) {
      case 'profile':
        // Implémentez l'action pour voir le profil
        break;
      case 'loggout':
        storage.remove("user-data");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const StartingScreen()),
          (route) => false,
        );
        break;
      case 'exit':
        exit(0);
    }
  }
}

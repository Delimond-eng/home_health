import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_health/global/controllers.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      child: Obx(
        () => Container(
          height: 40.0,
          width: 40.0,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage("assets/imgs/shape-bg-1.jpg"),
              alignment: Alignment.center,
              fit: BoxFit.cover,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.4),
                blurRadius: 8.0,
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 5, 175, 104).withOpacity(.9),
              shape: BoxShape.circle,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  authController.user.value.name!.substring(0, 1).toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 16.0,
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_health/global/controllers.dart';

import '../../global/storage.dart';
import '../../utils/costum_modal.dart';
import '../screens/starting_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(context),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Nom complet',
                      textScaleFactor: .8,
                      style: TextStyle(
                        color: Colors.indigo,
                      ),
                    ),
                    Text(
                      authController.user.value.name!,
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Divider(),
                    const Text(
                      'Adresse email',
                      textScaleFactor: .8,
                      style: TextStyle(
                        color: Colors.indigo,
                      ),
                    ),
                    Text(
                      authController.user.value.email!,
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Divider(),
                    const Text(
                      'Téléphone',
                      textScaleFactor: .8,
                      style: TextStyle(
                        color: Colors.indigo,
                      ),
                    ),
                    Text(
                      authController.user.value.phone!,
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Divider(),
                    const Text(
                      'Rôle',
                      textScaleFactor: .8,
                      style: TextStyle(
                        color: Colors.indigo,
                      ),
                    ),
                    Text(
                      authController.user.value.profile!.capitalize!,
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipPath(
          clipper: ShapeWidget(),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.indigo,
                  Colors.indigo.shade400,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
              ),
            ),
            width: size.width,
            height: size.height * .20,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Mon profil",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 35.0,
                              width: 35.0,
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(35.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(.2),
                                    offset: const Offset(0, 2),
                                    blurRadius: 5,
                                  )
                                ],
                              ),
                              child: Material(
                                borderRadius: BorderRadius.circular(35.0),
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(35.0),
                                  onTap: () {
                                    showMessage(context,
                                        message:
                                            "Voulez-vous vous deconnecter de votre compte ?",
                                        onAccepted: () {
                                      storage.remove("user-data");
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const StartingScreen(),
                                        ),
                                        (route) => false,
                                      );
                                    });
                                  },
                                  child: const Center(
                                    child: Icon(
                                      Icons.logout_rounded,
                                      color: Colors.black,
                                      size: 15.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -40.0,
          left: 40.0,
          child: Container(
            height: 80.0,
            width: 80.0,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/imgs/user.png',
                    fit: BoxFit.scaleDown,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ShapeWidget extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);

    path.addOval(
      Rect.fromCircle(
        center: Offset(
          size.width * .22,
          size.height,
        ),
        radius: 50.0,
      ),
    );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

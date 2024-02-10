import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import '../index.dart';
import '../widgets/login_field.dart';

class StartingScreen extends StatefulWidget {
  const StartingScreen({super.key});

  @override
  State<StartingScreen> createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen> {
  final PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.indigo.shade300,
              Colors.indigo.shade800,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: PageView(
          controller: pageController,
          children: [
            landingHome(context),
            login(context),
          ],
        ),
      ),
    );
  }

  Widget landingHome(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: SafeArea(
            child: FadeInUp(
              child: Lottie.asset(
                "assets/animateds/doctor-1.json",
                repeat: false,
              ),
            ),
          ),
        ),
        FadeInUp(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(
                fontSize: 20.0,
                fontFamily: 'Poppins',
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              children: [
                const TextSpan(text: "Bienvenue sur \n"),
                TextSpan(
                  text: "HOME".toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 3.5,
                    fontFamily: 'Staatliches',
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(.2),
                        blurRadius: .2,
                        offset: const Offset(0, 3),
                      )
                    ],
                    fontSize: 35.0,
                  ),
                ),
                TextSpan(
                  text: "HEALTH".toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 3.5,
                    fontFamily: 'Staatliches',
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(.2),
                        blurRadius: .2,
                        offset: const Offset(0, 3),
                      )
                    ],
                    fontSize: 35.0,
                    color: const Color.fromARGB(255, 235, 22, 40),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 10.0,
          ),
          child: FadeInUp(
            child: Text(
              "L'application offre un outil de planification intuitif permettant aux infirmiers de gérer leur emploi du temps de manière efficace. Ils peuvent organiser et planifier les visites chez les patients en fonction de leur disponibilité, optimisant ainsi leur itinéraire !",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 10.0,
                color: Colors.indigo.shade100,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        ZoomIn(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 20.0,
            ),
            child: SizedBox(
              height: 50.0,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton.icon(
                icon: SvgPicture.asset(
                  "assets/svg/next_big.svg",
                  // ignore: deprecated_member_use
                  color: Colors.white,
                  width: 25.0,
                  height: 20.0,
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 15.0,
                  backgroundColor: const Color.fromARGB(255, 235, 22, 40),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                ),
                onPressed: () {
                  pageController.jumpToPage(1);
                },
                label: const Text(
                  "COMMENCER MAINTENANT",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 10.0,
                    fontFamily: 'Poppins',
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget login(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        bottom: 10.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SafeArea(
            child: FadeInUp(
              child: Lottie.asset(
                "assets/animateds/doctor-1.json",
                repeat: false,
              ),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          FadeInUp(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                children: [
                  const TextSpan(text: "Authentification \n"),
                  TextSpan(
                    text: "HOME".toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      letterSpacing: 3.5,
                      fontFamily: 'Staatliches',
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(.2),
                          blurRadius: .2,
                          offset: const Offset(0, 3),
                        )
                      ],
                      fontSize: 35.0,
                    ),
                  ),
                  TextSpan(
                    text: "HEALTH".toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      letterSpacing: 3.5,
                      fontFamily: 'Staatliches',
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(.2),
                          blurRadius: .2,
                          offset: const Offset(0, 3),
                        )
                      ],
                      fontSize: 35.0,
                      color: const Color.fromARGB(255, 235, 22, 40),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 5.0,
            ),
            child: FadeInUp(
              child: Text(
                "Veuillez vous authentifier pour accéder à l'application et commencer vos interventions auprès des patients à domicile !",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10.0,
                  color: Colors.indigo.shade100,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Column(
              children: [
                LoginField(
                  icon: "profile",
                  hintText: "Entrez votre identifiant...",
                ),
                SizedBox(
                  height: 10,
                ),
                LoginField(
                  icon: "lock-password",
                  hintText: "Entrez le mot de passe...",
                  isPassword: true,
                ),
              ],
            ),
          ),
          ZoomIn(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: SizedBox(
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton.icon(
                  icon: SvgPicture.asset(
                    "assets/svg/next_big.svg",
                    // ignore: deprecated_member_use
                    color: Colors.white,
                    width: 25.0,
                    height: 20.0,
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 15.0,
                    backgroundColor: const Color.fromARGB(255, 235, 22, 40),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainHome(),
                      ),
                      (route) => false,
                    );
                  },
                  label: const Text(
                    "CONNECTER",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 10.0,
                      fontFamily: 'Poppins',
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

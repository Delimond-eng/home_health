import 'package:flutter/material.dart';
import '../main/nurse/index.dart';
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
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            login(context),
            register(context),
          ],
        ),
      ),
    );
  }

  Widget login(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(
          bottom: 10.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset(
                  "assets/imgs/logo-3.png",
                  height: 50.0,
                ),
                const SizedBox(
                  width: 8.0,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                    children: [
                      TextSpan(
                        text: "HOME".toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Staatliches',
                          letterSpacing: 2,
                          color: const Color(0xFFE10000),
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(.2),
                              blurRadius: .2,
                              offset: const Offset(0, 1),
                            )
                          ],
                          fontSize: 40.0,
                        ),
                      ),
                      TextSpan(
                        text: "HEALTH".toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                          fontFamily: 'Staatliches',
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(.2),
                              blurRadius: .2,
                              offset: const Offset(0, 1),
                            )
                          ],
                          fontSize: 40.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 5.0,
              ),
              child: Text(
                "Veuillez vous connecter pour commencer vos interventions auprès des patients à domicile !",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12.0,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Column(
                children: [
                  LoginField(
                    icon: "email",
                    hintText: "Entrez votre email...",
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  LoginField(
                    icon: "lock-password",
                    hintText: "Entrez le mot de passe...",
                    isPassword: true,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: SizedBox(
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
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
                  child: const Text(
                    "CONNECTER",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 8, 15, 0),
              child: SizedBox(
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                child: OutlinedButton(
                  onPressed: () {
                    pageController.jumpToPage(1);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Colors.blue,
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    "Créer un compte médecin".toUpperCase(),
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget register(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(
          bottom: 10.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset(
                  "assets/imgs/logo-3.png",
                  height: 50.0,
                ),
                const SizedBox(
                  width: 8.0,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                    children: [
                      TextSpan(
                        text: "HOME".toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Staatliches',
                          color: const Color(0xFFE10000),
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(.2),
                              blurRadius: .2,
                              offset: const Offset(0, 1),
                            )
                          ],
                          fontSize: 40.0,
                          letterSpacing: 2,
                        ),
                      ),
                      TextSpan(
                        text: "HEALTH".toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                          fontFamily: 'Staatliches',
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(.2),
                              blurRadius: .2,
                              offset: const Offset(0, 1),
                            )
                          ],
                          fontSize: 40.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 5.0,
              ),
              child: Text(
                "Veuillez créer un compte médecin pour gérer les visites à domicile de vos infirmier !",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12.0,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Column(
                children: [
                  LoginField(
                    icon: "profile",
                    hintText: "Nom complet...",
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  LoginField(
                    icon: "phone",
                    hintText: "Téléphone...",
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  LoginField(
                    icon: "medical-o-1",
                    hintText: "Numéro d'ordre...",
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  LoginField(
                    icon: "hospital",
                    hintText: "Hôpital...",
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  LoginField(
                    icon: "email",
                    hintText: "Adresse email...",
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  LoginField(
                    icon: "lock-password",
                    hintText: "Entrez le mot de passe...",
                    isPassword: true,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: SizedBox(
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
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
                  child: Text(
                    "Créer compte".toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 8, 15, 0),
              child: SizedBox(
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                child: OutlinedButton(
                  onPressed: () {
                    pageController.jumpToPage(0);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Colors.blue,
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    "Retour à la page de connexion".toUpperCase(),
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

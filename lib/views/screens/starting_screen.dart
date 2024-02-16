import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:home_health/global/controllers.dart';
import 'package:home_health/services/api.manger.dart';
import 'package:home_health/views/widgets/submit_button_loader.dart';
import '../main/doctor/index.dart';
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

  bool loginLoading = false;
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPass = TextEditingController();
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Column(
                children: [
                  LoginField(
                    icon: "email",
                    hintText: "Entrez votre email...",
                    controller: txtEmail,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  LoginField(
                    icon: "lock-password",
                    hintText: "Entrez le mot de passe...",
                    isPassword: true,
                    controller: txtPass,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: SizedBox(
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                child: SubmitBtnLoader(
                  isLoading: loginLoading,
                  label: "Connecter",
                  color: Colors.green,
                  onPressed: () {
                    if (txtEmail.text.isEmpty) {
                      EasyLoading.showToast("Adresse email requis !");
                      return;
                    }
                    if (txtPass.text.isEmpty) {
                      EasyLoading.showToast("Mot de passe requis !");
                      return;
                    }
                    setState(() => loginLoading = true);

                    //Start login statment
                    ApiManager.login(
                      data: {
                        "email": txtEmail.text,
                        "pwd": txtPass.text,
                      },
                    ).then((res) {
                      setState(() => loginLoading = false);
                      if (res != null) {
                        if (res["profile"].toString() == "nurse") {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NurseHome(),
                            ),
                            (route) => false,
                          );
                        } else {
                          dataController.initDoctorData();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DoctorHome(),
                            ),
                            (route) => false,
                          );
                        }
                      }
                    });
                  },
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

  final TextEditingController txtRegisterName = TextEditingController();
  final TextEditingController txtRegisterPhone = TextEditingController();
  final TextEditingController txtRegisterNumOrder = TextEditingController();
  final TextEditingController txtRegisterHospital = TextEditingController();
  final TextEditingController txtRegisterEmail = TextEditingController();
  final TextEditingController txtRegisterPass = TextEditingController();

  bool registerLoading = false;
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Column(
                children: [
                  LoginField(
                    icon: "profile",
                    hintText: "Nom complet...",
                    controller: txtRegisterName,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  LoginField(
                    icon: "phone",
                    hintText: "Téléphone...",
                    controller: txtRegisterPhone,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  LoginField(
                    icon: "medical-o-1",
                    hintText: "Numéro d'ordre...",
                    controller: txtRegisterNumOrder,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  LoginField(
                    icon: "hospital",
                    hintText: "Hôpital...",
                    controller: txtRegisterHospital,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  LoginField(
                    icon: "email",
                    hintText: "Adresse email...",
                    controller: txtRegisterEmail,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  LoginField(
                    icon: "lock-password",
                    hintText: "Entrez le mot de passe...",
                    controller: txtRegisterPass,
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
                child: SubmitBtnLoader(
                  isLoading: registerLoading,
                  label: "Créer compte",
                  color: Colors.blue,
                  onPressed: () {
                    if (txtRegisterName.text.isEmpty) {
                      EasyLoading.showToast('Nom complet requis !');
                      return;
                    }
                    if (txtRegisterEmail.text.isEmpty) {
                      EasyLoading.showToast('Email requis !');
                      return;
                    }
                    if (txtRegisterPhone.text.isEmpty) {
                      EasyLoading.showToast('Numéro de téléphone requis !');
                      return;
                    }
                    if (txtRegisterNumOrder.text.isEmpty) {
                      EasyLoading.showToast('Numéro d\'ordre requis !');
                      return;
                    }
                    if (txtRegisterHospital.text.isEmpty) {
                      EasyLoading.showToast('Hôpital requis !');
                      return;
                    }
                    if (txtRegisterPass.text.isEmpty) {
                      EasyLoading.showToast('Hôpital requis !');
                      return;
                    }
                    setState(() => registerLoading = true);
                    ApiManager.registerDoctor(
                      data: {
                        "email": txtRegisterEmail.text,
                        "pwd": txtRegisterPass.text,
                        "fullname": txtRegisterName.text,
                        "phone": txtRegisterPhone.text,
                        "order_num": txtRegisterNumOrder.text,
                        "hospital": txtRegisterHospital.text
                      },
                    ).then((res) {
                      setState(() => registerLoading = false);
                      if (res != null) {
                        EasyLoading.showSuccess(
                            "Votre compte a été créé avec succès !");

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DoctorHome(),
                          ),
                          (route) => false,
                        );
                      }
                    });
                  },
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

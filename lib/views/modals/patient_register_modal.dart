import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_check_box.dart';
import '../widgets/custom_field.dart';
import '../widgets/finger_enroll_input.dart';

Future<void> showPatientRegisterModal(context, callback) async {
  final nom = TextEditingController();
  final postnom = TextEditingController();
  final prenom = TextEditingController();
  final adresse = TextEditingController();
  late String sexe = "";
  showGeneralDialog(
    barrierDismissible: false,
    barrierLabel: "patient creating modal",
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
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  bottom: 10.0,
                  left: 5.0,
                  right: 5.0,
                  top: 50.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: StatefulBuilder(
                  builder: (context, setter) => Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              "Création du nouveau patient".toUpperCase(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w800,
                                color: Colors.indigo,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomField(
                            controller: nom,
                            hintText: "Saisir le nom du patient...",
                            title: 'Nom',
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          CustomField(
                            controller: postnom,
                            hintText: "Saisir le postnom du patient...",
                            title: "Postnom",
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          CustomField(
                            controller: prenom,
                            hintText: "Saisir le prénom du patient...",
                            title: "Prénom",
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          CustomField(
                            controller: adresse,
                            hintText: "Saisir l'adresse du patient..",
                            title: "Adresse",
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(
                              "Sexe",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.indigo,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: CostumCheckBox(
                                  onChanged: () {
                                    setter(() => sexe = "M");
                                  },
                                  title: "Masculin",
                                  value: sexe == "M",
                                ),
                              ),
                              const SizedBox(
                                width: 15.0,
                              ),
                              Flexible(
                                child: CostumCheckBox(
                                  onChanged: () {
                                    setter(() => sexe = "F");
                                  },
                                  value: sexe == "F",
                                  title: "Féminin",
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Center(
                              child: Text(
                                "Veuillez enroller les empreintes du patient",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.indigo,
                                ),
                              ),
                            ),
                          ),
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FingerEnrollInput(),
                              FingerEnrollInput(),
                              FingerEnrollInput(),
                            ],
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          ZoomIn(
                            child: SizedBox(
                              height: 50.0,
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.indigo,
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
                                  Navigator.pop(context);
                                  callback();
                                },
                                child: const Text(
                                  "Enregistrer",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
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
              ),
              Positioned(
                top: 50.0,
                right: 15.0,
                child: Container(
                  height: 35.0,
                  width: 35.0,
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(40.0)),
                    color: Colors.pink,
                  ),
                  child: Material(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(40.0),
                    ),
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(40.0),
                      ),
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
      );
    },
  );
}

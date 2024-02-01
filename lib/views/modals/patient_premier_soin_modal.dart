import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/soin.dart';
import '../widgets/custom_field.dart';
import '../widgets/heading_title.dart';
import '../widgets/soin_card.dart';

Future<void> showPatientPremierSoinModal(context, callback) async {
  final traitment = TextEditingController();
  final dosage = TextEditingController();
  List<Soin> soins = [];
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
                height: soins.isNotEmpty
                    ? null
                    : MediaQuery.of(context).size.height * .5,
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Veuillez administrer les premiers soins au patient en cours de consultation !",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          CustomField(
                            controller: traitment,
                            hintText: "Saisir le nom du traitement...",
                            title: "Nom du traitement",
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          CustomField(
                            controller: dosage,
                            hintText: "Saisir le dosage...",
                            title: "Dosage",
                          ),
                          const SizedBox(
                            height: 20.0,
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
                                  if (traitment.text.isNotEmpty &&
                                      dosage.text.isNotEmpty) {
                                    var soin = Soin(
                                        title: traitment.text,
                                        dosage: dosage.text);
                                    setter(() {
                                      soins.add(soin);
                                      traitment.text = "";
                                      dosage.text = "";
                                    });
                                  }
                                },
                                child: const Text(
                                  "Ajouter soin",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (soins.isNotEmpty)
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10.0),
                              child: HeadingTitle(
                                title: "Soins administrés",
                              ),
                            ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: soins.length,
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                            ),
                            itemBuilder: (context, i) => ZoomIn(
                              child: SoinCard(
                                data: soins[i],
                                onCleared: () {
                                  setter(() {
                                    soins.removeAt(i);
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10.0,
                right: 20.0,
                child: Container(
                  height: 35.0,
                  width: 35.0,
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(40.0)),
                    color: Colors.pink,
                  ),
                  child: Material(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(40.0),
                    ),
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(40.0),
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

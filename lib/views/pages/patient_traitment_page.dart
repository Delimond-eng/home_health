import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:home_health/global/controllers.dart';
import 'package:home_health/models/patient.dart';
import 'package:home_health/services/api.manger.dart';
import 'package:home_health/utils/costum_modal.dart';
import 'package:home_health/views/widgets/custom_checkbox.dart';
import 'package:home_health/views/widgets/submit_button_loader.dart';

import '../../models/nurse.dart';
import '../../models/schedule.dart';
import '../widgets/heading_title.dart';
import '../widgets/user_avatar.dart';

class PatientTraitmentPage extends StatefulWidget {
  final Visit item;
  const PatientTraitmentPage({super.key, required this.item});

  @override
  State<PatientTraitmentPage> createState() => _PatientTraitmentPageState();
}

class _PatientTraitmentPageState extends State<PatientTraitmentPage> {
  List<Treatment> selecteds = [];
  bool isSelectedAll = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initWhenIsDone();
  }

  initWhenIsDone() {
    setState(() {
      for (var e in nurseDataController.selectScheduleTreatments) {
        if (e.patientTreatmentStatus == 'done') {
          selecteds.add(e);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Column(
        children: [
          _header(context),
          Expanded(
            child: SingleChildScrollView(
              child: Obx(() => Column(
                    children: [
                      patientInfo(context),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 2,
                        ),
                        child: HeadingTitle(
                          title: "Soins & services prévus",
                          actionChild: ElevatedButton.icon(
                            onPressed: () {
                              showAddServiceModal(context);
                            },
                            style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              backgroundColor: Colors.blueAccent,
                            ),
                            label: const Text(
                              "Ajouter",
                              style: TextStyle(
                                fontSize: 12.0,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            icon: const Icon(
                              CupertinoIcons.add,
                              size: 14.0,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 5.0,
                        ),
                        child: Text(
                          "Veuillez sélectionner les soins prodigués ou les services administrés à ce patient !",
                          textScaleFactor: .8,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.grey.shade800,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        child: CustomCheckbox(
                          isChecked: isSelectedAll,
                          title: "Sélectionnez tout",
                          onChecked: () {
                            setState(() {
                              isSelectedAll = !isSelectedAll;
                              if (isSelectedAll) {
                                for (var e in nurseDataController
                                    .selectScheduleTreatments) {
                                  e.patientTreatmentStatus = "done";
                                }
                                selecteds.addAll(nurseDataController
                                    .selectScheduleTreatments);
                              } else {
                                for (var e in nurseDataController
                                    .selectScheduleTreatments) {
                                  e.patientTreatmentStatus = "pending";
                                }
                                selecteds = [];
                              }
                            });
                          },
                        ),
                      ),
                      buildItems(context)
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }

  Widget buildItems(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          for (int i = 0;
              i < nurseDataController.selectScheduleTreatments.length;
              i++) ...[
            TaskCard(
              selected: nurseDataController
                      .selectScheduleTreatments[i].patientTreatmentStatus ==
                  "done",
              onSelected: () {
                setState(() {
                  nurseDataController.selectScheduleTreatments[i]
                      .patientTreatmentStatus = nurseDataController
                              .selectScheduleTreatments[i]
                              .patientTreatmentStatus ==
                          "pending"
                      ? "done"
                      : "pending";
                });
                if (nurseDataController
                        .selectScheduleTreatments[i].patientTreatmentStatus ==
                    'done') {
                  setState(() {
                    selecteds
                        .add(nurseDataController.selectScheduleTreatments[i]);
                  });
                } else {
                  setState(() {
                    int index = selecteds.indexWhere((e) => e
                        .patientTreatmentLibelle!
                        .toLowerCase()
                        .contains(nurseDataController
                            .selectScheduleTreatments[i]
                            .patientTreatmentLibelle!
                            .toLowerCase()));
                    selecteds.removeAt(index);
                  });
                }
              },
              soin: nurseDataController.selectScheduleTreatments[i],
            ),
          ],
          if (selecteds.isNotEmpty)
            ZoomIn(
              child: SizedBox(
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                child: SubmitBtnLoader(
                  color: Colors.green,
                  isLoading: isLoading,
                  onPressed: () {
                    List<Map<String, dynamic>> data = [];
                    for (var e in selecteds) {
                      if (e.patientTreatmentStatus == 'done') {
                        data.add({"id": e.id});
                      }
                    }

                    if (data.isEmpty) {
                      EasyLoading.showToast(
                          "Veuillez cocher un traitement ou service !");
                      return;
                    }
                    setState(() => isLoading = true);
                    ApiManager.completVisit(data: {
                      "visit_id": widget.item.id,
                      "treatments": data,
                    }).then((result) {
                      setState(() => isLoading = false);
                      if (result != null) {
                        EasyLoading.showSuccess(
                          "Visite mise à jour avec succès !",
                        );
                        Navigator.pop(context);
                      }
                    });
                  },
                  label: 'Valider & sauvegarder',
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget patientInfo(BuildContext context) {
    return SizedBox(
      height: 140,
      width: MediaQuery.of(context).size.width,
      child: Container(
        decoration: BoxDecoration(color: Colors.indigo.shade500),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade200,
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/svg/patient.svg",
                          height: 24.0,
                          colorFilter: const ColorFilter.mode(
                            Colors.indigo,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item.patient!.patientFullname!.toUpperCase(),
                          textScaleFactor: .8,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svg/location-place.svg",
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                              height: 20,
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Flexible(
                              child: Text(
                                widget.item.patient!.patientAddress!,
                                textScaleFactor: .8,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey.shade200,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              if (widget.item.visitStatus != 'completed')
                SizedBox(
                  height: 40.0,
                  width: MediaQuery.of(context).size.width,
                  child: OutlinedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20.0),
                            ),
                          ),
                          builder: (context) {
                            for (var e in nurseDataController.nurses) {
                              e.nurseStatus = "actif";
                            }
                            return infirmiersBottomSheet(context);
                          });
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Colors.indigo.shade50,
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    child: Text(
                      "Déléguer la visite à un collègue".toUpperCase(),
                      textScaleFactor: .8,
                      style: TextStyle(
                        color: Colors.indigo.shade100,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void showAddServiceModal(BuildContext context) {
    final TextEditingController txtLibelle = TextEditingController();
    bool isLoading = false;
    return showCustomModal(
      context,
      modalTitle: "Ajout des Soins supplémentaires",
      child: StatefulBuilder(builder: (context, setter) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                textAlign: TextAlign.left,
                maxLines: null,
                controller: txtLibelle,
                decoration: InputDecoration(
                  hintText: 'Entrez votre texte ici...',
                  hintStyle: const TextStyle(
                    fontSize: 10.0,
                  ),
                  labelText: 'Soin ou service supplémentaire',
                  alignLabelWithHint: true,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      5,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(
                    16.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: SubmitBtnLoader(
                    color: Colors.green,
                    isLoading: isLoading,
                    onPressed: () async {
                      if (txtLibelle.text.isNotEmpty) {
                        setter(() => isLoading = true);
                        var form = {
                          "visit_id": widget.item.id,
                          "treatments": [
                            {"libelle": txtLibelle.text}
                          ]
                        };
                        ApiManager.addTreatments(data: form).then((res) async {
                          setter(() => isLoading = false);
                          if (res != null) {
                            EasyLoading.showSuccess("");

                            await nurseDataController
                                .refreshSelectedVisitTreatments(
                              visitId: widget.item.id,
                            );
                            Get.back();
                          }
                        });
                      }
                    },
                    label: "Sauvegarder",
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget infirmiersBottomSheet(context) {
    Nurse? selectedInf;
    bool isLoading = false;
    return DraggableScrollableSheet(
      initialChildSize: 0.5, // Hauteur initiale de la feuille
      minChildSize: 0.2, // Hauteur minimale de la feuille
      maxChildSize: 0.9, // Hauteur maximale de la feuille
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return StatefulBuilder(builder: (context, setter) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(10.0),
            controller: scrollController,
            child: Column(
              children: [
                const Text(
                  'Veuillez sélectionner votre collègue infirmier auquel vous voulez déléguer cette visite !',
                  textScaleFactor: .9,
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                for (var nurse in nurseDataController.nurses) ...[
                  NurseCard(
                    item: nurse,
                    selected: nurse.nurseStatus == "selected",
                    onSelected: () {
                      for (var el in dataController.nurses) {
                        el.nurseStatus = "actif";
                      }
                      nurse.nurseStatus =
                          nurse.nurseStatus == "actif" ? "selected" : "actif";
                      if (nurse.nurseStatus == "selected") {
                        setter(() {
                          selectedInf = nurse;
                        });
                      } else {
                        setter(() {
                          selectedInf = null;
                        });
                      }
                    },
                  ),
                ],
                if (selectedInf != null) ...[
                  const SizedBox(
                    height: 5.0,
                  ),
                  ZoomIn(
                    child: SizedBox(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width,
                      child: SubmitBtnLoader(
                        icon: SvgPicture.asset(
                          "assets/svg/check-double.svg",
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                          height: 22.0,
                        ),
                        color: Colors.green,
                        isLoading: isLoading,
                        onPressed: () async {
                          setter(() => isLoading = true);
                          int visitId = widget.item.id!;
                          ApiManager.delegateVisit(data: {
                            "visit_id": visitId,
                            "nurse_id": selectedInf!.id
                          }).then((res) {
                            setter(() => isLoading = false);
                            EasyLoading.showSuccess(
                                "Visite déléguée avec success");
                            Future.delayed(const Duration(seconds: 2), () {
                              Get.back();
                              Navigator.pop(context);
                            });
                          });
                        },
                        label: "Valider la visite",
                      ),
                    ),
                  )
                ]
              ],
            ),
          );
        });
      },
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/imgs/shape-bg-1.jpg"),
          alignment: Alignment.center,
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.indigo,
              Colors.indigo.shade300.withOpacity(.8),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 40.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(5),
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              "assets/svg/arrow-back.svg",
                              // ignore: deprecated_member_use
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      "Traitement du patient",
                      textScaleFactor: .9,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    )
                  ],
                ),
                const UserAvatar()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NurseCard extends StatelessWidget {
  final bool selected;
  final Nurse item;
  final VoidCallback? onSelected;
  const NurseCard({
    super.key,
    this.selected = false,
    required this.item,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5.0),
      width: MediaQuery.of(context).size.width,
      height: 60.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.blue.shade100,
          width: .8,
        ),
        gradient: LinearGradient(colors: [
          Colors.blue.shade50,
          Colors.blue.shade100,
        ]),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onSelected,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        height: 35.0,
                        width: 35.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35.0),
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade400,
                              Colors.blue.shade800,
                            ],
                          ),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            "assets/svg/profile.svg",
                            height: 24.0,
                            colorFilter: const ColorFilter.mode(
                                Colors.white, BlendMode.srcIn),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item.nurseFullname!,
                              textScaleFactor: .8,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Text(
                              'Infirmier',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 30.0,
                  width: 30.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: selected
                      ? ZoomIn(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green[500],
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: const Center(
                              child: Icon(
                                CupertinoIcons.checkmark_alt,
                                color: Colors.white,
                                size: 16.0,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final VoidCallback? onSelected;
  final bool selected;
  final Treatment soin;
  const TaskCard({
    super.key,
    this.onSelected,
    this.selected = false,
    required this.soin,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setter) {
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(bottom: 4),
            height: 60.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Material(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(5.0),
                onTap: onSelected,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 25.0,
                        width: 25.0,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color:
                                selected ? Colors.blue.shade300 : Colors.grey,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: selected
                            ? ZoomIn(
                                child: Container(
                                  margin: const EdgeInsets.all(2.5),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(3.0),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      CupertinoIcons.checkmark_alt,
                                      color: Colors.white,
                                      size: 16.0,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      // Texte à partir du début à droite avec passage à la ligne
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              soin.patientTreatmentLibelle!,
                              textAlign: TextAlign.start,
                              textScaleFactor: .8,
                              style: TextStyle(
                                fontSize: 17.0,
                                decoration: selected
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 4.0,
            child: Container(
              color: Colors.indigo.shade100,
              height: .8,
              width: MediaQuery.of(context).size.width - 25,
            ),
          )
        ],
      );
    });
  }
}

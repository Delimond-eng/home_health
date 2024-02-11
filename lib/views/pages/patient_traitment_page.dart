import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_health/data/mock_data.dart';

import '../../models/infirmier.dart';
import '../widgets/heading_title.dart';
import '../widgets/medic_doc_item.dart';

class PatientTraitmentPage extends StatefulWidget {
  final List<Soin> soins;
  const PatientTraitmentPage({super.key, required this.soins});

  @override
  State<PatientTraitmentPage> createState() => _PatientTraitmentPageState();
}

class _PatientTraitmentPageState extends State<PatientTraitmentPage> {
  List<Soin> selecteds = [];
  bool isSelectedAll = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      floatingActionButton: selecteds.isNotEmpty
          ? ZoomIn(
              child: FloatingActionButton(
                backgroundColor: const Color.fromARGB(255, 8, 164, 99),
                child: SvgPicture.asset(
                  "assets/svg/check-double.svg",
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  height: 24.0,
                ),
                onPressed: () {},
              ),
            )
          : null,
      body: Column(
        children: [
          _header(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 5,
                    ),
                    height: 50.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 1.5),
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.transparent,
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20.0),
                                ),
                              ),
                              builder: (context) {
                                for (var i in infirmiers) {
                                  i.isSelected = false;
                                }
                                return infirmiersBottomSheet(context);
                              });
                        },
                        borderRadius: BorderRadius.circular(5),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 8.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/svg/transfer.svg",
                                colorFilter: const ColorFilter.mode(
                                  Colors.blue,
                                  BlendMode.srcIn,
                                ),
                                height: 15.0,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              const Text(
                                'Déléguer la visite à un collègue ',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 2,
                    ),
                    child: HeadingTitle(
                      title: "Soins & services prévus",
                      actionChild: Container(
                          height: 30.0,
                          width: 30.0,
                          decoration: BoxDecoration(
                            color: Colors.indigo.shade200,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Material(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(5.0),
                              onTap: () {
                                setState(() {
                                  isSelectedAll = !isSelectedAll;
                                  if (isSelectedAll) {
                                    selecteds.addAll(widget.soins);
                                    for (var s in widget.soins) {
                                      s.selected = true;
                                    }
                                  } else {
                                    selecteds = [];
                                    for (var s in widget.soins) {
                                      s.selected = false;
                                    }
                                  }
                                });
                              },
                              child: isSelectedAll
                                  ? ZoomIn(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.indigo[900],
                                          borderRadius:
                                              BorderRadius.circular(4.0),
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
                          )),
                    ),
                  ),
                  FadeInUp(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
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
                  ),
                  for (int i = 0; i < widget.soins.length; i++) ...[
                    TaskCard(
                      selected: widget.soins[i].selected,
                      onSelected: () {
                        setState(() {
                          widget.soins[i].selected = !widget.soins[i].selected;
                        });
                        if (widget.soins[i].selected) {
                          setState(() {
                            selecteds.add(widget.soins[i]);
                          });
                        } else {
                          setState(() {
                            int index = selecteds.indexWhere((e) => e.libelle!
                                .toLowerCase()
                                .contains(
                                    widget.soins[i].libelle!.toLowerCase()));
                            selecteds.removeAt(index);
                          });
                        }
                      },
                      soin: widget.soins[i],
                    ),
                  ],
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget infirmiersBottomSheet(context) {
    Infirmier? selectedInf;
    return StatefulBuilder(builder: (context, setter) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
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
            for (var infirmier in infirmiers) ...[
              NurseCard(
                item: infirmier,
                selected: infirmier.isSelected,
                onSelected: () {
                  for (var el in infirmiers) {
                    el.isSelected = false;
                  }
                  infirmier.isSelected = !infirmier.isSelected;
                  if (infirmier.isSelected) {
                    setter(() {
                      selectedInf = infirmier;
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
                  child: ElevatedButton.icon(
                    icon: SvgPicture.asset(
                      "assets/svg/check-double.svg",
                      colorFilter:
                          const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      height: 25.0,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 11, 179, 89),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {},
                    label: const Text(
                      "Valider la visite",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                        fontFamily: 'Poppins',
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              )
            ]
          ],
        ),
      );
    });
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
                              "assets/svg/back.svg",
                              // ignore: deprecated_member_use
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    const Text(
                      "Traitement du patient",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    )
                  ],
                ),
                ZoomIn(
                  child: Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage("assets/imgs/avatar1.jpg"),
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.2),
                          blurRadius: 8.0,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                  ),
                ),
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
  final Infirmier item;
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
                              item.nom!,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
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
  final Soin soin;
  const TaskCard({
    super.key,
    this.onSelected,
    this.selected = false,
    required this.soin,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setter) {
      return ZoomIn(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(bottom: 8),
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
                          height: 30.0,
                          width: 30.0,
                          decoration: BoxDecoration(
                            color: Colors.indigo.shade200,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: selected
                              ? ZoomIn(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.indigo[900],
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
                                soin.libelle!,
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
              bottom: 8.0,
              child: Container(
                color: Colors.indigo.shade200,
                height: .8,
                width: MediaQuery.of(context).size.width - 25,
              ),
            )
          ],
        ),
      );
    });
  }
}

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/heading_title.dart';

class PatientTraitmentPage extends StatefulWidget {
  const PatientTraitmentPage({super.key});

  @override
  State<PatientTraitmentPage> createState() => _PatientTraitmentPageState();
}

class _PatientTraitmentPageState extends State<PatientTraitmentPage> {
  List<bool> selecteds = [];
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
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.transparent,
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
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
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 2,
                    ),
                    child: HeadingTitle(
                      title: "Soins & services prévus",
                      withActionBtn: false,
                    ),
                  ),
                  FadeInUp(
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                      child: Text(
                        "Veuillez sélectionner les soins prodigués ou les services administrés à ce patient !",
                        textScaleFactor: .8,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.red,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  for (int i = 0; i < 6; i++) ...[
                    TaskCard(
                      onSelected: (val) {
                        if (val!) {
                          selecteds.add(val);
                        }
                      },
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

class TaskCard extends StatelessWidget {
  final Function(bool? checked)? onSelected;
  const TaskCard({
    super.key,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = false;
    return StatefulBuilder(builder: (context, setter) {
      return ZoomIn(
        child: Container(
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
              onTap: () {
                setter(() {
                  isSelected = !isSelected;
                });
                Future.delayed(Duration.zero, () {
                  onSelected!(isSelected);
                });
              },
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
                      child: isSelected
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
                      width: 5.0,
                    ),
                    // Texte à partir du début à droite avec passage à la ligne
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Votre texte ici. Il peut être assez long et passer à la ligne en dessous de l\'image si nécessaire.',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 12.0,
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
      );
    });
  }
}

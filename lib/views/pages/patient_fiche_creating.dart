import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_health/views/widgets/custom_checkbox.dart';
import 'package:home_health/views/widgets/login_field.dart';

import '../widgets/heading_title.dart';
import '../widgets/user_avatar.dart';

class PatientFicheCreating extends StatefulWidget {
  const PatientFicheCreating({super.key});

  @override
  State<PatientFicheCreating> createState() => _PatientFicheCreatingState();
}

class _PatientFicheCreatingState extends State<PatientFicheCreating> {
  bool isMale = false;
  bool isFemale = false;
  final txtNom = TextEditingController();
  final txtPhone = TextEditingController();
  final txtAdresse = TextEditingController();

  List<TextEditingController> fieldControllers = [
    TextEditingController(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ZoomIn(
        child: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 8, 164, 99),
          child: SvgPicture.asset(
            "assets/svg/check-double.svg",
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            height: 24.0,
          ),
          onPressed: () {},
        ),
      ),
      body: Column(
        children: [
          _header(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 2,
                    ),
                    child: HeadingTitle(
                      title: "Informations personnelles",
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  LoginField(
                    hintText: "Nom complet *",
                    icon: "profile",
                    controller: txtNom,
                  ),
                  const SizedBox(
                    height: 1.0,
                  ),
                  LoginField(
                    hintText: "Nom complet *",
                    icon: "phone",
                    controller: txtPhone,
                  ),
                  const SizedBox(
                    height: 1.0,
                  ),
                  LoginField(
                    hintText: "Adresse *",
                    icon: "map-pin",
                    controller: txtAdresse,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Sexe *",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      CustomCheckbox(
                        title: "Masculin",
                        isChecked: isMale,
                        onChecked: () {
                          setState(() {
                            isMale = !isMale;
                            isFemale = false;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      CustomCheckbox(
                        title: "Féminin",
                        isChecked: isFemale,
                        onChecked: () {
                          setState(() {
                            isFemale = !isFemale;
                            isMale = false;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 2,
                    ),
                    child: HeadingTitle(
                      title: "Soins & services à prodiguer",
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  for (int i = 0; i < fieldControllers.length; i++) ...[
                    InputSoin(
                      controller: fieldControllers[i],
                      isLast: i == fieldControllers.length - 1,
                      onAddField: () {
                        int index = fieldControllers.length - 1;
                        if (i > index) {
                          fieldControllers.add(TextEditingController());
                        } else {
                          fieldControllers.removeAt(i);
                        }
                      },
                    ),
                  ]
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
                              "assets/svg/arrow-back.svg",
                              // ignore: deprecated_member_use
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      "Création fiche patient",
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

class InputSoin extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback? onAddField;
  final bool isLast;
  const InputSoin(
      {super.key, this.controller, this.isLast = false, this.onAddField});

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.left,
      maxLines: null,
      controller: controller,
      decoration: InputDecoration(
          hintText: 'Entrez le soin ou service à prodiguer...',
          labelText: 'Soin ou service',
          hintStyle: const TextStyle(fontSize: 12.0, color: Colors.grey),
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
          suffixIcon: IconButton(
            icon: isLast ? const Icon(Icons.add) : const Icon(Icons.close),
            onPressed: onAddField,
          )),
    );
  }
}

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../screens/consult_view_screen.dart';
import '../widgets/custom_check_box.dart';
import '../widgets/custom_field.dart';
import '../widgets/finger_enroll_input.dart';

class PatientRegisterPage extends StatefulWidget {
  const PatientRegisterPage({super.key});

  @override
  State<PatientRegisterPage> createState() => _PatientRegisterPageState();
}

class _PatientRegisterPageState extends State<PatientRegisterPage> {
  final nom = TextEditingController();
  final postnom = TextEditingController();
  final prenom = TextEditingController();
  final adresse = TextEditingController();
  late String sexe = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Column(
        children: [
          _header(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ZoomIn(
                    child: Center(
                      child: Lottie.asset(
                        "assets/animateds/patient.json",
                      ),
                    ),
                  ),
                  FadeInUp(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomField(
                          controller: nom,
                          hintText: "Saisir le nom du patient...",
                          title: 'Nom',
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        CustomField(
                          controller: postnom,
                          hintText: "Saisir le postnom du patient...",
                          title: "Postnom",
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        CustomField(
                          controller: postnom,
                          hintText: "Saisir le prénom du patient...",
                          title: "Prénom",
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            "Sexe",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.indigo,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: CostumCheckBox(
                                onChanged: () {
                                  setState(() => sexe = "M");
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
                                  setState(() => sexe = "F");
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
                              "Empreintes digitales",
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
                      ],
                    ),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ConsultViewScreen(),
                            ),
                          );
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
                      "Enregistrement patient",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

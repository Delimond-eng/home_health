import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_health/global/controllers.dart';

import '../modals/doctor/create_nurse.dart';
import '../widgets/heading_title.dart';
import '../widgets/menu_btn_action.dart';
import '../widgets/nurse_card.dart';
import '../widgets/user_avatar.dart';
import 'patient_fiche_creating.dart';

class HomeDoctorPage extends StatefulWidget {
  const HomeDoctorPage({super.key});

  @override
  State<HomeDoctorPage> createState() => _HomeDoctorPageState();
}

class _HomeDoctorPageState extends State<HomeDoctorPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            _header(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Card(
                      margin: EdgeInsets.zero,
                      child: GridView(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(8),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2.5,
                          crossAxisSpacing: 0.0,
                          mainAxisSpacing: 0.0,
                        ),
                        children: [
                          MenuBtnAction(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const PatientFicheCreating(),
                                ),
                              );
                            },
                            color: Colors.indigo,
                            title: "Création de la fiche patient",
                            icon: "patient.svg",
                            border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey.shade300, width: .5),
                              right: BorderSide(
                                color: Colors.grey.shade300,
                                width: .5,
                              ),
                            ),
                          ),
                          MenuBtnAction(
                            onPressed: () {
                              showCreateNurseModal(context);
                            },
                            icon: "nurse.svg",
                            color: Colors.indigo,
                            title: "Création de la fiche infirmier",
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.shade300,
                                width: .5,
                              ),
                            ),
                          ),
                          MenuBtnAction(
                            onPressed: () {},
                            color: Colors.indigo,
                            title: "Création agenda infirmier",
                            icon: "calendar-today.svg",
                            border: Border(
                              right: BorderSide(
                                color: Colors.grey.shade300,
                                width: .5,
                              ),
                            ),
                          ),
                          MenuBtnAction(
                            onPressed: () {},
                            color: Colors.indigo,
                            title: "Rapports périodiques",
                            icon: "report-2.svg",
                            border: const Border(
                              right: BorderSide(
                                color: Colors.transparent,
                                width: .5,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 2,
                      ),
                      child: HeadingTitle(
                        title: "Mes infirmiers",
                        color: Colors.indigo,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Obx(
                      () => Card(
                        margin: EdgeInsets.zero,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(5.0),
                          itemCount: dataController.nurses.length,
                          itemBuilder: (context, index) {
                            var item = dataController.nurses[index];
                            return NurseCard(
                              isLast: index == dataController.nurses.length - 1,
                              item: item,
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /*  Header widget */
  Widget _header(context) {
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
                    /* Image.asset(
                      "assets/imgs/logo-3.png",
                      height: 25.0,
                    ), */
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 30.0,
                          fontFamily: 'Staatliches',
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(.2),
                              blurRadius: .2,
                              offset: const Offset(0, 3),
                            )
                          ],
                        ),
                        children: [
                          TextSpan(
                            text: "HOME".toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          TextSpan(
                            text: "HEALTH".toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Color.fromARGB(255, 234, 59, 74),
                            ),
                          ),
                        ],
                      ),
                    ),
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

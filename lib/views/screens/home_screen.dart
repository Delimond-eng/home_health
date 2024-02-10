import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/heading_title.dart';
import '../widgets/medic_doc_item.dart';
import '../widgets/schedule_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Patient> patientsList = [
    Patient(
        adresse:
            "088, Bateke, Q.Mont des arts, Bandalungwa kinshasa, Ref. Paroisse St Antoine",
        color: Colors.red,
        nom: "Isaac Lebo",
        dateHour: "22 Fév 2024 16:30"),
    Patient(
        adresse: "03, Bismark, Q.Golf, Gombe kinshasa, Ref. Terrain maman Yemo",
        color: Colors.blue,
        nom: "Gaston Delimond",
        dateHour: "12 Fév 2024 13:30"),
    Patient(
        adresse:
            "044 bis, Itaga, Q.Commerce, Barumbu kinshasa, Ref. Marché central",
        color: Colors.grey,
        nom: "Ilunga Luendo",
        dateHour: "04 Fév 2024 14:00"),
    Patient(
        adresse:
            "05, Madinga, Q.Brikin, Ngaliema kinshasa, Ref. Collège St Damien",
        color: Colors.green,
        nom: "Lionnel Nawej",
        dateHour: "01 Fév 2024 12:30"),
  ];

  List<Schedule> schedules = [
    Schedule(
        title: "Préparation matinale",
        desc:
            "Rassembler le matériel médical nécessaire;Vérifier les dossiers des patients prévus pour la journée !",
        dateHour: "04 Fév 2024 08:30"),
    Schedule(
        title: "Visite chez Mme. Dupont",
        desc:
            "Administration de médicaments;Contrôle de la pression artérielle!",
        dateHour: "03 Fév 2024 12:30"),
    Schedule(
        title: "Déplacement vers le domicile de M. Martin",
        desc:
            "Prise en charge des soins de plaies;Mise à jour des dossiers électroniques!",
        dateHour: "05 Fév 2024 11:30"),
    Schedule(
        title: "Visite chez Mme. Garcia",
        desc: "Surveillance de la glycémie;Conseils sur la gestion du diabète!",
        dateHour: "08 Fév 2024 14:30"),
  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            _header(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 2,
                      ),
                      child: HeadingTitle(
                        title: "Mon agenda",
                        color: Colors.indigo,
                        withActionBtn: true,
                        actionBtnIcon: CupertinoIcons.add,
                        onActionBtnPressed: () {},
                      ),
                    ),
                    FadeInUp(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 10.0),
                        child: Row(
                          children: [
                            for (int i = 0; i < schedules.length; i++) ...[
                              ScheduleTile(
                                isLast: i == schedules.length - 1,
                                item: schedules[i],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 2,
                      ),
                      child: HeadingTitle(
                        title: "Patients à visiter",
                        withActionBtn: false,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    FadeInUp(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: patientsList.length,
                        itemBuilder: ((context, index) {
                          var item = patientsList[index];
                          return MedicDocItemList(
                            item: item,
                          );
                        }),
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
                    ZoomIn(
                      child: SvgPicture.asset(
                        'assets/svg/house-medical.svg',
                        colorFilter: const ColorFilter.mode(
                            Colors.white, BlendMode.srcIn),
                        height: 25.0,
                      ),
                    ),
                    JelloIn(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 30.0,
                            fontFamily: 'Staatliches',
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
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
                    ),
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

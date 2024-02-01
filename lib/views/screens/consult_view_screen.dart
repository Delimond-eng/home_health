import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import '../widgets/custom_expandable_card.dart';
import '../widgets/heading_title.dart';
import '../widgets/identity_item.dart';
import '../widgets/medic_action_btn.dart';
import '../widgets/medic_doc_item.dart';
import 'consult_make_screen.dart';

class ConsultViewScreen extends StatefulWidget {
  const ConsultViewScreen({super.key});

  @override
  State<ConsultViewScreen> createState() => _ConsultViewScreenState();
}

class _ConsultViewScreenState extends State<ConsultViewScreen> {
  int _selectedTab = 0;

  void _onTabChanged(int tab) {
    setState(() {
      _selectedTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _home(context),
      _antecedants(context),
      _consults(context)
    ];
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Column(
        children: [
          _header(context),
          Expanded(
            child: pages.elementAt(_selectedTab),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        selectedItemColor: Colors.indigo,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey[600],
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          fontFamily: 'Poppins',
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          color: Colors.grey[600],
        ),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/svg/chart.svg"),
            label: "Acceuil",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/svg/antecedent.svg",
              height: 24.0,
            ),
            label: "Antécedents",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/svg/svg-3.svg",
              height: 25.0,
            ),
            label: "Consultations",
          ),
        ],
        currentIndex: _selectedTab,
        onTap: _onTabChanged,
      ),
    );
  }

  Widget _home(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: HeadingTitle(
              title: "Actions médicales",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FadeInUp(
              child: Row(
                children: [
                  Flexible(
                    child: MedicActionBtn(
                      onPressed: () {},
                      color: Colors.blue,
                      title: "Premiers soins",
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Flexible(
                    child: MedicActionBtn(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ConsultMakeScreen(),
                          ),
                        );
                      },
                      color: Colors.green,
                      title: "Consultation",
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: HeadingTitle(title: "Identité du patient"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _identity(context),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: HeadingTitle(title: "Bilan graphique du patient"),
          ),
          const SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }

  Widget _antecedants(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: HeadingTitle(title: "Antécedents"),
        ),
        Expanded(
          child: FadeInUp(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset("assets/animateds/patient.json"),
                  const CustomExpandableCard(title: "Antécedents personnels"),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const CustomExpandableCard(title: "Antécedents familiaux"),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const CustomExpandableCard(title: "Antécedents chirurgicaux"),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _consults(BuildContext context) {
    return FadeInUp(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: HeadingTitle(
              title: "Consultations",
            ),
          ),
          Expanded(
            child: FadeInUp(
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(8.0),
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .95,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemBuilder: (context, index) {
                  return MedicDocItem(
                    statusColor: index.isEven ? Colors.orange : Colors.green,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _identity(context) {
    return FadeInUp(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100.0,
                width: 100.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  image: const DecorationImage(
                    image: AssetImage("assets/imgs/avatar1.jpg"),
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              const Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: IdentityItem(
                            title: "Nom",
                            value: "Gaston Delimond",
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                            child: IdentityItem(
                          title: "Post-nom",
                          value: "Kayembe",
                        )),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          const Row(
            children: [
              Flexible(
                  child: IdentityItem(
                title: "Prenom",
                value: "Delimond",
              )),
            ],
          ),
          const Row(
            children: [
              Flexible(
                  child: IdentityItem(
                title: "âge",
                value: "28",
              )),
              SizedBox(
                width: 5.0,
              ),
              Flexible(
                child: IdentityItem(
                  title: "Sexe",
                  value: "Masculin",
                ),
              ),
            ],
          ),
        ],
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
                      "Dossier médical",
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

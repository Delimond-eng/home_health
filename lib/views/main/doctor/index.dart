import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_health/global/controllers.dart';
import 'package:home_health/views/pages/patient_page.dart';
import 'package:home_health/views/pages/schedule_doctor_page.dart';

import '../../pages/home_doctor_page.dart';

class DoctorHome extends StatefulWidget {
  const DoctorHome({super.key});

  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  int currentPage = 0;
  final List<Widget> _pages = [
    const HomeDoctorPage(),
    const PagePatient(),
    const DoctorSchedulePage(),
    const Center(
      child: Text("Profil"),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(currentPage),
      backgroundColor: Colors.grey.shade200,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 2.0,
        iconSize: 20.0,
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
          fontWeight: FontWeight.w400,
          color: Colors.grey[600],
        ),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/svg/menu-2.svg",
              height: 22.0,
            ),
            activeIcon: JelloIn(
              child: SvgPicture.asset(
                "assets/svg/menu-2.svg",
                colorFilter:
                    const ColorFilter.mode(Colors.indigo, BlendMode.srcIn),
                height: 22.0,
              ),
            ),
            label: "Acceuil",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/svg/patient.svg", height: 22.0),
            activeIcon: JelloIn(
              child: SvgPicture.asset(
                "assets/svg/patient.svg",
                height: 22.0,
                colorFilter:
                    const ColorFilter.mode(Colors.indigo, BlendMode.srcIn),
              ),
            ),
            label: "Patients",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/svg/calendar.svg", height: 22.0),
            activeIcon: JelloIn(
              child: SvgPicture.asset(
                "assets/svg/calendar.svg",
                height: 22.0,
                colorFilter:
                    const ColorFilter.mode(Colors.indigo, BlendMode.srcIn),
              ),
            ),
            label: "Mes visites",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/svg/profile.svg"),
            activeIcon: JelloIn(
              child: SvgPicture.asset("assets/svg/profile.svg",
                  colorFilter:
                      const ColorFilter.mode(Colors.indigo, BlendMode.srcIn)),
            ),
            label: "Profil",
          ),
        ],
        currentIndex: currentPage,
        onTap: (index) {
          dataController.initDoctorData();
          setState(() {
            currentPage = index;
          });
        },
      ),
    );
  }
}

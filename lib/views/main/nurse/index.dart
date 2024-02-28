import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_health/global/controllers.dart';
import 'package:home_health/views/pages/nurse_report_page.dart';
import 'package:home_health/views/pages/schedule_nurse_page.dart';
import '../../pages/home_nurse_page.dart';
import 'package:animate_do/animate_do.dart';

class NurseHome extends StatefulWidget {
  const NurseHome({super.key});

  @override
  State<NurseHome> createState() => _NurseHomeState();
}

class _NurseHomeState extends State<NurseHome> {
  int currentPage = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    const ScheduleNursePage(),
    const NurseReportPage(),
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
        elevation: 1.0,
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
              "assets/svg/dashboard-1.svg",
              height: 22.0,
            ),
            activeIcon: JelloIn(
              child: SvgPicture.asset(
                "assets/svg/dashboard-1.svg",
                colorFilter:
                    const ColorFilter.mode(Colors.indigo, BlendMode.srcIn),
                height: 22.0,
              ),
            ),
            label: "Acceuil",
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
            label: "Agenda",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/svg/report-2.svg", height: 22.0),
            activeIcon: JelloIn(
              child: SvgPicture.asset(
                "assets/svg/report-2.svg",
                height: 22.0,
                colorFilter:
                    const ColorFilter.mode(Colors.indigo, BlendMode.srcIn),
              ),
            ),
            label: "Rapports",
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
          if (index == 0) {
            nurseDataController.viewHomeData();
          }
          if (index == 1) {
            nurseDataController.refreshSchedule();
          }
          setState(() {
            currentPage = index;
          });
        },
      ),
    );
  }
}

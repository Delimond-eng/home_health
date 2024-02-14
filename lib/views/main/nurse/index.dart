import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../pages/home_nurse_page.dart';
import 'package:animate_do/animate_do.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  int currentPage = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    const Center(
      child: Text("Visites faites"),
    ),
    const Center(
      child: Text("Reports"),
    ),
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
          fontWeight: FontWeight.w600,
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
            icon: SvgPicture.asset("assets/svg/check-double.svg", height: 22.0),
            activeIcon: JelloIn(
              child: SvgPicture.asset(
                "assets/svg/check-double.svg",
                height: 22.0,
                colorFilter:
                    const ColorFilter.mode(Colors.indigo, BlendMode.srcIn),
              ),
            ),
            label: "Visites faites",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/svg/chart-square.svg", height: 22.0),
            activeIcon: JelloIn(
              child: SvgPicture.asset(
                "assets/svg/chart-square.svg",
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
          setState(() {
            currentPage = index;
          });
        },
      ),
    );
  }
}

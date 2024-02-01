import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import './screens/home_screen.dart';

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
      child: Text("Schedule"),
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
            label: "Acceuil",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/svg/calendarr.svg", height: 22.0),
            label: "Agenda",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/svg/profile.svg"),
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

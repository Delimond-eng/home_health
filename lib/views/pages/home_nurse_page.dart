import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_health/global/controllers.dart';
import 'package:home_health/views/widgets/user_avatar.dart';
import '../widgets/app_logo.dart';
import '../widgets/empty_loader.dart';
import '../widgets/heading_title.dart';
import '../widgets/medic_doc_item.dart';
import '../widgets/schedule_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              child: Obx(
                () => SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 2,
                        ),
                        child: HeadingTitle(
                          title: "Visites déléguées",
                          color: Colors.indigo,
                        ),
                      ),
                      if (nurseDataController.delegates.isEmpty) ...[
                        SizedBox(
                          height: 120,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            margin: const EdgeInsets.all(10.0),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/imgs/empty.png",
                                    height: 40.0,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  const SizedBox(
                                    height: 4.0,
                                  ),
                                  Text(
                                    "Aucune visite déléguée !",
                                    textScaleFactor: .8,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey.shade600,
                                      fontSize: 12.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ] else
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10.0),
                          child: Row(
                            children: [
                              for (int i = 0;
                                  i < nurseDataController.delegates.length;
                                  i++) ...[
                                ScheduleTileDelegate(
                                  isLast: i ==
                                      nurseDataController.delegates.length - 1,
                                  item: nurseDataController.delegates[i],
                                ),
                              ],
                            ],
                          ),
                        ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 2,
                        ),
                        child: HeadingTitle(
                          title: "Liste des patients à visiter",
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      if (nurseDataController.visits.isNotEmpty) ...[
                        ListView.builder(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: nurseDataController.visits.length,
                          itemBuilder: ((context, index) {
                            var item = nurseDataController.visits[index];
                            return MedicDocItemList(
                              item: item,
                            );
                          }),
                        )
                      ] else ...[
                        const EmptyLoader(
                          message: "Aucune visite à domicile disponible !",
                        )
                      ]
                    ],
                  ),
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
        child: const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [AppLogo(), UserAvatar()],
            ),
          ),
        ),
      ),
    );
  }
}

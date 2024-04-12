import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:home_health/global/controllers.dart';

import '../../models/nurse.dart';
import '../../models/schedule.dart';
import '../widgets/empty_loader.dart';
import '../widgets/login_field.dart';
import '../widgets/user_avatar.dart';
import 'subpages/visit_detail_page.dart';

class DoctorSchedulePage extends StatefulWidget {
  const DoctorSchedulePage({super.key});

  @override
  State<DoctorSchedulePage> createState() => _DoctorSchedulePageState();
}

class _DoctorSchedulePageState extends State<DoctorSchedulePage> {
  Nurse? selectedNurse;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Column(
          children: [
            _header(context),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Flexible(
                    child: LoginField<Nurse>(
                      icon: "filter-1",
                      hintText: "Filtrez par infirmier...",
                      dropdownItems: dataController.nurses,
                      isDropdown: true,
                      dropdownValue: selectedNurse,
                      onDropdownChanged: (nurse) {
                        dataController.viewAllVisitsByDoctor(
                            nurseId: nurse!.id!);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    height: 48.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        gradient: LinearGradient(
                            colors: [Colors.indigo, Colors.indigo.shade300])),
                    child: Material(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(5.0),
                        onTap: () {
                          dataController.viewAllVisitsByDoctor();
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              Text(
                                'Tout',
                                style: TextStyle(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: dataController.dataLoading.value ||
                      dataController.allVisits.isEmpty
                  ? const EmptyLoader()
                  : ListView.separated(
                      padding: const EdgeInsets.all(10.0),
                      itemCount: dataController.allVisits.length,
                      itemBuilder: (context, index) {
                        var item = dataController.allVisits[index];
                        return DoctorScheduleCard(item: item);
                      },
                      separatorBuilder: (__, _) => const SizedBox(height: 5.0),
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
                    SvgPicture.asset(
                      "assets/svg/calendar.svg",
                      height: 25.0,
                      colorFilter: ColorFilter.mode(
                        Colors.indigo.shade200,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Text(
                      "Mes visites",
                      textScaleFactor: .9,
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                const UserAvatar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DoctorScheduleCard extends StatelessWidget {
  final Visit item;
  const DoctorScheduleCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130.0,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 35.0,
                    width: 35.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.indigo.shade300,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/svg/calendar.svg",
                          height: 22.0,
                          colorFilter: const ColorFilter.mode(
                              Colors.white, BlendMode.srcIn),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Infirmier",
                        style: TextStyle(fontSize: 10.0, color: Colors.indigo),
                      ),
                      Text(
                        item.nurse!.nurseFullname!,
                        textScaleFactor: .8,
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/svg/patient.svg",
                    height: 22,
                    colorFilter:
                        const ColorFilter.mode(Colors.indigo, BlendMode.srcIn),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    item.patient!.patientFullname!,
                    textScaleFactor: .8,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month_outlined,
                                size: 15.0,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                item.visitDate!,
                                textScaleFactor: .8,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  PopupMenuButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    elevation: 4,
                    itemBuilder: (BuildContext context) {
                      return [
                        const PopupMenuItem(
                          value: 'detail',
                          child: Row(
                            children: [
                              Icon(
                                CupertinoIcons.arrow_down_right_square,
                                size: 15.0,
                              ),
                              SizedBox(
                                width: 4.0,
                              ),
                              Text(
                                'Voir les détails',
                                textScaleFactor: .8,
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(
                                CupertinoIcons.delete,
                                size: 15.0,
                              ),
                              SizedBox(
                                width: 4.0,
                              ),
                              Text(
                                'Supprimer',
                                textScaleFactor: .8,
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ],
                          ),
                        ),
                      ];
                    },
                    icon: Container(
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade100,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      padding: const EdgeInsets.all(2),
                      child: const Icon(Icons.more_horiz),
                    ),
                    onSelected: (value) {
                      switch (value) {
                        case 'detail':
                          dataController.selectedVisit.value = item;
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const VisitDetailPage(),
                            ),
                          );
                          break;
                        default:
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

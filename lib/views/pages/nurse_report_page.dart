import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:home_health/global/controllers.dart';
import 'package:home_health/views/widgets/empty_loader.dart';
import 'package:home_health/views/widgets/schedule_filter.dart';
import '../widgets/report_card.dart';
import '../widgets/user_avatar.dart';

class NurseReportPage extends StatefulWidget {
  const NurseReportPage({super.key});

  @override
  State<NurseReportPage> createState() => _NurseReportPageState();
}

class _NurseReportPageState extends State<NurseReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.picture_as_pdf,
          size: 20.0,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          _header(context),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.filter_list,
                      color: Colors.indigo,
                      size: 17.0,
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      "Filter",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ScheduleFilter(
                  onSelected: (val) {
                    var word = translate(val!);
                    nurseDataController.refreshReport(key: word);
                  },
                )
              ],
            ),
          ),
          Obx(
            () => Expanded(
              child: nurseDataController.reports.isEmpty
                  ? const EmptyLoader(
                      message: "Aucun rapport de visite disponible !",
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: nurseDataController.reports.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var item = nurseDataController.reports[index];
                        return ReportCard(item: item);
                      },
                      separatorBuilder: (__, _) => const SizedBox(height: 5.0),
                    ),
            ),
          )
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
                    SvgPicture.asset(
                      "assets/svg/report.svg",
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
                      "Rapport des visites",
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

  String translate(String key) {
    switch (key.toLowerCase()) {
      case "tout":
        return "all";
      case "jour":
        return "day";
      case "semaine":
        return "week";
      case "mois":
        return "month";
      default:
        return "all";
    }
  }
}

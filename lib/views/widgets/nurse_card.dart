// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_health/global/controllers.dart';
import 'package:home_health/services/api.manger.dart';
import 'package:home_health/views/pages/subpages/doctor_report_page.dart';

import '../../models/nurse.dart';

class NurseCard extends StatelessWidget {
  final bool isLast;
  final Nurse item;
  const NurseCard({
    super.key,
    this.isLast = false,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isLast ? Colors.transparent : Colors.grey.shade300,
            width: 0.5,
          ),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
        title: Text(
          item.nurseFullname!,
          textScaleFactor: .8,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text(
          "Infirmier",
          textScaleFactor: .8,
        ),
        leading: Container(
          height: 35.0,
          width: 35.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.indigo.shade300,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/svg/profile.svg",
                height: 22.0,
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ],
          ),
        ),
        trailing: PopupMenuButton(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(
                value: 'detail',
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.chart_bar_circle,
                      size: 15.0,
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      'Voir les rapports',
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
                      CupertinoIcons.trash,
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
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(5.0),
            ),
            padding: const EdgeInsets.all(2),
            child: const Icon(Icons.more_horiz),
          ),
          onSelected: (action) async {
            // Handle menu item selection
            switch (action) {
              case "detail":
                EasyLoading.show(
                  status: 'Chargement...',
                  maskType: EasyLoadingMaskType.black,
                );
                var model =
                    await ApiManager.viewReportByNurse(nurseId: item.id);
                EasyLoading.dismiss();
                dataController.reports.value = model.reports!;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DoctorReportPage(nurse: item),
                  ),
                );
                break;
              default:
            }
          },
        ),
      ),
    );
  }
}

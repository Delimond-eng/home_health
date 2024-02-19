import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:home_health/global/controllers.dart';

import '../../models/patient.dart';
import '../widgets/user_avatar.dart';

class PagePatient extends StatefulWidget {
  const PagePatient({super.key});

  @override
  State<PagePatient> createState() => _PagePatientState();
}

class _PagePatientState extends State<PagePatient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        _header(context),
        Expanded(
          child: Obx(
            () => ListView.separated(
              padding: const EdgeInsets.all(10),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: dataController.patients.length,
              separatorBuilder: (__, _) => const SizedBox(height: 6.0),
              itemBuilder: ((context, index) {
                var item = dataController.patients[index];
                return PatientItemList(
                  item: item,
                );
              }),
            ),
          ),
        )
      ],
    ));
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
                      "assets/svg/group-patients.svg",
                      height: 30.0,
                      colorFilter: ColorFilter.mode(
                        Colors.indigo.shade200,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Text(
                      "Mes Patients",
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

class PatientItemList extends StatelessWidget {
  final Patient item;
  const PatientItemList({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        title: Text(item.patientFullname!),
        subtitle: Row(
          children: [
            SvgPicture.asset(
              "assets/svg/location-place.svg",
              height: 20.0,
              colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
            ),
            const SizedBox(width: 5.0),
            Flexible(
              child: Text(
                item.patientAddress!,
                style: const TextStyle(
                  fontSize: 12.0,
                ),
              ),
            )
          ],
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
                "assets/svg/patient.svg",
                height: 22.0,
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ],
          ),
        ),
        trailing: PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(
                value: 'detail',
                child: Text(
                  'Voir détails',
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text(
                  'Supprimer',
                  style: TextStyle(fontSize: 12.0),
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
            // Handle menu item selection
            print('Selected: $value');
          },
        ),
      ),
    );
  }
}

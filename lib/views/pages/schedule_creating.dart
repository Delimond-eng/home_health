import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_health/global/controllers.dart';
import 'package:home_health/models/nurse.dart';
import 'package:home_health/models/patient.dart';
import 'package:home_health/views/widgets/login_field.dart';

import '../../services/api.manger.dart';
import '../widgets/heading_title.dart';
import '../widgets/submit_button_loader.dart';
import '../widgets/user_avatar.dart';
import 'package:intl/intl.dart';

class ScheduleCreating extends StatefulWidget {
  const ScheduleCreating({super.key});

  @override
  State<ScheduleCreating> createState() => _ScheduleCreatingState();
}

class _ScheduleCreatingState extends State<ScheduleCreating> {
  Patient? selectedPatient;
  Nurse? selectedNurse;
  String? date;
  String? hour;
  bool isLoading = false;

  List<TextEditingController> fieldControllers = [
    TextEditingController(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _header(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 2,
                    ),
                    child: HeadingTitle(
                      title: "Informations personnelles",
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  LoginField<Nurse>(
                    hintText: "Sélectionnez l'infirmier concerné *",
                    icon: "nurse",
                    dropdownItems: dataController.nurses,
                    dropdownValue: selectedNurse,
                    isDropdown: true,
                    onDropdownChanged: (val) {
                      setState(() {
                        selectedNurse = val;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  LoginField<Patient>(
                    hintText: "Sélectionnez le patient concerné *",
                    isDropdown: true,
                    icon: "patient",
                    dropdownValue: selectedPatient,
                    dropdownItems: dataController.patients,
                    onDropdownChanged: (val) {
                      setState(() {
                        selectedPatient = val;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  DateHourPicker(
                    icon: "calendar",
                    date: date,
                    hour: hour,
                    onPickedDate: (v) {
                      setState(() {
                        date = v;
                      });
                    },
                    onPickedHour: (v) {
                      setState(() {
                        hour = v;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 2,
                    ),
                    child: HeadingTitle(
                      title: "Soins & services à prodiguer",
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 20.0,
                      ),
                      child: Column(
                        children: [
                          for (int i = 0; i < fieldControllers.length; i++) ...[
                            InputSoin(
                              controller: fieldControllers[i],
                              isLast: i == 0,
                              onAddField: () {
                                setState(() {
                                  fieldControllers.add(TextEditingController());
                                });
                              },
                              onClearField: () {
                                int index = fieldControllers.length - 1;
                                if (index != 0) {
                                  setState(() {
                                    fieldControllers.removeAt(i);
                                  });
                                }
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ]
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width,
                    child: SubmitBtnLoader(
                      isLoading: isLoading,
                      label: "Sauvegarder",
                      color: Colors.green,
                      onPressed: () {
                        if (selectedNurse == null) {
                          EasyLoading.showToast(
                              "Veuillez sélectionner un infirmier !");
                          return;
                        }
                        if (selectedPatient == null) {
                          EasyLoading.showToast(
                              "Veuillez sélectionner un patient !");
                          return;
                        }
                        if (date == null && hour == null) {
                          EasyLoading.showToast(
                              "Veuillez spécifier la date & l'heure de la visite !");
                          return;
                        }
                        List<Map<String, dynamic>> data = [];
                        for (var controller in fieldControllers) {
                          if (controller.text.isNotEmpty) {
                            data.add({"libelle": controller.text});
                          }
                        }
                        if (data.isEmpty) {
                          EasyLoading.showToast(
                              "Veuillez spécifier les soins et services à prodiguer lors de la visite !");
                          return;
                        }
                        setState(() => isLoading = true);
                        ApiManager.createSchedule(
                          data: {
                            "date": "$date $hour",
                            "nurse_id": selectedNurse!.id,
                            "patient_id": selectedPatient!.id,
                            "treatments": data,
                          },
                        ).then((res) {
                          setState(() => isLoading = false);
                          if (res != null) {
                            EasyLoading.showSuccess(
                                "Rendez-vous ou visite à domicile créé avec succès");
                            cleanField();
                          }
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
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
                              "assets/svg/arrow-back.svg",
                              // ignore: deprecated_member_use
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      "Création agenda infirmier",
                      textScaleFactor: .9,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    )
                  ],
                ),
                const UserAvatar()
              ],
            ),
          ),
        ),
      ),
    );
  }

  void cleanField() {
    Patient? p;
    Nurse? n;
    setState(() {
      selectedPatient = p;
      selectedNurse = n;
      date = null;
      hour = null;
      fieldControllers = [
        TextEditingController(),
      ];
    });
  }
}

class InputSoin extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback? onAddField;
  final VoidCallback? onClearField;
  final bool isLast;
  const InputSoin(
      {super.key,
      this.controller,
      this.isLast = false,
      this.onAddField,
      this.onClearField});

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.left,
      maxLines: null,
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Entrez le soin ou service à prodiguer...',
        labelText: 'Soin ou service',
        hintStyle: const TextStyle(fontSize: 10.0, color: Colors.grey),
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            5,
          ),
        ),
        contentPadding: const EdgeInsets.all(
          16.0,
        ),
        suffixIcon: isLast
            ? IconButton(
                icon: const Icon(Icons.add),
                iconSize: 17.0,
                onPressed: onAddField,
                color: Colors.blue,
              )
            : IconButton(
                icon: const Icon(Icons.close),
                iconSize: 17.0,
                onPressed: onClearField,
                color: Colors.red,
              ),
      ),
    );
  }
}

class DateHourPicker extends StatelessWidget {
  final String? icon;
  final Function(String? v)? onPickedDate;
  final Function(String? v)? onPickedHour;
  final String? date, hour;
  const DateHourPicker(
      {super.key,
      this.icon,
      this.onPickedDate,
      this.onPickedHour,
      this.date,
      this.hour});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () async {
              var date = await showDatePicked(context);
              onPickedDate!.call(date);
            },
            child: Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/svg/$icon.svg",
                          height: 18.0,
                          colorFilter: const ColorFilter.mode(
                              Colors.indigo, BlendMode.srcIn),
                        ),
                        const SizedBox(width: 5.0),
                        if (date != null) ...[
                          Text(
                            date!,
                            textScaleFactor: .8,
                          )
                        ] else ...[
                          const Text(
                            "Sélectionnez une date",
                            textScaleFactor: .8,
                          )
                        ]
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: () async {
            var time = await selectTime(context);
            onPickedHour!.call(time);
          },
          child: Container(
            height: 50.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/svg/time-add.svg",
                    height: 18.0,
                    colorFilter:
                        const ColorFilter.mode(Colors.indigo, BlendMode.srcIn),
                  ),
                  const SizedBox(width: 5.0),
                  if (hour != null) ...[
                    Text(
                      hour!,
                      textScaleFactor: .8,
                    ),
                  ] else ...[
                    const Text(
                      "--:--",
                      textScaleFactor: .8,
                    )
                  ]
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

Future showDatePicked(BuildContext context) async {
  var date = await showDatePicker(
    locale: const Locale("fr", "FR"),
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1950),
    lastDate: DateTime(2050),
  );
  if (date != null) {
    DateTime dateConverted = DateTime(date.year, date.month, date.day);
    String converted = DateFormat("yyyy-MM-dd").format(dateConverted);
    return converted;
  }
  return null;
}

Future selectTime(BuildContext context) async {
  TimeOfDay selectedTime = TimeOfDay.now();
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: selectedTime,
  );

  if (picked != null && picked != selectedTime) {
    return "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";
  } else {
    return null;
  }
}

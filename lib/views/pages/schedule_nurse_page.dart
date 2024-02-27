import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:home_health/global/controllers.dart';
import 'package:home_health/views/widgets/empty_loader.dart';
import '../../models/schedule.dart';
import '../widgets/user_avatar.dart';
import 'patient_traitment_page.dart';

class ScheduleNursePage extends StatefulWidget {
  const ScheduleNursePage({super.key});

  @override
  State<ScheduleNursePage> createState() => _ScheduleNursePageState();
}

class _ScheduleNursePageState extends State<ScheduleNursePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _header(context),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: EasyDateTimeLine(
              initialDate: DateTime.now(),
              onDateChange: (selectedDate) {
                var date =
                    "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
                nurseDataController.refreshSchedule(date: date);
              },
              headerProps: const EasyHeaderProps(
                monthPickerType: MonthPickerType.switcher,
                dateFormatter: DateFormatter.fullDateDMY(),
                monthStyle: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.indigo,
                ),
                selectedDateStyle: TextStyle(
                  color: Colors.indigo,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              dayProps: EasyDayProps(
                height: 70.0,
                width: 50.0,
                dayStructure: DayStructure.dayStrDayNum,
                activeDayStyle: const DayStyle(
                  dayNumStyle: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  dayStrStyle: TextStyle(
                    fontSize: 10.0,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.indigo,
                        Color(0xff3371FF),
                      ],
                    ),
                  ),
                ),
                todayStyle: DayStyle(
                  dayNumStyle: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                  dayStrStyle: const TextStyle(
                    fontSize: 10.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: Colors.indigo),
                    color: Colors.white,
                  ),
                ),
                inactiveDayStyle: DayStyle(
                  dayNumStyle: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                  dayStrStyle: const TextStyle(
                    fontSize: 10.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: Colors.grey.shade300),
                    color: Colors.white,
                  ),
                ),
              ),
              locale: 'Fr',
            ),
          ),
          Obx(
            () => Expanded(
              child: nurseDataController.visits.isEmpty
                  ? const EmptyLoader(
                      message: "Aucune visite pour cette date !",
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: nurseDataController.visits.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var item = nurseDataController.visits[index];
                        return ScheduleCard(item: item);
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
                      "Mon Agenda",
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

class ScheduleCard extends StatelessWidget {
  final Visit item;
  const ScheduleCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 100.0,
          width: MediaQuery.of(context).size.width,
          child: Card(
            margin: EdgeInsets.zero,
            child: Material(
              borderRadius: BorderRadius.circular(4.0),
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(4.0),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PatientTraitmentPage(
                        item: item,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              item.nurse!.nurseFullname!,
                              textScaleFactor: .8,
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/svg/location-place.svg",
                                colorFilter: const ColorFilter.mode(
                                  Colors.blue,
                                  BlendMode.srcIn,
                                ),
                                height: 20,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Flexible(
                                child: Text(
                                  item.patient!.patientAddress!,
                                  textScaleFactor: .8,
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5.0,
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
                                              color: Colors.black,
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
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          child: Container(
            height: 100.0,
            width: 4.0,
            decoration: BoxDecoration(
              color: getColor(item.visitStatus!.toLowerCase()),
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(4.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color getColor(String status) {
    if (status == 'pending') {
      return Colors.grey;
    } else if (status == 'completed') {
      return Colors.green;
    } else if (status == 'delegate') {
      return Colors.blue;
    } else {
      return Colors.red;
    }
  }
}

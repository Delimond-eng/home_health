import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_health/data/mock_data.dart';
import '../widgets/schedule_tile.dart';
import '../widgets/user_avatar.dart';

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
                //`selectedDate` the new date selected.
              },
              headerProps: const EasyHeaderProps(
                monthPickerType: MonthPickerType.switcher,
                dateFormatter: DateFormatter.fullDateDMY(),
              ),
              dayProps: EasyDayProps(
                dayStructure: DayStructure.dayStrDayNum,
                activeDayStyle: const DayStyle(
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
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: Colors.indigo),
                    color: Colors.white,
                  ),
                ),
                inactiveDayStyle: DayStyle(
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
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(8.0),
              itemCount: schedules.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                var item = schedules[index];
                return ScheduleCard(item: item);
              },
              separatorBuilder: (__, _) => const SizedBox(height: 5.0),
            ),
          ),
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
  final Schedule item;
  const ScheduleCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 120.0,
          width: MediaQuery.of(context).size.width,
          child: Card(
            margin: EdgeInsets.zero,
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
                          item.title!,
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
                              item.adresse!,
                              textScaleFactor: .8,
                              style: const TextStyle(
                                fontSize: 15.0,
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
                                        item.dateHour!,
                                        textScaleFactor: .8,
                                        style: TextStyle(
                                          color: item.color,
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
        Positioned(
          left: 0,
          child: Container(
            height: 120.0,
            width: 4.0,
            decoration: BoxDecoration(
              color: item.color!.shade400,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(4.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
